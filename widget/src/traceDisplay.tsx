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

interface Violation {
  kind: ViolationKind;
  violates?: string[]; // Array of violated property names (only present for safety_failure)
}

interface EarlyTerminationCondition {
  kind: "found_violating_state" | "deadlock_occurred" | "reached_depth_bound";
  depth?: number;
}

interface TerminationReason {
  kind: "explored_all_reachable_states" | "early_termination";
  condition?: EarlyTerminationCondition;
}

interface TraceData {
  theory: Record<string, unknown>;
  states: Array<{
    index: number;
    fields: Record<string, unknown>;
    transition: unknown;
  }>;
}

type ModelCheckingResult =
  | {
      result: "found_violation";
      violation: Violation;
      trace: TraceData | null;
    }
  | {
      result: "no_violation_found";
      explored_states: number;
      termination_reason: TerminationReason;
      trace?: TraceData | null;
    }
  | {
      // Trace-only data without a result (for displaying execution traces)
      trace: TraceData;
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

/** Merged element for array diff display */
interface MergedElement {
  element: unknown;
  status: 'unchanged' | 'added' | 'removed';
}

/** Value change info: either the whole value changed, or specific array indices changed */
type ChangeInfo =
  | { type: 'full' }  // Entire value changed (non-array or structural change)
  | { type: 'array'; mergedView: MergedElement[] }  // Array with merged view showing elements in original order
  | { type: 'none' };  // No change

/** Compute a merged view that interleaves removed elements at their original positions */
function computeMergedView(prev: unknown[], curr: unknown[]): MergedElement[] {
  const result: MergedElement[] = [];
  const currUsed = new Array(curr.length).fill(false);

  // Walk through prev in order to maintain original positions
  for (const prevEl of prev) {
    // Find this element in curr (first unused match)
    const currIdx = curr.findIndex((c, i) => !currUsed[i] && deepEqual(c, prevEl));
    if (currIdx !== -1) {
      // Element still exists
      currUsed[currIdx] = true;
      result.push({ element: prevEl, status: 'unchanged' });
    } else {
      // Element was removed - insert at original position
      result.push({ element: prevEl, status: 'removed' });
    }
  }

  // Append new elements from curr (elements that weren't in prev)
  for (let i = 0; i < curr.length; i++) {
    if (!currUsed[i]) {
      result.push({ element: curr[i], status: 'added' });
    }
  }

  return result;
}

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
      // Compute merged view with elements in original order
      const mergedView = computeMergedView(prevVal, currVal);
      // Only mark as changed if there are actual additions or removals
      const hasChanges = mergedView.some(m => m.status !== 'unchanged');
      if (hasChanges) {
        changes.set(k, { type: 'array', mergedView });
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
function renderValueInline(x: unknown): React.ReactNode {
  if (Array.isArray(x)) {
    const elements = x.map((el, i) => <span key={i}>{renderValueInline(el)}</span>);
    return <code>[{joinNodes(elements)}]</code>;
  }
  if (typeof x === 'object' && x !== null) {
    return <code>{JSON.stringify(x)}</code>;
  }
  if (typeof x === 'string') {
    return <code>{dequalify(x)}</code>;
  }
  return <code>{String(x)}</code>;
}


/** Render a row from an inner array:
 * - If it's a flat tuple (all elements are primitives), render as `(a, b, c)` with parentheses
 * - Otherwise, render the inner array inline as `[a, b, ...]`
 * If not an array, fallback to regular rendering
*/
function renderRowFromInnerArray(e: unknown, status?: 'unchanged' | 'added' | 'removed'): React.ReactNode {
  const className = status === 'added' ? 'changed-element' : status === 'removed' ? 'removed-element' : undefined;

  if (Array.isArray(e)) {
    // Check if this is a flat tuple (all elements are primitives, not arrays)
    const isFlatTuple = e.every(el => !Array.isArray(el));
    if (isFlatTuple) {
      const parts: React.ReactNode[] = [];
      e.forEach((el, i) => {
        parts.push(renderValueInline(el));
        if (i < e.length - 1) parts.push(', ');
      });
      const code = <code>({parts})</code>;
      return className ? <span className={className}>{code}</span> : code;
    } else {
      const content = renderValueInline(e);           // ← Nested arrays, inline as [ ... ]
      return className ? <span className={className}>{content}</span> : content;
    }
  }
  return renderValue(e);
}

/** Render inline array using merged view for proper ordering */
function renderInlineArrayMerged(mergedView: MergedElement[]): React.ReactNode {
  const parts: React.ReactNode[] = [];

  mergedView.forEach((item, i) => {
    const element = renderValueInline(item.element);
    const className = item.status === 'added' ? 'changed-element' : item.status === 'removed' ? 'removed-element' : undefined;
    parts.push(className ? <span key={i} className={className}>{element}</span> : <span key={i}>{element}</span>);
    if (i < mergedView.length - 1) parts.push(<span key={`comma-${i}`}>, </span>);
  });
  return <code>[{parts}]</code>;
}

/** Original: Inline rendering of flat arrays (when no diff info available) */
function renderInlineArray(arr: unknown[]): React.ReactNode {
  const parts: React.ReactNode[] = [];
  arr.forEach((e, i) => {
    parts.push(<span key={i}>{renderValueInline(e)}</span>);
    if (i < arr.length - 1) parts.push(<span key={`comma-${i}`}>, </span>);
  });
  return <code>[{parts}]</code>;
}

function renderValue(v: unknown, mergedView?: MergedElement[]): React.ReactNode {
  if (Array.isArray(v)) {
    // Handle empty array with no changes
    if (v.length === 0 && (!mergedView || mergedView.length === 0)) {
      return <code>[]</code>;
    }

    // If we have a merged view, use it for rendering
    if (mergedView && mergedView.length > 0) {
      // ★ Key rule: If any element contains inner arrays, render each on a separate line
      const hasInnerArray = mergedView.some(m => Array.isArray(m.element));

      if (hasInnerArray) {
        return (
          <ul className="list">
            {mergedView.map((item, i) => (
              <li key={i}>{renderRowFromInnerArray(item.element, item.status)}</li>
            ))}
          </ul>
        );
      }

      // Top-level flat arrays are rendered with brackets [a, b, c]
      return renderInlineArrayMerged(mergedView);
    }

    // No merged view - render without diff highlighting
    const hasInnerArray = v.some(Array.isArray);
    if (hasInnerArray) {
      return (
        <ul className="list">
          {v.map((e, i) => (
            <li key={i}>{renderRowFromInnerArray(e)}</li>
          ))}
        </ul>
      );
    }

    return renderInlineArray(v);
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

const KVRow: React.FC<{
  k: string;
  v: unknown;
  changeInfo?: ChangeInfo;
  showRemovals?: boolean;
  onHideField?: (fieldName: string) => void;
}> = ({
  k,
  v,
  changeInfo,
  showRemovals = false,
  onHideField,
}) => {
  const collapsible = isCollapsibleValue(v);

  // Highlight the row if there's any change (array or full)
  const hasChange = changeInfo?.type === 'full' || changeInfo?.type === 'array';

  // Start expanded by default
  const [expanded, setExpanded] = React.useState(true);

  // For array changes, compute the merged view to pass to renderValue
  // If showRemovals is false, filter out removed elements from the merged view
  const mergedView = React.useMemo(() => {
    if (!expanded || changeInfo?.type !== 'array') return undefined;
    const view = changeInfo.mergedView;
    if (!showRemovals) {
      // Filter out removed elements when showRemovals is false
      return view.filter(m => m.status !== 'removed');
    }
    return view;
  }, [expanded, changeInfo, showRemovals]);

  return (
    <div
      className={`kv-row ${collapsible ? "has-toggle" : ""} ${
        hasChange ? "changed" : ""
      }`}
    >
      <div
        className={`kv-key ${onHideField ? 'kv-key-clickable' : ''}`}
        onClick={(e) => {
          if (onHideField && (e.altKey || e.metaKey)) {
            e.preventDefault();
            onHideField(k);
          }
        }}
        title={onHideField ? "Alt/Cmd-click to hide this field" : undefined}
      >
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
          {expanded ? renderValue(v, mergedView) : <code>{previewValue(v)}</code>}
        </div>
      </div>
    </div>
  );
};

const StateCard: React.FC<{
  st: ParsedState;
  highlighted?: boolean;
  changes?: Map<string, ChangeInfo>;
  showRemovals?: boolean;
  forceOpen?: boolean | null;  // null means use local state, true/false forces open/closed
  hiddenFields?: Set<string>;
  onHideField?: (fieldName: string) => void;
  onResetForceOpen?: () => void;  // Called when user clicks header while forceOpen is active
}> = ({ st, highlighted = false, changes, showRemovals = false, forceOpen = null, hiddenFields, onHideField, onResetForceOpen }) => {
  const [localOpen, setLocalOpen] = React.useState(true);

  // Sync local state when forceOpen changes - this ensures that when we
  // reset to individual control, each state keeps the forced value
  React.useEffect(() => {
    if (forceOpen !== null) {
      setLocalOpen(forceOpen);
    }
  }, [forceOpen]);

  // Use forceOpen if set, otherwise use local state
  const open = forceOpen !== null ? forceOpen : localOpen;

  const handleHeaderClick = () => {
    if (forceOpen !== null && onResetForceOpen) {
      // User clicked while in force mode - switch to individual control
      // Set local state to opposite of current forced state, then reset force
      setLocalOpen(!forceOpen);
      onResetForceOpen();
    } else {
      setLocalOpen(o => !o);
    }
  };
  // Filter out hidden fields
  const entries = Object.entries(st.fields).filter(([k]) => !hiddenFields?.has(k));

  return (
    <div className={`state-card ${highlighted ? "is-highlighted" : ""}`}>
      <div className="state-header" onClick={handleHeaderClick}>
        <span className="action-chip" title={st.tag ?? ''}>
          {st.tag || '(no action)'}
        </span>
        <span className="state-id">(index: {st.index})</span>
        <div className="state-toggle">{open ? "▼" : "▶"}</div>
      </div>

      {open && (
        <div className="state-body">
          <div className="kv-table">
            {entries.map(([k, v]) => (
              <KVRow key={k} k={k} v={v} changeInfo={changes?.get(k)} showRemovals={showRemovals} onHideField={onHideField} />
            ))}
          </div>
        </div>
      )}
    </div>
  );
};

/** Collapsible section for displaying theory info */
const TheorySection: React.FC<{ theory: Record<string, unknown> }> = ({ theory }) => {
  const [expanded, setExpanded] = React.useState(false);
  const entries = Object.entries(theory);

  return (
    <div className="theory-section">
      <div className="theory-header" onClick={() => setExpanded((e) => !e)}>
        <span className="theory-toggle">{expanded ? "▼" : "▶"}</span>
        <span className="theory-label">Theory</span>
      </div>
      {expanded && (
        <div className="theory-content">
          <div className="kv-table">
            {entries.map(([k, v]) => (
              <KVRow key={k} k={k} v={v} />
            ))}
          </div>
        </div>
      )}
    </div>
  );
};

/** Header showing the result status with appropriate icon */
const ResultHeader: React.FC<{
  resultType: "found_violation" | "no_violation_found";
  violation?: Violation;
  exploredStates?: number;
  terminationReason?: TerminationReason;
}> = ({ resultType, violation, exploredStates, terminationReason }) => {
  if (resultType === "found_violation" && violation) {
    const icon = violation.kind === "deadlock" ? "🔒" : "⚠️";
    const label = violation.kind === "deadlock" ? "Deadlock Detected" : "Safety Violation Found";
    return (
      <div className="result-header result-violation">
        <span className="result-icon">{icon}</span>
        <span className="result-label">{label}</span>
        {violation.kind === "safety_failure" && violation.violates && violation.violates.length > 0 && (
          <div className="result-details">
            <strong>Violated properties:</strong> {violation.violates.join(", ")}
          </div>
        )}
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

/** Copy button component */
const CopyButton: React.FC<{ text: string; className?: string }> = ({ text, className }) => {
  const [copied, setCopied] = React.useState(false);

  const handleCopy = async () => {
    try {
      await navigator.clipboard.writeText(text);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    } catch (err) {
      console.error('Failed to copy:', err);
    }
  };

  return (
    <button className={className} onClick={handleCopy} title="Copy to clipboard">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
        {copied ? (
          <path d="M20 6L9 17l-5-5" strokeLinecap="round" strokeLinejoin="round" />
        ) : (
          <>
            <rect x="9" y="9" width="13" height="13" rx="2" ry="2" />
            <path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1" />
          </>
        )}
      </svg>
      {copied ? 'Copied!' : 'Copy JSON'}
    </button>
  );
};

const ModelCheckerView: React.FC<ModelCheckerViewProps> = ({
  result,
  layout = "vertical",
}) => {
  const isVertical = layout === "vertical";
  const [showRawJson, setShowRawJson] = React.useState(false);
  const [showRemovals, setShowRemovals] = React.useState(false);
  const [allStatesOpen, setAllStatesOpen] = React.useState<boolean | null>(null);  // null = individual control
  const [hiddenFields, setHiddenFields] = React.useState<Set<string>>(new Set());
  const [showFilterPanel, setShowFilterPanel] = React.useState(false);

  // Compute all unique field names from the trace
  const traceData = result.trace;
  const allFieldNames = React.useMemo(() => {
    if (!traceData?.states) return [];
    const names = new Set<string>();
    for (const state of traceData.states) {
      for (const key of Object.keys(state.fields)) {
        names.add(key);
      }
    }
    return Array.from(names).sort();
  }, [traceData]);

  const toggleFieldVisibility = (fieldName: string) => {
    setHiddenFields(prev => {
      const next = new Set(prev);
      if (next.has(fieldName)) {
        next.delete(fieldName);
      } else {
        next.add(fieldName);
      }
      return next;
    });
  };

  const showAllFields = () => setHiddenFields(new Set());
  const hideAllFields = () => setHiddenFields(new Set(allFieldNames));

  // Keyboard shortcuts
  React.useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      // Handle Escape first - it should work everywhere to close the panel
      if (e.key === 'Escape') {
        setShowFilterPanel(false);
        return;
      }

      // Don't trigger other shortcuts when typing in an input field
      if (e.target instanceof HTMLInputElement || e.target instanceof HTMLTextAreaElement) {
        return;
      }
      // Only handle shortcuts when not in JSON view
      if (showRawJson) return;

      if (e.key === 'r' || e.key === 'R') {
        e.preventDefault();
        setShowRemovals(prev => !prev);
      } else if (e.key === 'c' || e.key === 'C') {
        e.preventDefault();
        setAllStatesOpen(prev => prev === false ? true : false);
      } else if (e.key === 'f' || e.key === 'F') {
        e.preventDefault();
        setShowFilterPanel(prev => !prev);
      }
    };

    document.addEventListener('keydown', handleKeyDown);
    return () => document.removeEventListener('keydown', handleKeyDown);
  }, [showRawJson]);

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
      gap: 8px;
      font-weight: 600;
      cursor: pointer;
    }
    .state-id {
      font-size: 12px;
      color: var(--vscode-descriptionForeground);
      margin-left: auto;
    }
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
      background: var(--vscode-diffEditor-insertedTextBackground, rgba(0, 255, 0, 0.2));
      border-radius: 3px;
      padding: 2px 4px;
      box-shadow: 0 0 0 2px var(--vscode-diffEditor-insertedLineBackground, rgba(0, 255, 0, 0.3));
      color: var(--vscode-editor-foreground);
    }
    .removed-element {
      background: var(--vscode-diffEditor-removedTextBackground, rgba(255, 0, 0, 0.2));
      border-radius: 3px;
      padding: 2px 4px;
      box-shadow: 0 0 0 2px var(--vscode-diffEditor-removedLineBackground, rgba(255, 0, 0, 0.3));
      color: var(--vscode-editor-foreground);
      text-decoration: line-through;
      opacity: 0.8;
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
      padding: 8px;
      border-top: 1px solid var(--vscode-panel-border);
    }
    .mc-toolbar {
      display: flex;
      justify-content: flex-end;
      gap: 12px;
      padding: 4px 8px;
      position: sticky;
      top: 0;
      z-index: 50;
      background: var(--vscode-editorWidget-background);
      border-bottom: 1px solid var(--vscode-panel-border);
    }
    .mc-toggle-link {
      font-size: 11px;
      color: var(--vscode-textLink-foreground);
      cursor: pointer;
      text-decoration: none;
      background: none;
      border: none;
      padding: 2px 6px;
      border-radius: 3px;
    }
    .mc-toggle-link:hover {
      text-decoration: underline;
      background: var(--vscode-toolbar-hoverBackground);
    }
    .mc-filter-active {
      color: var(--vscode-notificationsInfoIcon-foreground, #3794ff);
      font-weight: 600;
    }
    .mc-filter-panel {
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      z-index: 1000;
      min-width: 250px;
      max-width: 90vw;
      max-height: 400px;
      background: var(--vscode-editorWidget-background);
      border: 1px solid var(--vscode-panel-border);
      border-radius: 8px;
      box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
      overflow: hidden;
    }
    .mc-filter-backdrop {
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0, 0, 0, 0.3);
      z-index: 999;
    }
    .mc-filter-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 8px 12px;
      border-bottom: 1px solid var(--vscode-panel-border);
      font-weight: 600;
      font-size: 12px;
    }
    .mc-filter-actions {
      display: flex;
      gap: 8px;
    }
    .mc-filter-action {
      font-size: 10px;
      color: var(--vscode-textLink-foreground);
      background: none;
      border: none;
      cursor: pointer;
      padding: 2px 4px;
    }
    .mc-filter-action:hover {
      text-decoration: underline;
    }
    .mc-filter-close {
      font-size: 18px;
      line-height: 1;
      color: var(--vscode-foreground);
      background: none;
      border: none;
      cursor: pointer;
      padding: 0 4px;
      margin-left: 8px;
      opacity: 0.7;
    }
    .mc-filter-close:hover {
      opacity: 1;
    }
    .mc-filter-list {
      padding: 8px;
      max-height: 240px;
      overflow-y: auto;
    }
    .mc-filter-item {
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 4px;
      cursor: pointer;
      border-radius: 3px;
      font-size: 12px;
    }
    .mc-filter-item:hover {
      background: var(--vscode-list-hoverBackground);
    }
    .mc-filter-item input {
      margin: 0;
    }
    .mc-filter-item code {
      font-size: 11px;
    }
    .kv-key-clickable {
      cursor: pointer;
    }
    .kv-key-clickable:hover {
      background: var(--vscode-list-hoverBackground);
      border-radius: 3px;
    }
    .mc-json-view {
      margin: 8px;
      background: var(--vscode-editor-background);
      border: 1px solid var(--vscode-panel-border);
      border-radius: 6px;
      position: relative;
      max-height: 600px;
    }
    .mc-json-content {
      padding: 12px;
      font-family: ui-monospace, SFMono-Regular, Menlo, Consolas, "Liberation Mono", monospace;
      font-size: 12px;
      white-space: pre;
      overflow: auto;
      max-height: 600px;
    }
    .mc-copy-button {
      position: absolute;
      top: 8px;
      right: 8px;
      display: inline-flex;
      align-items: center;
      gap: 4px;
      font-size: 11px;
      color: var(--vscode-button-foreground);
      background: var(--vscode-button-background);
      border: none;
      border-radius: 4px;
      padding: 4px 8px;
      cursor: pointer;
      transition: background 0.15s, opacity 0.15s;
      opacity: 0;
    }
    .mc-json-view:hover .mc-copy-button,
    .mc-json-content:hover ~ .mc-copy-button {
      opacity: 1;
    }
    .mc-copy-button:hover {
      background: var(--vscode-button-hoverBackground);
    }
    .mc-copy-button svg {
      width: 14px;
      height: 14px;
    }
  `;

  const prettyJson = JSON.stringify(result, null, 2);

  // Extract trace and theory from results (works for all result types)
  const trace = traceData ? traceDataToStates(traceData) : [];
  const theory: Record<string, unknown> | undefined = traceData?.theory;

  return (
    <>
      <style>{styles}</style>
      <div className="mc-root">
        <div className="mc-toolbar">
          {!showRawJson && (
            <>
              <button
                className={`mc-toggle-link ${hiddenFields.size > 0 ? 'mc-filter-active' : ''}`}
                onClick={() => setShowFilterPanel(!showFilterPanel)}
                title="Filter visible fields (F)"
              >
                Filter fields {hiddenFields.size > 0 ? `(${hiddenFields.size} hidden)` : ''} (F)
              </button>
              <button className="mc-toggle-link" onClick={() => setAllStatesOpen(allStatesOpen === false ? true : false)} title="Keyboard shortcut: C">
                {allStatesOpen === false ? "Expand all (C)" : "Collapse all (C)"}
              </button>
              <button className="mc-toggle-link" onClick={() => setShowRemovals(!showRemovals)} title="Keyboard shortcut: R">
                {showRemovals ? "Hide removals (R)" : "Show removals (R)"}
              </button>
            </>
          )}
          <button className="mc-toggle-link" onClick={() => setShowRawJson(!showRawJson)}>
            {showRawJson ? "Show formatted" : "Show JSON"}
          </button>
        </div>

        {showRawJson ? (
          <div className="mc-json-view">
            <CopyButton text={prettyJson} className="mc-copy-button" />
            <div className="mc-json-content">
              {prettyJson}
            </div>
          </div>
        ) : (
          <>
            {'result' in result && (
              <>
                {result.result === "no_violation_found" ? (
                  <ResultHeader
                    resultType="no_violation_found"
                    exploredStates={result.explored_states}
                    terminationReason={result.termination_reason}
                  />
                ) : (
                  <ResultHeader
                    resultType="found_violation"
                    violation={result.violation}
                  />
                )}
              </>
            )}

            {theory && <TheorySection theory={theory} />}

            {trace.length > 0 ? (
              <>
                <div className={`mc-trace ${isVertical ? "vertical" : "horizontal"}`}>
                  {trace.map((s: ParsedState, idx: number) => {
                    const prev = idx > 0 ? trace[idx - 1].fields : undefined;
                    const changes = diffChanges(prev, s.fields);
                    return <StateCard key={s.index} st={s} changes={changes} showRemovals={showRemovals} forceOpen={allStatesOpen} hiddenFields={hiddenFields} onHideField={toggleFieldVisibility} onResetForceOpen={() => setAllStatesOpen(null)} />;
                  })}
                </div>

                <div className="mc-summary">
                  <strong>Summary:</strong> {trace.length} states in trace
                </div>
              </>
            ) : (
              'result' in result && result.result === "found_violation" && (
                <div className="mc-summary">
                  <strong>No trace available</strong>
                </div>
              )
            )}
          </>
        )}

        {/* Filter panel modal - rendered at root level for fixed positioning */}
        {showFilterPanel && (
          <>
            <div className="mc-filter-backdrop" onClick={() => setShowFilterPanel(false)} />
            <div className="mc-filter-panel">
              <div className="mc-filter-header">
                <span>Visible Fields</span>
                <div className="mc-filter-actions">
                  <button className="mc-filter-action" onClick={showAllFields}>Show all</button>
                  <button className="mc-filter-action" onClick={hideAllFields}>Hide all</button>
                  <button className="mc-filter-close" onClick={() => setShowFilterPanel(false)} title="Close (Esc)">×</button>
                </div>
              </div>
              <div className="mc-filter-list">
                {allFieldNames.map(name => (
                  <label key={name} className="mc-filter-item">
                    <input
                      type="checkbox"
                      checked={!hiddenFields.has(name)}
                      onChange={() => toggleFieldVisibility(name)}
                    />
                    <code>{name}</code>
                  </label>
                ))}
              </div>
            </div>
          </>
        )}
      </div>
    </>
  );
};

export default ModelCheckerView;
