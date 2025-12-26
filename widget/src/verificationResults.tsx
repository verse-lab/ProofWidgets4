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

interface Counterexample {
  model?: any;
  html: Html;
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
          <div className="exceptions-label">Exceptions:</div>
          <div className="exceptions-content">
            {exceptions.map((exception, idx) => (
              <pre key={idx} className="exception-item">{exception}</pre>
            ))}
          </div>
        </div>
      )}
      {expanded && activeCounterexample && (
        <div className="counterexample-container">
          <div className="counterexample-header">
            <div className="counterexample-label">Counterexample:</div>
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
          <div className="counterexample-content">
            <HtmlDisplay html={activeCounterexample.html} />
          </div>
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
