import * as React from 'react';
import HtmlDisplay, { Html } from './htmlDisplay';

// ========== Types ==========

interface VCMetadata {
  stmtDerivedFrom?: string[];
  property: string;
  kind?: string;
  action: string;
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
}

interface Discharger {
  id: number;
  name: string;
  status: string;
  time: number;
  result?: DischargerResult;
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

/** Simple JSON syntax highlighting */
function highlightJson(json: string): React.ReactNode {
  const parts = json.split(/("(?:[^"\\]|\\.)*"|\btrue\b|\bfalse\b|\bnull\b|-?\d+(?:\.\d+)?(?:[eE][+-]?\d+)?)/g);

  return parts.map((part, i) => {
    if (!part) return null;
    if (part.startsWith('"')) {
      const isKey = json.indexOf(part + ':') !== -1 || json.indexOf(part + ' :') !== -1;
      return <span key={i} className={isKey ? "json-key" : "json-string"}>{part}</span>;
    }
    if (part === 'true' || part === 'false') {
      return <span key={i} className="json-boolean">{part}</span>;
    }
    if (part === 'null') {
      return <span key={i} className="json-null">{part}</span>;
    }
    if (/^-?\d+(?:\.\d+)?(?:[eE][+-]?\d+)?$/.test(part)) {
      return <span key={i} className="json-number">{part}</span>;
    }
    return <span key={i}>{part}</span>;
  });
}

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

const PropertyRow: React.FC<{ vc: VerificationCondition }> = ({ vc }) => {
  const [expanded, setExpanded] = React.useState(false);

  const formatTime = (ms: number | null) => {
    if (ms === null) return null;
    if (ms < 1000) return `${ms}ms`;
    return `${(ms / 1000).toFixed(2)}s`;
  };

  // Check if this disproven VC has counterexamples
  const getFirstCounterexample = (): Counterexample | null => {
    if (vc.status !== 'disproven') return null;

    for (const discharger of vc.timing.dischargers) {
      const counterexamples = discharger.result?.data?.counterexamples;
      if (counterexamples && counterexamples.length > 0) {
        return counterexamples[0];
      }
    }
    return null;
  };

  const counterexample = getFirstCounterexample();
  const hasCounterexample = counterexample !== null;

  return (
    <>
      <div
        className={`property-row status-${getStatusClass(vc.status)} ${hasCounterexample ? 'expandable' : ''}`}
        onClick={() => hasCounterexample && setExpanded(!expanded)}
        style={{ cursor: hasCounterexample ? 'pointer' : 'default' }}
      >
        {hasCounterexample && (
          <span className="property-toggle">{expanded ? '▼' : '▶'}</span>
        )}
        <span className="property-icon">{getStatusIcon(vc.status)}</span>
        <span className="property-name">{vc.metadata.property}</span>
        {vc.timing.totalTime !== null && (
          <span className="property-time">{formatTime(vc.timing.totalTime)}</span>
        )}
      </div>
      {expanded && counterexample && (
        <div className="counterexample-container">
          <div className="counterexample-label">Counterexample:</div>
          <div className="counterexample-content">
            <HtmlDisplay html={counterexample.html} />
          </div>
        </div>
      )}
    </>
  );
};

const ActionSection: React.FC<{
  action: string;
  vcs: VerificationCondition[];
}> = ({ action, vcs }) => {
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
            <PropertyRow key={vc.id} vc={vc} />
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

  // Compute counts for each status
  const statusCounts = React.useMemo(() => {
    const counts = {
      all: results.vcs.length,
      pending: 0,
      proven: 0,
      disproven: 0,
      unknown: 0,
      error: 0,
    };

    results.vcs.forEach((vc) => {
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
  }, [results.vcs]);

  // Filter VCs based on status
  const filteredVCs = React.useMemo(() => {
    if (statusFilter === 'all') return results.vcs;
    if (statusFilter === 'pending') return results.vcs.filter((vc) => vc.status === null);
    return results.vcs.filter((vc) => vc.status === statusFilter);
  }, [results.vcs, statusFilter]);

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

    .counterexample-column-header {
      text-align: left;
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
      color: var(--vscode-foreground);
      background: var(--vscode-button-secondaryBackground);
      border: 1px solid var(--vscode-panel-border);
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
      background: var(--vscode-button-secondaryHoverBackground);
    }
    .vr-copy-button svg {
      width: 14px;
      height: 14px;
    }

    .json-key { color: var(--vscode-symbolIcon-propertyForeground, #9cdcfe); }
    .json-string { color: var(--vscode-symbolIcon-stringForeground, #ce9178); }
    .json-number { color: var(--vscode-symbolIcon-numberForeground, #b5cea8); }
    .json-boolean { color: var(--vscode-symbolIcon-booleanForeground, #569cd6); }
    .json-null { color: var(--vscode-symbolIcon-nullForeground, #569cd6); }

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
              {highlightJson(prettyJson)}
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
                          <PropertyRow key={vc.id} vc={vc} />
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
                        <ActionSection key={action} action={action} vcs={vcs} />
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
