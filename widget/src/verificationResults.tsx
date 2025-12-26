import * as React from 'react';
import HtmlDisplay, { Html } from './htmlDisplay';

// ========== Types ==========

interface VCMetadata {
  stmtDerivedFrom?: string[];
  property: string;
  kind?: 'primary' | 'alternative';
  action: string;
  style?: 'wp' | 'tr';
}

interface StructuredJson {
  theory: Record<string, unknown>;
  preState: Record<string, unknown>;
  postState: Record<string, unknown> | null;
  label: Record<string, unknown>;
  instantiation: Record<string, unknown>;
}

interface Counterexample {
  model?: any;
  structuredJson?: StructuredJson;
  html: Html | string;  // Can be either structured Html or raw HTML string
}

interface DischargerResultData {
  kind: string;
  counterexamples?: Counterexample[];
}

interface DischargerResult {
  time: number;
  status: string;
  data?: DischargerResultData;
  exceptions?: string[];
}

interface DischargerStatusFinished {
  finished: {
    res: DischargerResult;
  };
}

type DischargerStatus = string | DischargerStatusFinished;

interface Discharger {
  id: number;
  name: string;
  status: DischargerStatus;
  time: number | null;
  result?: DischargerResult | null;
}

interface VCTiming {
  totalTime: number | null;
  successfulDischargerTime?: number;
  successfulDischargerId?: number;
  dischargers: Discharger[];
}

interface VerificationCondition {
  id: number;
  name: string;
  status: 'proven' | 'disproven' | 'unknown' | 'error' | null;
  metadata: VCMetadata;
  timing: VCTiming;
  alternativeFor?: number | null;
  isDormant?: boolean;
}

interface VerificationResults {
  vcs: VerificationCondition[];
  totalVCs: number;
  totalSolved: number;
  totalDischarged: number;
}

interface VerificationResultsProps {
  results: VerificationResults;
}

type StatusFilter = 'all' | 'proven' | 'disproven' | 'unknown' | 'error' | 'pending';

// ========== Helpers ==========

/* ================= Diff helpers for structured counterexamples ================= */
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

  if (typeof a === 'object' && typeof b === 'object') {
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

/** Value change info for structured counterexample diff */
type ChangeInfo =
  | { type: 'full' }
  | { type: 'array'; mergedView: MergedElement[] }
  | { type: 'none' };

/** Compute change information for each field between pre and post state */
function diffChanges(
  prev: Record<string, unknown> | undefined | null,
  curr: Record<string, unknown>
): Map<string, ChangeInfo> {
  const changes = new Map<string, ChangeInfo>();
  if (!prev) return changes;

  const keys = new Set<string>([...Object.keys(prev), ...Object.keys(curr)]);
  for (const k of keys) {
    const hasA = k in prev;
    const hasB = k in curr;

    if (!hasA || !hasB) {
      changes.set(k, { type: 'full' });
      continue;
    }

    const prevVal = (prev as any)[k];
    const currVal = (curr as any)[k];

    if (deepEqual(prevVal, currVal)) {
      continue;
    }

    if (Array.isArray(prevVal) && Array.isArray(currVal)) {
      // Compute merged view with elements in original order
      const mergedView = computeMergedView(prevVal, currVal);
      // Only mark as changed if there are actual additions or removals
      const hasChanges = mergedView.some(m => m.status !== 'unchanged');
      if (hasChanges) {
        changes.set(k, { type: 'array', mergedView });
      }
    } else {
      changes.set(k, { type: 'full' });
    }
  }

  return changes;
}

/* ================= Rendering helpers for structured counterexamples ================= */

/** Concatenate React nodes with separator */
function joinNodes(nodes: React.ReactNode[], sep: React.ReactNode = ', '): React.ReactNode {
  const out: React.ReactNode[] = [];
  nodes.forEach((n, i) => {
    out.push(<span key={`n-${i}`}>{n}</span>);
    if (i < nodes.length - 1) out.push(<span key={`s-${i}`}>{sep}</span>);
  });
  return <>{out}</>;
}

/** Render any value inline */
function renderValueInline(x: unknown): React.ReactNode {
  if (Array.isArray(x)) {
    const elements = x.map((el, i) => <span key={i}>{renderValueInline(el)}</span>);
    return <code>[{joinNodes(elements)}]</code>;
  }
  if (typeof x === 'object' && x !== null) {
    return <code>{JSON.stringify(x)}</code>;
  }
  if (typeof x === 'string') {
    return <code>{x}</code>;
  }
  return <code>{String(x)}</code>;
}

/** Render a row from an inner array with optional highlighting */
function renderRowFromInnerArray(e: unknown, status?: 'unchanged' | 'added' | 'removed'): React.ReactNode {
  const className = status === 'added' ? 'cex-changed-element' : status === 'removed' ? 'cex-removed-element' : undefined;

  if (Array.isArray(e)) {
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
      const content = renderValueInline(e);
      return className ? <span className={className}>{content}</span> : content;
    }
  }
  return renderCexValue(e);
}

/** Render inline array using merged view for proper ordering */
function renderInlineArrayMerged(mergedView: MergedElement[]): React.ReactNode {
  const parts: React.ReactNode[] = [];

  mergedView.forEach((item, i) => {
    const element = renderValueInline(item.element);
    const className = item.status === 'added' ? 'cex-changed-element' : item.status === 'removed' ? 'cex-removed-element' : undefined;
    parts.push(className ? <span key={i} className={className}>{element}</span> : <span key={i}>{element}</span>);
    if (i < mergedView.length - 1) parts.push(<span key={`comma-${i}`}>, </span>);
  });
  return <code>[{parts}]</code>;
}

/** Render inline array (when no diff info available) */
function renderInlineArray(arr: unknown[]): React.ReactNode {
  const parts: React.ReactNode[] = [];
  arr.forEach((e, i) => {
    parts.push(<span key={i}>{renderValueInline(e)}</span>);
    if (i < arr.length - 1) parts.push(<span key={`comma-${i}`}>, </span>);
  });
  return <code>[{parts}]</code>;
}

/** Render a value for structured counterexample display */
function renderCexValue(v: unknown, mergedView?: MergedElement[]): React.ReactNode {
  if (Array.isArray(v)) {
    // Handle empty array with no changes
    if (v.length === 0 && (!mergedView || mergedView.length === 0)) {
      return <code>[]</code>;
    }

    // If we have a merged view, use it for rendering
    if (mergedView && mergedView.length > 0) {
      // Check if any element contains inner arrays
      const hasInnerArray = mergedView.some(m => Array.isArray(m.element));

      if (hasInnerArray) {
        return (
          <ul className="cex-list">
            {mergedView.map((item, i) => (
              <li key={i}>{renderRowFromInnerArray(item.element, item.status)}</li>
            ))}
          </ul>
        );
      }

      return renderInlineArrayMerged(mergedView);
    }

    // No merged view - render without diff highlighting
    const hasInnerArray = v.some(Array.isArray);
    if (hasInnerArray) {
      return (
        <ul className="cex-list">
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
    return <code>{v}</code>;
  }

  return <code>{String(v)}</code>;
}

/** Format a label/action object like {"recv": {"sender": 2, ...}} */
function formatLabel(label: Record<string, unknown>): string {
  const keys = Object.keys(label);
  if (keys.length === 1) {
    let actionName = keys[0];
    if (actionName.startsWith("_")) {
      actionName = actionName.slice(1);
    }
    const args = label[keys[0]];
    if (typeof args === "object" && args !== null && !Array.isArray(args)) {
      const argObj = args as Record<string, unknown>;
      const argKeys = Object.keys(argObj);
      if (argKeys.length > 0) {
        const formatValue = (v: unknown): string => {
          if (typeof v === "string") return v;
          if (typeof v === "number" || typeof v === "boolean") return String(v);
          return JSON.stringify(v);
        };
        const argStr = argKeys.map((k) => `${k} = ${formatValue(argObj[k])}`).join(", ");
        return `${actionName}(${argStr})`;
      }
    }
    return actionName;
  }
  return JSON.stringify(label);
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

/** Key-value row component for state display */
const CexKVRow: React.FC<{
  k: string;
  v: unknown;
  changeInfo?: ChangeInfo;
}> = ({ k, v, changeInfo }) => {
  const hasChange = changeInfo?.type === 'full' || changeInfo?.type === 'array';
  const mergedView = changeInfo?.type === 'array' ? changeInfo.mergedView : undefined;

  return (
    <div className={`cex-kv-row ${hasChange ? 'changed' : ''}`}>
      <div className="cex-kv-key"><code>{k}</code></div>
      <div className="cex-kv-sep">↦</div>
      <div className="cex-kv-val">
        {renderCexValue(v, mergedView)}
      </div>
    </div>
  );
};

/** State panel component showing fields in a card */
const StatePanel: React.FC<{
  title: string;
  fields: Record<string, unknown>;
  changes?: Map<string, ChangeInfo>;
}> = ({ title, fields, changes }) => {
  const entries = Object.entries(fields);

  return (
    <div className="cex-state-panel">
      <div className="cex-state-header">
        {title}
      </div>
      <div className="cex-state-body">
        {entries.length === 0 ? (
          <div className="cex-empty-state">No fields</div>
        ) : (
          <div className="cex-kv-table">
            {entries.map(([k, v]) => (
              <CexKVRow key={k} k={k} v={v} changeInfo={changes?.get(k)} />
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

/** Structured counterexample view with side-by-side pre/post states */
const StructuredCexView: React.FC<{
  data: StructuredJson;
  headerRightContent?: React.ReactNode;
}> = ({ data, headerRightContent }) => {
  const { preState, postState, label, instantiation } = data;

  // State for toolbar features
  const [showRemovals, setShowRemovals] = React.useState(true);
  const [hiddenFields, setHiddenFields] = React.useState<Set<string>>(new Set());
  const [showFilterPanel, setShowFilterPanel] = React.useState(false);
  const [isWideEnough, setIsWideEnough] = React.useState(true);
  const containerRef = React.useRef<HTMLDivElement>(null);

  // Detect when container is too narrow for side-by-side layout
  React.useEffect(() => {
    const container = containerRef.current;
    if (!container) return;

    const observer = new ResizeObserver((entries) => {
      for (const entry of entries) {
        // Hide transition row when width < 600px (approximately when panels stack)
        setIsWideEnough(entry.contentRect.width >= 600);
      }
    });

    observer.observe(container);
    return () => observer.disconnect();
  }, []);

  // Compute all unique field names from pre and post state
  const allFieldNames = React.useMemo(() => {
    const names = new Set<string>();
    for (const key of Object.keys(preState)) names.add(key);
    if (postState) {
      for (const key of Object.keys(postState)) names.add(key);
    }
    return Array.from(names).sort();
  }, [preState, postState]);

  // Compute diff from preState to postState
  const changes = postState ? diffChanges(preState, postState) : new Map<string, ChangeInfo>();

  // Filter fields based on hiddenFields
  const filteredPreState = React.useMemo(() => {
    const filtered: Record<string, unknown> = {};
    for (const [k, v] of Object.entries(preState)) {
      if (!hiddenFields.has(k)) filtered[k] = v;
    }
    return filtered;
  }, [preState, hiddenFields]);

  const filteredPostState = React.useMemo(() => {
    if (!postState) return null;
    const filtered: Record<string, unknown> = {};
    for (const [k, v] of Object.entries(postState)) {
      if (!hiddenFields.has(k)) filtered[k] = v;
    }
    return filtered;
  }, [postState, hiddenFields]);

  // Filter changes to only include visible fields, and optionally hide removals
  const filteredChanges = React.useMemo(() => {
    const filtered = new Map<string, ChangeInfo>();
    for (const [k, info] of changes) {
      if (hiddenFields.has(k)) continue;
      if (!showRemovals && info.type === 'array') {
        // Filter out removed elements when showRemovals is false
        const filteredMergedView = info.mergedView.filter(m => m.status !== 'removed');
        filtered.set(k, { type: 'array', mergedView: filteredMergedView });
      } else {
        filtered.set(k, info);
      }
    }
    return filtered;
  }, [changes, hiddenFields, showRemovals]);

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
      if (e.key === 'Escape') {
        setShowFilterPanel(false);
        return;
      }

      if (e.target instanceof HTMLInputElement || e.target instanceof HTMLTextAreaElement) {
        return;
      }

      if (e.key === 'r' || e.key === 'R') {
        e.preventDefault();
        setShowRemovals(prev => !prev);
      } else if (e.key === 'f' || e.key === 'F') {
        e.preventDefault();
        setShowFilterPanel(prev => !prev);
      }
    };

    document.addEventListener('keydown', handleKeyDown);
    return () => document.removeEventListener('keydown', handleKeyDown);
  }, []);

  return (
    <div className="cex-structured-view" ref={containerRef}>
      {/* Combined header with toolbar and controls */}
      <div className="cex-header-row">
        <div className="cex-header-left">
          <span className="cex-header-label">Counterexample</span>
          <button
            className={`cex-toolbar-btn ${hiddenFields.size > 0 ? 'cex-filter-active' : ''}`}
            onClick={(e) => { e.stopPropagation(); setShowFilterPanel(!showFilterPanel); }}
            title="Filter visible fields (F)"
          >
            Filter fields {hiddenFields.size > 0 ? `(${hiddenFields.size} hidden)` : ''} (F)
          </button>
          <button
            className="cex-toolbar-btn"
            onClick={(e) => { e.stopPropagation(); setShowRemovals(!showRemovals); }}
            title="Show/hide removed elements (R)"
          >
            {showRemovals ? "Hide removals (R)" : "Show removals (R)"}
          </button>
        </div>
        {headerRightContent && (
          <div className="cex-header-right">
            {headerRightContent}
          </div>
        )}
      </div>

      {/* Instantiation */}
      {instantiation && Object.keys(instantiation).length > 0 && (
        <div className="cex-instantiation-row">
          <span className="cex-instantiation-label">Instantiation</span>
          <div className="cex-instantiation-values">
            {Object.entries(instantiation).map(([k, v]) => (
              <span key={k} className="cex-instantiation-item">
                <span className="cex-instantiation-key">{k}</span>
                <span className="cex-instantiation-eq">=</span>
                <span className="cex-instantiation-val">{String(v)}</span>
              </span>
            ))}
          </div>
        </div>
      )}

      {/* Induction counterexample transition visualization (hidden when narrow) */}
      {isWideEnough && (
        <div className="cex-transition-row">
          <div className="cex-transition-column">
            <div className="cex-transition-state cex-transition-pre">
              <span className="cex-transition-icon cex-icon-valid">✓</span>
              <span className="cex-transition-label">Satisfies invariant</span>
            </div>
            <div className="cex-connector-line" />
          </div>
          <div className="cex-transition-center">
            <span className="cex-action-chip">{formatLabel(label)}</span>
          </div>
          <div className="cex-transition-column">
            <div className="cex-connector-line" />
            <div className="cex-transition-state cex-transition-post">
              <span className="cex-transition-icon cex-icon-invalid">✗</span>
              <span className="cex-transition-label">Violates invariant</span>
            </div>
          </div>
        </div>
      )}

      {/* Side-by-side state panels */}
      <div className="cex-states-container">
        <StatePanel title="Pre-State" fields={filteredPreState} />
        {filteredPostState && (
          <StatePanel title="Post-State" fields={filteredPostState} changes={filteredChanges} />
        )}
      </div>

      {/* Filter panel modal */}
      {showFilterPanel && (
        <>
          <div className="cex-filter-backdrop" onClick={() => setShowFilterPanel(false)} />
          <div className="cex-filter-panel">
            <div className="cex-filter-header">
              <span>Visible Fields</span>
              <div className="cex-filter-actions">
                <button className="cex-filter-action" onClick={showAllFields}>Show all</button>
                <button className="cex-filter-action" onClick={hideAllFields}>Hide all</button>
                <button className="cex-filter-close" onClick={() => setShowFilterPanel(false)} title="Close (Esc)">×</button>
              </div>
            </div>
            <div className="cex-filter-list">
              {allFieldNames.map(name => (
                <label key={name} className="cex-filter-item">
                  <input
                    type="checkbox"
                    checked={!hiddenFields.has(name)}
                    onChange={() => toggleFieldVisibility(name)}
                  />
                  <span>{name}</span>
                </label>
              ))}
            </div>
          </div>
        </>
      )}
    </div>
  );
};

function getStatusIcon(status: VerificationCondition['status']): React.ReactNode {
  switch (status) {
    case 'proven': return '✅';
    case 'disproven': return '❌';
    case 'unknown': return '❓';
    case 'error': return '💥';
    case null: return <span className="spinner">⏳</span>;
    default: return '⭕';
  }
}

function getStatusClass(status: VerificationCondition['status']): string {
  return status || 'pending';
}

// Extract exceptions from dischargers
function getExceptionsFromVC(vc: VerificationCondition): string[] {
  const exceptions: string[] = [];
  for (const discharger of vc.timing.dischargers) {
    // Check if status is an object with finished.res.exceptions
    if (typeof discharger.status === 'object' && discharger.status !== null) {
      const finished = (discharger.status as DischargerStatusFinished).finished;
      if (finished?.res?.exceptions) {
        exceptions.push(...finished.res.exceptions);
      }
    }
    // Also check the result field for exceptions
    if (discharger.result?.exceptions) {
      exceptions.push(...discharger.result.exceptions);
    }
  }
  return exceptions;
}

// Group VCs by action
function groupByAction(vcs: VerificationCondition[]): Map<string, VerificationCondition[]> {
  const groups = new Map<string, VerificationCondition[]>();
  for (const vc of vcs) {
    const action = vc.metadata.action;
    if (!groups.has(action)) {
      groups.set(action, []);
    }
    groups.get(action)!.push(vc);
  }
  return groups;
}

// Build a map from primary VC ID to its alternative VC
function buildAlternativeMap(vcs: VerificationCondition[]): Map<number, VerificationCondition> {
  const map = new Map<number, VerificationCondition>();
  for (const vc of vcs) {
    if (vc.alternativeFor != null) {
      map.set(vc.alternativeFor, vc);
    }
  }
  return map;
}

// Filter to only show primary VCs (exclude all alternatives, whether dormant or not)
function filterToVisibleVCs(vcs: VerificationCondition[]): VerificationCondition[] {
  return vcs.filter(vc => vc.alternativeFor == null);
}

// ========== Components ==========

function getFilterButtonContent(filter: StatusFilter): React.ReactNode {
  const label = filter === 'all' ? 'All' : filter.charAt(0).toUpperCase() + filter.slice(1);

  switch (filter) {
    case 'all':
      return label;
    case 'pending':
      return <><span className="spinner-small">⏳</span> {label}</>;
    case 'proven':
      return <>✅ {label}</>;
    case 'disproven':
      return <>❌ {label}</>;
    case 'unknown':
      return <>❓ {label}</>;
    case 'error':
      return <>💥 {label}</>;
    default:
      return label;
  }
}

interface PropertyRowProps {
  vc: VerificationCondition;
  alternativeVC?: VerificationCondition;
}

const PropertyRow: React.FC<PropertyRowProps> = ({ vc, alternativeVC }) => {
  const [expanded, setExpanded] = React.useState(false);
  const [showTRCounterexample, setShowTRCounterexample] = React.useState(true);
  const [showRawHtml, setShowRawHtml] = React.useState(false);

  const formatTime = (ms: number | null) => {
    if (ms === null) return null;
    if (ms < 1000) return `${ms}ms`;
    return `${(ms / 1000).toFixed(2)}s`;
  };

  // Check if the alternative (TR) VC is running (not dormant, but no result yet)
  const trIsRunning = alternativeVC && !alternativeVC.isDormant && alternativeVC.status === null;

  // Check if the alternative (TR) VC completed (not dormant and has a result)
  const trCompleted = alternativeVC && !alternativeVC.isDormant && alternativeVC.status !== null;

  // TR was invoked means it's either running or completed
  const trWasInvoked = trIsRunning || trCompleted;

  // Get counterexample from a VC
  const getFirstCounterexample = (targetVC: VerificationCondition): Counterexample | null => {
    if (targetVC.status !== 'disproven') return null;

    for (const discharger of targetVC.timing.dischargers) {
      const counterexamples = discharger.result?.data?.counterexamples;
      if (counterexamples && counterexamples.length > 0) {
        return counterexamples[0];
      }
    }
    return null;
  };

  const wpCounterexample = getFirstCounterexample(vc);
  const trCounterexample = alternativeVC ? getFirstCounterexample(alternativeVC) : null;

  // Determine which counterexample to show (prefer TR when available)
  const hasWPCounterexample = wpCounterexample !== null;
  const hasTRCounterexample = trCounterexample !== null;
  const hasAnyCounterexample = hasWPCounterexample || hasTRCounterexample;
  const hasBothCounterexamples = hasWPCounterexample && hasTRCounterexample;

  // Default to TR counterexample if available, otherwise WP
  const activeCounterexample = (showTRCounterexample && trCounterexample) || wpCounterexample;

  // Get exceptions from the VC
  const exceptions = getExceptionsFromVC(vc);
  const hasExceptions = exceptions.length > 0;

  // Row is expandable if it has counterexamples or exceptions
  const isExpandable = hasAnyCounterexample || hasExceptions;

  // Format the time display
  const getTimeDisplay = (): React.ReactNode => {
    const wpTime = formatTime(vc.timing.totalTime);

    if (trIsRunning) {
      // TR is running: show WP time + spinner
      return wpTime ? <>{wpTime}+<span className="spinner-inline">⏳</span></> : <span className="spinner-inline">⏳</span>;
    }

    if (trCompleted && alternativeVC.timing.totalTime !== null) {
      // TR completed: show combined timing
      const trTime = formatTime(alternativeVC.timing.totalTime);
      if (wpTime && trTime) {
        return `${wpTime}+${trTime}`;
      }
      return trTime || wpTime;
    }

    return wpTime;
  };

  const timeDisplay = getTimeDisplay();

  return (
    <>
      <div
        className={`property-row status-${getStatusClass(vc.status)} ${isExpandable ? 'expandable' : ''}`}
        onClick={() => isExpandable && setExpanded(!expanded)}
        style={{ cursor: isExpandable ? 'pointer' : 'default' }}
      >
        {isExpandable && (
          <span className="property-toggle">{expanded ? '▼' : '▶'}</span>
        )}
        <span className="property-icon">{getStatusIcon(vc.status)}</span>
        <span className="property-name">{vc.metadata.property}</span>
        {trWasInvoked && (
          <span className={`vc-style-badge tr-badge ${trIsRunning ? 'tr-running' : ''}`}>
            TR{trIsRunning && '...'}
          </span>
        )}
        {timeDisplay && (
          <span className="property-time">{timeDisplay}</span>
        )}
      </div>
      {expanded && hasExceptions && (
        <div className="exceptions-container">
          <div className="exceptions-label">Exceptions</div>
          <div className="exceptions-content">
            {exceptions.map((exception, idx) => (
              <pre key={idx} className="exception-item">{exception}</pre>
            ))}
          </div>
        </div>
      )}
      {expanded && activeCounterexample && (
        <div className="counterexample-container">
          {activeCounterexample.structuredJson && !showRawHtml ? (
            <StructuredCexView
              data={activeCounterexample.structuredJson}
              headerRightContent={
                <>
                  <button
                    className="cex-view-toggle"
                    onClick={(e) => { e.stopPropagation(); setShowRawHtml(!showRawHtml); }}
                  >
                    Show raw model
                  </button>
                  {hasBothCounterexamples && (
                    <div className="counterexample-toggle">
                      <button
                        className={`cex-toggle-btn ${showTRCounterexample ? 'active' : ''}`}
                        onClick={(e) => { e.stopPropagation(); setShowTRCounterexample(true); }}
                      >
                        TR
                      </button>
                      <button
                        className={`cex-toggle-btn ${!showTRCounterexample ? 'active' : ''}`}
                        onClick={(e) => { e.stopPropagation(); setShowTRCounterexample(false); }}
                      >
                        WP
                      </button>
                    </div>
                  )}
                </>
              }
            />
          ) : (
            <>
              <div className="counterexample-header">
                <div className="counterexample-label">Counterexample</div>
                <div className="counterexample-toggles">
                  {activeCounterexample.structuredJson && (
                    <button
                      className="cex-view-toggle"
                      onClick={(e) => { e.stopPropagation(); setShowRawHtml(!showRawHtml); }}
                    >
                      Show structured
                    </button>
                  )}
                  {hasBothCounterexamples && (
                    <div className="counterexample-toggle">
                      <button
                        className={`cex-toggle-btn ${showTRCounterexample ? 'active' : ''}`}
                        onClick={(e) => { e.stopPropagation(); setShowTRCounterexample(true); }}
                      >
                        TR
                      </button>
                      <button
                        className={`cex-toggle-btn ${!showTRCounterexample ? 'active' : ''}`}
                        onClick={(e) => { e.stopPropagation(); setShowTRCounterexample(false); }}
                      >
                        WP
                      </button>
                    </div>
                  )}
                </div>
              </div>
              <div className="counterexample-content">
                {typeof activeCounterexample.html === 'string'
                  ? <span dangerouslySetInnerHTML={{ __html: activeCounterexample.html }} />
                  : <HtmlDisplay html={activeCounterexample.html} />
                }
              </div>
            </>
          )}
        </div>
      )}
    </>
  );
};

interface ActionSectionProps {
  action: string;
  vcs: VerificationCondition[];
  alternativeMap: Map<number, VerificationCondition>;
}

const ActionSection: React.FC<ActionSectionProps> = ({ action, vcs, alternativeMap }) => {
  const [expanded, setExpanded] = React.useState(true);

  return (
    <div className="action-section">
      <div className="action-header" onClick={() => setExpanded(!expanded)}>
        <span className="action-toggle">{expanded ? '▼' : '▶'}</span>
        <span className="action-name">{action}</span>
      </div>
      {expanded && (
        <div className="action-properties">
          {vcs.map((vc) => (
            <PropertyRow
              key={vc.id}
              vc={vc}
              alternativeVC={alternativeMap.get(vc.id)}
            />
          ))}
        </div>
      )}
    </div>
  );
};

const VerificationResultsView: React.FC<VerificationResultsProps> = ({ results }) => {
  const [statusFilter, setStatusFilter] = React.useState<StatusFilter>('all');
  const [showRawJson, setShowRawJson] = React.useState(false);

  // Compute status colors with consistent semantic colors across all themes
  const statusColors = React.useMemo(() => {
    const withOpacity = (color: string, opacity: number): string => {
      // Parse hex color to rgba
      const hex = color.replace('#', '');
      const r = parseInt(hex.substring(0, 2), 16);
      const g = parseInt(hex.substring(2, 4), 16);
      const b = parseInt(hex.substring(4, 6), 16);
      return `rgba(${r}, ${g}, ${b}, ${opacity})`;
    }

    // Use consistent semantic colors across all themes
    return {
      proven: {
        border: '#52c41a',  // green
        bg: withOpacity('#52c41a', 0.1),
      },
      disproven: {
        border: '#ff4d4f',  // red
        bg: withOpacity('#ff4d4f', 0.1),
      },
      error: {
        border: '#fa8c16',  // orange
        bg: withOpacity('#fa8c16', 0.1),
      },
      unknown: {
        border: '#1890ff',  // blue
        bg: withOpacity('#1890ff', 0.1),
      },
      pending: {
        border: '#d9d9d9',  // gray
        bg: withOpacity('#d9d9d9', 0.05),
      },
    }
  }, []);

  // Build map from primary VC ID to its alternative VC (from ALL VCs including dormant)
  const alternativeMap = React.useMemo(
    () => buildAlternativeMap(results.vcs),
    [results.vcs]
  );

  // Filter to only show primary VCs (alternatives are shown inline with their primary)
  const visibleVCs = React.useMemo(
    () => filterToVisibleVCs(results.vcs),
    [results.vcs]
  );

  // Compute counts for each status (only from visible/non-dormant VCs)
  const statusCounts = React.useMemo(() => {
    const counts = {
      all: visibleVCs.length,
      pending: 0,
      proven: 0,
      disproven: 0,
      unknown: 0,
      error: 0,
    };

    visibleVCs.forEach((vc) => {
      if (vc.status === null) {
        counts.pending++;
      } else if (vc.status === 'proven') {
        counts.proven++;
      } else if (vc.status === 'disproven') {
        counts.disproven++;
      } else if (vc.status === 'unknown') {
        counts.unknown++;
      } else if (vc.status === 'error') {
        counts.error++;
      }
    });

    return counts;
  }, [visibleVCs]);

  // Filter VCs based on status (from already-visible VCs)
  const filteredVCs = React.useMemo(() => {
    if (statusFilter === 'all') return visibleVCs;
    if (statusFilter === 'pending') return visibleVCs.filter((vc) => vc.status === null);
    return visibleVCs.filter((vc) => vc.status === statusFilter);
  }, [visibleVCs, statusFilter]);

  // Group VCs by action
  const actionGroups = React.useMemo(() => groupByAction(filteredVCs), [filteredVCs]);

  // Separate initialization from other actions
  const initializationVCs = actionGroups.get('initializer') || [];
  const otherActions = Array.from(actionGroups.entries()).filter(
    ([action]) => action !== 'initializer'
  );

  const styles = React.useMemo(() => `
    .vr-root {
      font-family: system-ui, -apple-system, sans-serif;
      max-width: 100%;
      padding: 16px;
      background: var(--vscode-editor-background);
      border-radius: 8px;
    }

    .vr-filters {
      display: flex;
      gap: 8px;
      margin-bottom: 16px;
      padding: 12px;
      background: var(--vscode-editorWidget-background);
      border: 1px solid var(--vscode-panel-border);
      border-radius: 6px;
      flex-wrap: wrap;
      align-items: center;
    }

    .vr-filter-label {
      font-weight: 600;
      font-size: 14px;
      color: var(--vscode-foreground);
    }

    .vr-filter-button {
      padding: 6px 12px;
      border: 1px solid var(--vscode-panel-border);
      background: var(--vscode-editorWidget-background);
      color: var(--vscode-foreground);
      border-radius: 4px;
      cursor: pointer;
      font-size: 13px;
      transition: all 0.2s;
    }

    .vr-filter-button:hover {
      background: var(--vscode-list-hoverBackground);
      border-color: var(--vscode-panel-border);
    }

    .vr-filter-button.active {
      background: var(--vscode-button-background);
      color: var(--vscode-button-foreground);
      border-color: var(--vscode-button-background);
    }

    .vr-section {
      margin-bottom: 24px;
      background: var(--vscode-editorWidget-background);
      border: 1px solid var(--vscode-panel-border);
      border-radius: 6px;
      overflow: hidden;
    }

    .vr-section-title {
      font-weight: 600;
      font-size: 16px;
      padding: 12px 16px;
      background: var(--vscode-editorGroupHeader-tabsBackground);
      border-bottom: 1px solid var(--vscode-panel-border);
      color: var(--vscode-foreground);
    }

    .vr-section-content {
      padding: 12px;
    }

    .action-section {
      margin-bottom: 12px;
      border: 1px solid var(--vscode-panel-border);
      border-radius: 4px;
      overflow: hidden;
    }

    .action-header {
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 10px 12px;
      background: var(--vscode-editorWidget-background);
      cursor: pointer;
      user-select: none;
      transition: background 0.2s;
    }

    .action-header:hover {
      background: var(--vscode-list-hoverBackground);
    }

    .action-toggle {
      font-size: 12px;
      color: var(--vscode-descriptionForeground);
    }

    .action-name {
      font-weight: 600;
      font-size: 14px;
      color: var(--vscode-foreground);
    }

    .action-properties {
      padding: 8px 12px 8px 32px;
      background: var(--vscode-editorWidget-background);
    }

    .property-row {
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 6px 8px;
      margin: 2px 0;
      border-radius: 4px;
      transition: background 0.15s;
    }

    .property-row:hover {
      background: var(--vscode-list-hoverBackground);
    }

    .property-icon {
      font-size: 16px;
      flex-shrink: 0;
    }

    .property-name {
      font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
      font-size: 13px;
      color: var(--vscode-editor-foreground);
      flex-grow: 1;
    }

    .property-time {
      font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
      font-size: 12px;
      margin-left: auto;
      padding: 2px 6px;
      background: var(--vscode-editorWidget-background);
      color: var(--vscode-descriptionForeground);
      border: 1px solid var(--vscode-panel-border);
      border-radius: 6px;
      white-space: nowrap;
    }

    .property-row.status-proven {
      background: ${statusColors.proven.bg};
      border-left: 3px solid ${statusColors.proven.border};
    }

    .property-row.status-disproven {
      background: ${statusColors.disproven.bg};
      border-left: 3px solid ${statusColors.disproven.border};
    }

    .property-row.status-error {
      background: ${statusColors.error.bg};
      border-left: 3px solid ${statusColors.error.border};
    }

    .property-row.status-unknown {
      background: ${statusColors.unknown.bg};
      border-left: 3px solid ${statusColors.unknown.border};
    }

    .property-row.status-pending {
      background: ${statusColors.pending.bg};
      border-left: 3px solid ${statusColors.pending.border};
    }

    .spinner {
      display: inline-block;
      animation: spin 2s linear infinite;
    }

    .spinner-small {
      display: inline-block;
      font-size: 14px;
    }

    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }

    .vr-empty {
      padding: 24px;
      text-align: center;
      color: var(--vscode-disabledForeground);
      font-style: italic;
    }

    .property-row.expandable:hover {
      background: var(--vscode-list-activeSelectionBackground);
      opacity: 0.9;
    }

    .property-toggle {
      font-size: 12px;
      color: var(--vscode-descriptionForeground);
      margin-right: 4px;
      flex-shrink: 0;
    }

    .counterexample-container {
      margin-left: 32px;
      margin-top: 8px;
      margin-bottom: 8px;
      padding: 12px;
      background: var(--vscode-editorWidget-background);
      border-left: 3px solid #ff4d4f;
      border-radius: 4px;
      overflow-x: auto;
    }

    .counterexample-label {
      font-weight: 600;
      font-size: 12px;
      color: var(--vscode-descriptionForeground);
      margin-bottom: 8px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .counterexample-content {
      font-size: 13px;
      color: var(--vscode-editor-foreground);
    }

    .exceptions-container {
      margin-left: 32px;
      margin-top: 8px;
      margin-bottom: 8px;
      padding: 12px;
      background: var(--vscode-editorWidget-background);
      border-left: 3px solid #fa8c16;
      border-radius: 4px;
      overflow-x: auto;
    }

    .exceptions-label {
      font-weight: 600;
      font-size: 12px;
      color: var(--vscode-descriptionForeground);
      margin-bottom: 8px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .exceptions-content {
      display: flex;
      flex-direction: column;
      gap: 8px;
    }

    .exception-item {
      margin: 0;
      padding: 8px 12px;
      background: var(--vscode-inputValidation-errorBackground, rgba(250, 140, 22, 0.1));
      border: 1px solid var(--vscode-inputValidation-errorBorder, #fa8c16);
      border-radius: 4px;
      font-family: ui-monospace, SFMono-Regular, Menlo, Consolas, "Liberation Mono", monospace;
      font-size: 12px;
      color: var(--vscode-editor-foreground);
      white-space: pre-wrap;
      word-break: break-word;
      overflow-wrap: break-word;
    }

    .counterexample-column-header {
      text-align: left;
    }

    .counterexample-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 8px;
    }

    .counterexample-toggle {
      display: flex;
      gap: 4px;
    }

    .cex-toggle-btn {
      padding: 2px 8px;
      font-size: 11px;
      font-weight: 500;
      border: 1px solid var(--vscode-panel-border);
      background: var(--vscode-editorWidget-background);
      color: var(--vscode-foreground);
      border-radius: 3px;
      cursor: pointer;
      transition: all 0.15s;
    }

    .cex-toggle-btn:hover {
      background: var(--vscode-list-hoverBackground);
    }

    .cex-toggle-btn.active {
      background: var(--vscode-button-background);
      color: var(--vscode-button-foreground);
      border-color: var(--vscode-button-background);
    }

    .vc-style-badge {
      font-size: 10px;
      font-weight: 600;
      padding: 2px 6px;
      border-radius: 3px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      flex-shrink: 0;
    }

    .tr-badge {
      background: rgba(24, 144, 255, 0.15);
      color: #1890ff;
      border: 1px solid rgba(24, 144, 255, 0.3);
    }

    .tr-badge.tr-running {
      animation: pulse 1.5s ease-in-out infinite;
    }

    @keyframes pulse {
      0%, 100% {
        opacity: 1;
        background: rgba(24, 144, 255, 0.15);
      }
      50% {
        opacity: 0.7;
        background: rgba(24, 144, 255, 0.3);
      }
    }

    .spinner-inline {
      display: inline-block;
      animation: spin 2s linear infinite;
    }

    .vr-toolbar {
      display: flex;
      justify-content: flex-end;
      padding: 4px 0;
      margin-bottom: 8px;
    }

    .vr-toggle-link {
      font-size: 11px;
      color: var(--vscode-textLink-foreground);
      cursor: pointer;
      text-decoration: none;
      background: none;
      border: none;
      padding: 2px 6px;
      border-radius: 3px;
    }

    .vr-toggle-link:hover {
      text-decoration: underline;
      background: var(--vscode-toolbar-hoverBackground);
    }

    .vr-json-view {
      position: relative;
      background: var(--vscode-editor-background);
      border: 1px solid var(--vscode-panel-border);
      border-radius: 6px;
      max-height: 600px;
    }
    .vr-json-content {
      padding: 12px;
      font-family: ui-monospace, SFMono-Regular, Menlo, Consolas, "Liberation Mono", monospace;
      font-size: 12px;
      white-space: pre;
      overflow: auto;
      max-height: 600px;
    }
    .vr-copy-button {
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
    .vr-json-view:hover .vr-copy-button,
    .vr-json-content:hover ~ .vr-copy-button {
      opacity: 1;
    }
    .vr-copy-button:hover {
      background: var(--vscode-button-hoverBackground);
    }
    .vr-copy-button svg {
      width: 14px;
      height: 14px;
    }

    /* Structured counterexample styles */
    .counterexample-toggles {
      display: flex;
      gap: 12px;
      align-items: center;
    }

    .cex-view-toggle {
      font-size: 11px;
      color: var(--vscode-textLink-foreground);
      cursor: pointer;
      text-decoration: none;
      background: none;
      border: none;
      padding: 2px 6px;
      border-radius: 3px;
    }

    .cex-view-toggle:hover {
      text-decoration: underline;
      background: var(--vscode-toolbar-hoverBackground);
    }

    .cex-structured-view {
      font-family: system-ui, -apple-system, sans-serif;
    }

    .cex-header-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 12px;
    }

    .cex-header-left {
      display: flex;
      align-items: center;
      gap: 12px;
    }

    .cex-header-right {
      display: flex;
      align-items: center;
      gap: 12px;
    }

    .cex-header-label {
      font-weight: 600;
      font-size: 12px;
      color: var(--vscode-descriptionForeground);
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .cex-instantiation-row {
      display: flex;
      align-items: center;
      gap: 12px;
      margin-bottom: 12px;
      padding: 8px 12px;
      background: var(--vscode-editorWidget-background);
      border: 1px solid var(--vscode-panel-border);
      border-radius: 6px;
    }

    .cex-instantiation-label {
      font-size: 10px;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      color: var(--vscode-descriptionForeground);
      flex-shrink: 0;
    }

    .cex-instantiation-values {
      display: flex;
      flex-wrap: wrap;
      gap: 8px;
    }

    .cex-instantiation-item {
      display: inline-flex;
      align-items: center;
      gap: 4px;
      padding: 3px 10px;
      background: var(--vscode-badge-background, rgba(0, 122, 204, 0.15));
      border-radius: 12px;
      font-size: 12px;
    }

    .cex-instantiation-key {
      color: var(--vscode-descriptionForeground);
      font-weight: 500;
    }

    .cex-instantiation-eq {
      color: var(--vscode-descriptionForeground);
      opacity: 0.6;
    }

    .cex-instantiation-val {
      color: var(--vscode-foreground);
      font-weight: 500;
    }

    .cex-transition-row {
      display: flex;
      align-items: center;
      gap: 16px;
      margin-bottom: 12px;
    }

    .cex-transition-column {
      flex: 1;
      min-width: 280px;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .cex-connector-line {
      flex: 1;
      height: 2px;
      background: var(--vscode-panel-border);
      opacity: 0.4;
    }

    .cex-transition-center {
      flex-shrink: 0;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .cex-transition-state {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      padding: 8px 16px;
      border-radius: 6px;
      font-size: 12px;
      font-weight: 500;
    }

    .cex-transition-pre {
      background: var(--vscode-diffEditor-insertedTextBackground, rgba(0, 180, 0, 0.15));
      border: 1px solid var(--vscode-diffEditor-insertedLineBackground, rgba(0, 180, 0, 0.3));
    }

    .cex-transition-post {
      background: var(--vscode-diffEditor-removedTextBackground, rgba(255, 80, 80, 0.15));
      border: 1px solid var(--vscode-diffEditor-removedLineBackground, rgba(255, 80, 80, 0.3));
    }

    .cex-transition-icon {
      font-size: 14px;
      font-weight: 700;
    }

    .cex-icon-valid {
      color: var(--vscode-testing-iconPassed, #4caf50);
    }

    .cex-icon-invalid {
      color: var(--vscode-testing-iconFailed, #f44336);
    }

    .cex-transition-label {
      color: var(--vscode-foreground);
    }

    .cex-action-chip {
      display: inline-block;
      font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
      font-size: 12px;
      font-weight: 600;
      background: var(--vscode-activityBarBadge-background, #007acc);
      color: var(--vscode-activityBarBadge-foreground, #fff);
      border-radius: 999px;
      padding: 4px 12px;
      line-height: 1.4;
    }

    .cex-states-container {
      display: flex;
      gap: 16px;
      flex-wrap: wrap;
    }

    .cex-state-panel {
      flex: 1;
      min-width: 280px;
      max-width: 100%;
      background: var(--vscode-editor-background);
      border: 1px solid var(--vscode-panel-border);
      border-radius: 6px;
      overflow: hidden;
    }

    .cex-state-header {
      font-weight: 600;
      font-size: 12px;
      padding: 8px 12px;
      background: var(--vscode-editorGroupHeader-tabsBackground);
      border-bottom: 1px solid var(--vscode-panel-border);
      color: var(--vscode-foreground);
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .cex-state-body {
      padding: 8px;
    }

    .cex-empty-state {
      padding: 12px;
      text-align: center;
      color: var(--vscode-disabledForeground);
      font-style: italic;
      font-size: 12px;
    }

    .cex-kv-table {
      border: 1px solid var(--vscode-panel-border);
      border-radius: 4px;
      overflow: hidden;
    }

    .cex-kv-row {
      display: grid;
      grid-template-columns: minmax(80px, auto) auto 1fr;
      gap: 8px;
      padding: 6px 10px;
      align-items: baseline;
      border-bottom: 1px solid var(--vscode-panel-border);
      background: var(--vscode-editorWidget-background);
      transition: background-color 0.15s ease, border-left-color 0.15s ease;
      border-left: 3px solid transparent;
    }

    .cex-kv-row:last-child {
      border-bottom: none;
    }

    .cex-kv-row.changed {
      background: var(--vscode-editor-findMatchHighlightBackground, rgba(255, 213, 0, 0.15));
      border-left: 3px solid var(--vscode-editor-findMatchHighlightBorder, #ffd500);
    }

    .cex-kv-key {
      font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
      font-size: 11px;
      word-break: break-all;
    }

    .cex-kv-key code {
      background: transparent;
      padding: 0;
      color: var(--vscode-foreground);
    }

    .cex-kv-sep {
      color: var(--vscode-descriptionForeground);
      font-size: 11px;
    }

    .cex-kv-val {
      font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
      font-size: 11px;
      word-break: break-all;
    }

    .cex-kv-val code {
      background: transparent;
      padding: 0;
      color: var(--vscode-foreground);
    }

    .cex-changed-element {
      background: var(--vscode-diffEditor-insertedTextBackground, rgba(0, 255, 0, 0.2));
      border-radius: 3px;
      padding: 2px 4px;
      box-shadow: 0 0 0 2px var(--vscode-diffEditor-insertedLineBackground, rgba(0, 255, 0, 0.3));
      color: var(--vscode-editor-foreground);
    }

    .cex-removed-element {
      background: var(--vscode-diffEditor-removedTextBackground, rgba(255, 0, 0, 0.2));
      border-radius: 3px;
      padding: 2px 4px;
      box-shadow: 0 0 0 2px var(--vscode-diffEditor-removedLineBackground, rgba(255, 0, 0, 0.3));
      color: var(--vscode-editor-foreground);
      text-decoration: line-through;
      opacity: 0.8;
    }

    .cex-list {
      margin: 4px 0 0 0;
      padding: 0;
      list-style: none;
    }

    .cex-list li {
      font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
      font-size: 11px;
      line-height: 1.4;
      background: transparent;
      color: var(--vscode-foreground);
      margin: 2px 0;
    }

    .cex-toolbar {
      display: flex;
      gap: 12px;
    }

    .cex-toolbar-btn {
      font-size: 11px;
      color: var(--vscode-textLink-foreground);
      cursor: pointer;
      text-decoration: none;
      background: none;
      border: none;
      padding: 2px 6px;
      border-radius: 3px;
    }

    .cex-toolbar-btn:hover {
      text-decoration: underline;
      background: var(--vscode-toolbar-hoverBackground);
    }

    .cex-filter-active {
      color: var(--vscode-notificationsInfoIcon-foreground, #3794ff);
      font-weight: 600;
    }

    .cex-filter-backdrop {
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0, 0, 0, 0.3);
      z-index: 999;
    }

    .cex-filter-panel {
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

    .cex-filter-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 8px 12px;
      border-bottom: 1px solid var(--vscode-panel-border);
      font-weight: 600;
      font-size: 12px;
    }

    .cex-filter-actions {
      display: flex;
      gap: 8px;
    }

    .cex-filter-action {
      font-size: 10px;
      color: var(--vscode-textLink-foreground);
      background: none;
      border: none;
      cursor: pointer;
      padding: 2px 4px;
    }

    .cex-filter-action:hover {
      text-decoration: underline;
    }

    .cex-filter-close {
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

    .cex-filter-close:hover {
      opacity: 1;
    }

    .cex-filter-list {
      padding: 8px;
      max-height: 240px;
      overflow-y: auto;
    }

    .cex-filter-item {
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 4px;
      cursor: pointer;
      border-radius: 3px;
      font-size: 12px;
    }

    .cex-filter-item:hover {
      background: var(--vscode-list-hoverBackground);
    }

    .cex-filter-item input {
      margin: 0;
    }

  `, [statusColors]);

  const prettyJson = JSON.stringify(results, null, 2);

  return (
    <>
      <style>{styles}</style>
      <div className="vr-root">
        {/* Toolbar with JSON toggle */}
        <div className="vr-toolbar">
          <button className="vr-toggle-link" onClick={() => setShowRawJson(!showRawJson)}>
            {showRawJson ? "Show formatted" : "Show JSON"}
          </button>
        </div>

        {showRawJson ? (
          <div className="vr-json-view">
            <CopyButton text={prettyJson} className="vr-copy-button" />
            <div className="vr-json-content">
              {prettyJson}
            </div>
          </div>
        ) : (
          <>
            {/* Filters */}
            <div className="vr-filters">
              <span className="vr-filter-label">Filter by status ({results.totalVCs} VCs):</span>
              {(['all', 'pending', 'proven', 'disproven', 'unknown', 'error'] as StatusFilter[]).map((filter) => {
                // Only show filter buttons for groups with elements
                if (statusCounts[filter] === 0) return null;
                return (
                  <button
                    key={filter}
                    className={`vr-filter-button ${statusFilter === filter ? 'active' : ''}`}
                    onClick={() => setStatusFilter(filter)}
                  >
                    {getFilterButtonContent(filter)} ({statusCounts[filter]})
                  </button>
                );
              })}
            </div>

            {filteredVCs.length === 0 ? (
              <div className="vr-empty">No verification conditions match the selected filter.</div>
            ) : (
              <>
                {/* Initialization Section */}
                {initializationVCs.length > 0 && (
                  <div className="vr-section">
                    <div className="vr-section-title">
                      Initialization must establish the invariant:
                    </div>
                    <div className="vr-section-content">
                      <div className="action-properties">
                        {initializationVCs.map((vc) => (
                          <PropertyRow
                            key={vc.id}
                            vc={vc}
                            alternativeVC={alternativeMap.get(vc.id)}
                          />
                        ))}
                      </div>
                    </div>
                  </div>
                )}

                {/* Actions Section */}
                {otherActions.length > 0 && (
                  <div className="vr-section">
                    <div className="vr-section-title">
                      The following set of actions must preserve the invariant:
                    </div>
                    <div className="vr-section-content">
                      {otherActions.map(([action, vcs]) => (
                        <ActionSection
                          key={action}
                          action={action}
                          vcs={vcs}
                          alternativeMap={alternativeMap}
                        />
                      ))}
                    </div>
                  </div>
                )}
              </>
            )}
          </>
        )}
      </div>
    </>
  );
};

export default VerificationResultsView;
