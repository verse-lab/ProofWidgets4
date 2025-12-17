import * as React from 'react';
import { DocumentPosition } from '@leanprover/infoview';


// ========== Types ==========
interface ParsedState {
  index: number;
  tag?: string; // Optional tag associated with this state (e.g. transition/action label)
  fields: Record<string, unknown>;
}
type Trace = ParsedState[];

type ViolationKind = "safety_failure" | "deadlock";

interface EarlyTerminationCondition {
  kind: "found_violating_state" | "deadlock_occurred" | "reached_depth_bound";
  depth?: number;
}

interface TerminationReason {
  kind: "explored_all_reachable_states" | "early_termination";
  condition?: EarlyTerminationCondition;
}

interface TraceData {
  theory: string;
  states: Array<{
    index: number;
    fields: Record<string, unknown>;
    transition: unknown;
  }>;
}

type ModelCheckingResult =
  | {
      result: "found_violation";
      violation_kind: ViolationKind;
      trace: TraceData | null;
    }
  | {
      result: "no_violation_found";
      explored_states: number;
      termination_reason: TerminationReason;
    };

interface ModelCheckerViewProps {
  result: ModelCheckingResult;
  layout?: "vertical" | "horizontal";
}

/** Remove namespace prefixes like A.B.C, keeping only the last segment, e.g., "Mutex.states.start" -> "start" */
// function dequalify(s: string): string {
//   if (!s.includes(".") || /^-?\d+\.\d+$/.test(s)) return s; // Avoid misprocessing decimals
//   const parts = s.split(".");
//   return parts[parts.length - 1] || s;
// }
function dequalify(s: string): string {
  // First split by whitespace
  const parts = s.trim().split(/\s+/);

  const cleaned = parts
    .map((tok) => {
      // Remove surrounding parentheses/commas/etc.
      let t = tok.replace(/^[()\[\]{}:,]+|[()\[\]{}:,]+$/g, "");

      // Numbers (including decimals) are kept as is to avoid mis-splitting
      if (/^-?\d+(?:\.\d+)?$/.test(t)) return t;

      // Remove namespace prefixes for identifiers containing dots, keeping only the last segment
      if (t.includes(".")) {
        const segs = t.split(".");
        t = segs[segs.length - 1] || t;
      }

      return t;
    })
    // Remove potentially empty strings
    .filter((t) => t.length > 0);

  // Join back with spaces
  return cleaned.join(" ");
}


/* ================= Diff helpers: deepEqual + diffChangedKeys ================= */
function deepEqual(a: unknown, b: unknown): boolean {
  if (a === b) return true;
  if (a == null || b == null) return a === b;

  if (Array.isArray(a) && Array.isArray(b)) {
    if (a.length !== b.length) return false;
    for (let i = 0; i < a.length; i++) {
      if (!deepEqual(a[i], b[i])) return false;
    }
    return true;
  }

  if (typeof a === "object" && typeof b === "object") {
    const ao = a as Record<string, unknown>;
    const bo = b as Record<string, unknown>;
    const ak = Object.keys(ao);
    const bk = Object.keys(bo);
    if (ak.length !== bk.length) return false;
    for (const k of ak) {
      if (!(k in bo)) return false;
      if (!deepEqual(ao[k], bo[k])) return false;
    }
    return true;
  }

  return false;
}

/** For arrays, compute which indices have changed between prev and curr */
function diffArrayIndices(prev: unknown[], curr: unknown[]): Set<number> {
  const changed = new Set<number>();
  const maxLen = Math.max(prev.length, curr.length);

  for (let i = 0; i < maxLen; i++) {
    if (i >= prev.length || i >= curr.length) {
      // Element was added or removed
      changed.add(i);
    } else if (!deepEqual(prev[i], curr[i])) {
      // Element changed
      changed.add(i);
    }
  }

  return changed;
}

/** Value change info: either the whole value changed, or specific array indices changed */
type ChangeInfo =
  | { type: 'full' }  // Entire value changed (non-array or structural change)
  | { type: 'array'; changedIndices: Set<number> }  // Array with specific elements changed
  | { type: 'none' };  // No change

/** Compute change information for each field */
function diffChanges(
  prev: Record<string, unknown> | undefined,
  curr: Record<string, unknown>
): Map<string, ChangeInfo> {
  const changes = new Map<string, ChangeInfo>();
  if (!prev) return changes; // No previous state for the first frame

  const keys = new Set<string>([...Object.keys(prev), ...Object.keys(curr)]);
  for (const k of keys) {
    const hasA = k in prev;
    const hasB = k in curr;

    if (!hasA || !hasB) {
      // Key was added or removed
      changes.set(k, { type: 'full' });
      continue;
    }

    const prevVal = (prev as any)[k];
    const currVal = (curr as any)[k];

    if (deepEqual(prevVal, currVal)) {
      // No change
      continue;
    }

    // Check if both are arrays
    if (Array.isArray(prevVal) && Array.isArray(currVal)) {
      const changedIndices = diffArrayIndices(prevVal, currVal);
      if (changedIndices.size > 0) {
        changes.set(k, { type: 'array', changedIndices });
      }
    } else {
      // Non-array changed, or type changed between array and non-array
      changes.set(k, { type: 'full' });
    }
  }

  return changes;
}

/* ===================== Render ===================== */

/** Concatenate React node securely, without introducing extra whitespace */
function joinNodes(nodes: React.ReactNode[], sep: React.ReactNode = ', '): React.ReactNode {
  const out: React.ReactNode[] = [];
  nodes.forEach((n, i) => {
    out.push(<span key={`n-${i}`}>{n}</span>);
    if (i < nodes.length - 1) out.push(<span key={`s-${i}`}>{sep}</span>);
  });
  return <>{out}</>;
}

/** Render any value "inline" (arrays also inline as [a, b, ...], not converted to <ul>) */
function renderValueInline(x: unknown, changedIndices?: Set<number>, index?: number): React.ReactNode {
  const isChanged = changedIndices !== undefined && index !== undefined && changedIndices.has(index);

  if (Array.isArray(x)) {
    const elements = x.map((el, i) => renderValueInline(el, changedIndices, i));
    return <code>[{joinNodes(elements)}]</code>;
  }
  if (typeof x === 'object' && x !== null) {
    const content = JSON.stringify(x);
    return isChanged ? <code className="changed-element">{content}</code> : <code>{content}</code>;
  }
  if (typeof x === 'string') {
    const content = dequalify(x);
    return isChanged ? <code className="changed-element">{content}</code> : <code>{content}</code>;
  }
  const content = String(x);
  return isChanged ? <code className="changed-element">{content}</code> : <code>{content}</code>;
}


/** Render a row from an inner array:
 * - If it's length=2, render as `a, b` inline (no brackets)
 * - Otherwise, render the inner array inline as `[a, b, ...]`
 * If not an array, fallback to regular rendering
*/
function renderRowFromInnerArray(e: unknown, changedIndices?: Set<number>, index?: number): React.ReactNode {
  const isChanged = changedIndices !== undefined && index !== undefined && changedIndices.has(index);

  if (Array.isArray(e)) {
    if (e.length === 2) {
      const a = renderValueInline(e[0]);
      const b = renderValueInline(e[1]);
      const code = <code>({a}{', '}{b})</code>;      // ← Two elements in one line separated by a comma
      return isChanged ? <span className="changed-element">{code}</span> : code;
    } else {
      const content = renderValueInline(e);           // ← Other lengths, inline as [ ... ]
      return isChanged ? <span className="changed-element">{content}</span> : content;
    }
  }
  return renderValue(e);
}

/** Original: Inline rendering of flat arrays */
function renderInlineArray(arr: unknown[], changedIndices?: Set<number>): React.ReactNode {
  const parts: React.ReactNode[] = [];
  arr.forEach((e, i) => {
    const isChanged = changedIndices !== undefined && changedIndices.has(i);
    const element = renderValueInline(e);        // Use inline version to avoid converting to <ul>
    parts.push(isChanged ? <span key={i} className="changed-element">{element}</span> : <span key={i}>{element}</span>);
    if (i < arr.length - 1) parts.push(<span key={`comma-${i}`}>, </span>);
  });
  return <code>[{parts}]</code>;
}

function renderValue(v: unknown, changedIndices?: Set<number>): React.ReactNode {
  if (Array.isArray(v)) {
    if (v.length === 0) return <code>[]</code>;

    // (a, b) single tuple: keep inline with parentheses
    const isTuple2 =
      v.length === 2 &&
      !Array.isArray(v[0]) &&
      !Array.isArray(v[1]);
    if (isTuple2) {
      const a = renderValue(v[0]);
      const b = renderValue(v[1]);
      return <code>({a},{' '}{b})</code>;
    }

    // ★ Key rule: As long as the "first-level list contains array elements", render each inner array on a separate line, but inline within the line
    const hasInnerArray = v.some(Array.isArray);
    if (hasInnerArray) {
      return (
        <ul className="list">
          {v.map((e, i) => (
            <li key={i}>{renderRowFromInnerArray(e, changedIndices, i)}</li>
          ))}
        </ul>
      );
    }

    // Inline to [a, b, c]
    return renderInlineArray(v, changedIndices);
  }

  if (typeof v === 'object' && v !== null) {
    return <code>{JSON.stringify(v)}</code>;
  }

  if (typeof v === 'string') {
    return <code>{dequalify(v)}</code>;
  }

  return <code>{String(v)}</code>;
}


function isCollapsibleValue(v: unknown): boolean {
  if (Array.isArray(v)) return true;
  if (typeof v === "object" && v !== null) return true;
  if (typeof v === "string" && (v.includes("\n") || v.length > 60)) return true;
  return false;
}

function previewValue(v: unknown): string {
  if (Array.isArray(v)) {
    if (v.length > 0 && Array.isArray(v[0])) {
      return `Array(${v.length}) of tuples`;
    }
    return `Array(${v.length})`;
  }
  if (typeof v === "object" && v !== null) {
    try {
      return JSON.stringify(v).slice(0, 80) + "…";
    } catch {
      return "[object]";
    }
  }
  if (typeof v === "string") {
    const dq = dequalify(v);
    const s = dq.replace(/\s+/g, " ");
    return s.length > 80 ? s.slice(0, 80) + "…" : s;
  }
  return String(v);
}

const KVRow: React.FC<{ k: string; v: unknown; changeInfo?: ChangeInfo }> = ({
  k,
  v,
  changeInfo,
}) => {
  const collapsible = isCollapsibleValue(v);

  // Highlight the row if there's any change (array or full)
  const hasChange = changeInfo?.type === 'full' || changeInfo?.type === 'array';

  // Start expanded by default
  const [expanded, setExpanded] = React.useState(true);

  // For array changes, pass the indices to the rendering function ONLY when expanded
  const changedIndices =
    expanded && changeInfo?.type === 'array' ? changeInfo.changedIndices : undefined;

  return (
    <div
      className={`kv-row ${collapsible ? "has-toggle" : ""} ${
        hasChange ? "changed" : ""
      }`}
    >
      <div className="kv-key">
        <code>{k}</code>
      </div>
      <div className="kv-sep">↦</div>

      <div className={`kv-val ${expanded ? "expanded" : "collapsed"}`}>
        {collapsible && (
          <button
            className="kv-toggle"
            type="button"
            onClick={() => setExpanded((e) => !e)}
            aria-label={expanded ? "Collapse value" : "Expand value"}
            title={expanded ? "Collapse" : "Expand"}
          >
            {expanded ? "▼" : "▶"}
          </button>
        )}

        <div className="kv-content">
          {expanded ? renderValue(v, changedIndices) : <code>{previewValue(v)}</code>}
        </div>
      </div>
    </div>
  );
};

const StateCard: React.FC<{
  st: ParsedState;
  highlighted?: boolean;
  changes?: Map<string, ChangeInfo>;
}> = ({ st, highlighted = false, changes }) => {
  const [open, setOpen] = React.useState(true);
  const entries = Object.entries(st.fields);

  return (
    <div className={`state-card ${highlighted ? "is-highlighted" : ""}`}>
      <div className="state-header" onClick={() => setOpen((o) => !o)}>
        <div className="state-title">
          <span className="action-chip" title={st.tag ?? ''}>
            {st.tag || '(no action)'}
          </span>
          <span className="state-id">(index: {st.index})</span>
        </div>
        <div className="state-toggle">{open ? "▼" : "▶"}</div>
      </div>

      {open && (
        <div className="state-body">
          <div className="kv-table">
            {entries.map(([k, v]) => (
              <KVRow key={k} k={k} v={v} changeInfo={changes?.get(k)} />
            ))}
          </div>
        </div>
      )}
    </div>
  );
};

/** Collapsible section for displaying theory info */
const TheorySection: React.FC<{ theory: string }> = ({ theory }) => {
  const [expanded, setExpanded] = React.useState(false);

  return (
    <div className="theory-section">
      <div className="theory-header" onClick={() => setExpanded((e) => !e)}>
        <span className="theory-toggle">{expanded ? "▼" : "▶"}</span>
        <span className="theory-label">Theory</span>
      </div>
      {expanded && (
        <div className="theory-content">
          <code>{theory}</code>
        </div>
      )}
    </div>
  );
};

/** Header showing the result status with appropriate icon */
const ResultHeader: React.FC<{
  resultType: "found_violation" | "no_violation_found";
  violationKind?: ViolationKind;
  exploredStates?: number;
  terminationReason?: TerminationReason;
}> = ({ resultType, violationKind, exploredStates, terminationReason }) => {
  if (resultType === "found_violation") {
    const icon = violationKind === "deadlock" ? "🔒" : "⚠️";
    const label = violationKind === "deadlock" ? "Deadlock Detected" : "Safety Violation Found";
    return (
      <div className="result-header result-violation">
        <span className="result-icon">{icon}</span>
        <span className="result-label">{label}</span>
      </div>
    );
  }

  // no_violation_found
  const getTerminationTextWithCount = (reason: TerminationReason | undefined, count: number): string => {
    if (!reason) return `Explored ${count} states`;
    if (reason.kind === "explored_all_reachable_states") {
      return `Explored all reachable states (${count})`;
    }
    if (reason.kind === "early_termination" && reason.condition) {
      switch (reason.condition.kind) {
        case "found_violating_state":
          return `Stopped: found violating state (explored ${count} states)`;
        case "deadlock_occurred":
          return `Stopped: deadlock occurred (explored ${count} states)`;
        case "reached_depth_bound":
          return `Reached depth bound ${reason.condition.depth} (explored ${count} states)`;
        default:
          return `Early termination (explored ${count} states)`;
      }
    }
    return `Explored ${count} states`;
  };

  return (
    <div className="result-header result-success">
      <span className="result-icon">✓</span>
      <span className="result-label">No Violation Found</span>
      <div className="result-details">
        <span>{getTerminationTextWithCount(terminationReason, exploredStates ?? 0)}</span>
      </div>
    </div>
  );
};

/** Format a transition object into a readable string like "action_name (arg1 = val1, arg2 = val2)" */
function formatTransition(transition: unknown): string {
  if (typeof transition === "string") {
    return transition;
  }

  if (typeof transition === "object" && transition !== null) {
    const obj = transition as Record<string, unknown>;
    const keys = Object.keys(obj);

    if (keys.length === 1) {
      // Single key like {"_pre_check_lock": {"self": "0"}}
      let actionName = keys[0];
      // Remove leading underscore if present
      if (actionName.startsWith("_")) {
        actionName = actionName.slice(1);
      }

      const args = obj[keys[0]];
      if (typeof args === "object" && args !== null && !Array.isArray(args)) {
        const argObj = args as Record<string, unknown>;
        const argKeys = Object.keys(argObj);
        if (argKeys.length > 0) {
          const formatValue = (v: unknown): string => {
            if (typeof v === "string") return v;
            if (typeof v === "number" || typeof v === "boolean") return String(v);
            return JSON.stringify(v);
          };
          const argStr = argKeys
            .map((k) => `${k} = ${formatValue(argObj[k])}`)
            .join(", ");
          return `${actionName}(${argStr})`;
        }
      }

      return actionName;
    }
  }

  // Fallback to JSON stringify
  return JSON.stringify(transition);
}

/** Helper to convert TraceData states to ParsedState format */
function traceDataToStates(traceData: TraceData): ParsedState[] {
  return traceData.states.map((st) => ({
    index: st.index,
    tag: formatTransition(st.transition),
    fields: st.fields,
  }));
}

const ModelCheckerView: React.FC<ModelCheckerViewProps> = ({
  result,
  layout = "vertical",
}) => {
  const isVertical = layout === "vertical";

  const styles = `
    .mc-root {
      font-family: system-ui, -apple-system, sans-serif;
      max-width: 100%;
      overflow: auto;
    }
    .mc-trace.vertical {
      display: flex;
      flex-direction: column;
      gap: 8px;
      padding: 8px;
    }
    .mc-trace.horizontal {
      display: flex;
      flex-direction: row;
      gap: 8px;
      padding: 8px;
      overflow-x: auto;
    }
    .mc-summary {
      margin: 12px 8px;
      padding: 8px 12px;
      background: var(--vscode-editorWidget-background);
      border: 1px solid var(--vscode-panel-border);
      border-radius: 4px;
    }
    .state-card {
      --border: var(--vscode-panel-border);
      --header: var(--vscode-editorGroupHeader-tabsBackground);
      --mono: ui-monospace, SFMono-Regular, Menlo, Consolas, "Liberation Mono", monospace;
      background: var(--vscode-editorWidget-background);
      border: 1px solid var(--border);
      border-radius: 6px;
      min-width: 320px;
      max-width: 720px;
      box-shadow: 0 1px 2px rgba(0,0,0,.08);
      overflow: hidden;
    }
    .state-card.is-highlighted {
      outline: 2px solid var(--vscode-editor-selectionHighlightBorder);
      box-shadow: 0 0 0 3px var(--vscode-editor-selectionBackground);
    }
    .state-header {
      background: var(--header);
      border-bottom: 1px solid var(--border);
      padding: 6px 10px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      font-weight: 600;
      cursor: pointer;
    }
    .state-title {
      display: flex;
      gap: 6px;
      align-items: baseline;
    }
    .state-id { font-size: 12px; color: var(--vscode-descriptionForeground); }
    .state-toggle { font-size: 12px; color: var(--vscode-descriptionForeground); user-select: none; }
    .action-chip {
      display: inline-block;
      font-family: var(--mono);
      font-size: 11px;
      font-weight: normal;
      background: var(--vscode-activityBarBadge-background);
      color: var(--vscode-activityBarBadge-foreground);
      border: 1px solid var(--vscode-activityBarBadge-foreground);
      border-radius: 999px;
      padding: 2px 8px;
      line-height: 1.4;
    }
    .state-body { padding: 10px; }
    .kv-table {
      border: 1px solid var(--border);
      border-radius: 4px;
      overflow: hidden;
    }
    .kv-row {
      display: grid;
      grid-template-columns: 1fr auto 2fr;
      gap: 8px;
      padding: 4px 10px;
      align-items: baseline;
      border-bottom: 1px solid var(--vscode-panel-border);
      background: var(--vscode-editor-background);
      transition: background-color .15s ease, border-left-color .15s ease;
      border-left: 3px solid transparent;
    }
    .kv-row:last-child { border-bottom: none; }
    .kv-row.changed {
      background: var(--vscode-editor-findMatchHighlightBackground);
      border-left: 3px solid var(--vscode-editor-findMatchHighlightBorder);
      color: var(--vscode-editor-foreground);
    }
    .changed-element {
      background: var(--vscode-editor-findMatchBackground);
      border-radius: 3px;
      padding: 2px 4px;
      box-shadow: 0 0 0 2px var(--vscode-editor-findMatchBorder);
      color: var(--vscode-editor-foreground);
    }
    .kv-key {
      font-family: var(--mono);
      background: transparent;
      word-break: break-all;
      font-size: 11px;
    }
    .kv-sep { color: var(--vscode-descriptionForeground); background: transparent; }
    .kv-val {
      font-family: var(--mono);
      font-size: 11px;
      background: transparent;
      word-break: break-all;
      display: flex; align-items: flex-start; gap: 6px;
    }
    .kv-toggle {
      border: none; background: transparent; font-size: 12px; line-height: 1;
      cursor: pointer; color: var(--vscode-descriptionForeground); padding: 0 2px;
    }
    .kv-val.collapsed .kv-content code {
      white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 100%;
    }
    // .kv-content { display: block; }
    ul.list {
      margin: 4px 0 0 1rem;
      padding: 0;
      list-style-position: outside;
    }
    ul.list li {
      font-family: var(--mono);
      font-size: 11px;
      line-height: 1.4;
      background: transparent;
      color: var(--vscode-foreground);
      margin: 2px 0;
    }
    code {
      background: transparent;
      color: var(--vscode-foreground);
      padding: 2px 4px;
      border-radius: 3px;
      font-family: var(--mono);
    }
    .kv-val.collapsed .kv-content code {
      white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 100%;
    }
    .kv-content { display: block; }
    .action-chip { cursor: help; }
    .result-header {
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 12px 16px;
      margin: 8px;
      border-radius: 6px;
      font-weight: 600;
      flex-wrap: wrap;
    }
    .result-violation {
      background: var(--vscode-inputValidation-errorBackground);
      border: 1px solid var(--vscode-inputValidation-errorBorder);
      color: var(--vscode-inputValidation-errorForeground, var(--vscode-foreground));
    }
    .result-success {
      background: var(--vscode-inputValidation-infoBackground);
      border: 1px solid var(--vscode-inputValidation-infoBorder);
      color: var(--vscode-inputValidation-infoForeground, var(--vscode-foreground));
    }
    .result-icon { font-size: 18px; }
    .result-label { font-size: 14px; }
    .result-details {
      width: 100%;
      font-size: 12px;
      font-weight: normal;
      color: var(--vscode-descriptionForeground);
      margin-top: 4px;
    }
    .theory-section {
      margin: 8px;
      border: 1px solid var(--vscode-panel-border);
      border-radius: 6px;
      background: var(--vscode-editorWidget-background);
    }
    .theory-header {
      display: flex;
      align-items: center;
      gap: 6px;
      padding: 8px 12px;
      cursor: pointer;
      font-weight: 600;
      font-size: 13px;
    }
    .theory-toggle {
      font-size: 12px;
      color: var(--vscode-descriptionForeground);
    }
    .theory-label {
      color: var(--vscode-foreground);
    }
    .theory-content {
      padding: 8px 12px;
      border-top: 1px solid var(--vscode-panel-border);
      font-family: ui-monospace, SFMono-Regular, Menlo, Consolas, "Liberation Mono", monospace;
      font-size: 12px;
      white-space: pre-wrap;
      word-break: break-all;
    }
  `;

  // Handle the two result types
  if (result.result === "no_violation_found") {
    return (
      <>
        <style>{styles}</style>
        <div className="mc-root">
          <ResultHeader
            resultType="no_violation_found"
            exploredStates={result.explored_states}
            terminationReason={result.termination_reason}
          />
        </div>
      </>
    );
  }

  // result.result === "found_violation"
  const trace = result.trace ? traceDataToStates(result.trace) : [];
  const theory = result.trace?.theory;

  return (
    <>
      <style>{styles}</style>
      <div className="mc-root">
        <ResultHeader
          resultType="found_violation"
          violationKind={result.violation_kind}
        />

        {theory && <TheorySection theory={theory} />}

        {trace.length > 0 ? (
          <>
            <div className={`mc-trace ${isVertical ? "vertical" : "horizontal"}`}>
              {trace.map((s: ParsedState, idx: number) => {
                const prev = idx > 0 ? trace[idx - 1].fields : undefined;
                const changes = diffChanges(prev, s.fields);
                return <StateCard key={s.index} st={s} changes={changes} />;
              })}
            </div>

            <div className="mc-summary">
              <strong>Summary:</strong> {trace.length} states in trace
            </div>
          </>
        ) : (
          <div className="mc-summary">
            <strong>No trace available</strong>
          </div>
        )}
      </div>
    </>
  );
};

export default ModelCheckerView;
