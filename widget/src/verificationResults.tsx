import * as React from 'react';

// ========== Types ==========

interface VCMetadata {
  stmtDerivedFrom?: string[];
  property: string;
  kind?: string;
  action: string;
}

interface Discharger {
  id: number;
  name: string;
  status: string;
  time: number;
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
  const formatTime = (ms: number | null) => {
    if (ms === null) return null;
    if (ms < 1000) return `${ms}ms`;
    return `${(ms / 1000).toFixed(2)}s`;
  };

  return (
    <div className={`property-row status-${getStatusClass(vc.status)}`}>
      <span className="property-icon">{getStatusIcon(vc.status)}</span>
      <span className="property-name">{vc.metadata.property}</span>
      {vc.timing.totalTime !== null && (
        <span className="property-time">{formatTime(vc.timing.totalTime)}</span>
      )}
    </div>
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

  const styles = `
    .vr-root {
      font-family: system-ui, -apple-system, sans-serif;
      max-width: 100%;
      padding: 16px;
      background: #fafafa;
      border-radius: 8px;
    }

    .vr-filters {
      display: flex;
      gap: 8px;
      margin-bottom: 16px;
      padding: 12px;
      background: white;
      border: 1px solid #e0e0e0;
      border-radius: 6px;
      flex-wrap: wrap;
      align-items: center;
    }

    .vr-filter-label {
      font-weight: 600;
      font-size: 14px;
      color: #333;
    }

    .vr-filter-button {
      padding: 6px 12px;
      border: 1px solid #d0d0d0;
      background: white;
      border-radius: 4px;
      cursor: pointer;
      font-size: 13px;
      transition: all 0.2s;
    }

    .vr-filter-button:hover {
      background: #f5f5f5;
      border-color: #999;
    }

    .vr-filter-button.active {
      background: #1890ff;
      color: white;
      border-color: #1890ff;
    }

    .vr-section {
      margin-bottom: 24px;
      background: white;
      border: 1px solid #e0e0e0;
      border-radius: 6px;
      overflow: hidden;
    }

    .vr-section-title {
      font-weight: 600;
      font-size: 16px;
      padding: 12px 16px;
      background: #f0f0f0;
      border-bottom: 1px solid #e0e0e0;
      color: #333;
    }

    .vr-section-content {
      padding: 12px;
    }

    .action-section {
      margin-bottom: 12px;
      border: 1px solid #e8e8e8;
      border-radius: 4px;
      overflow: hidden;
    }

    .action-header {
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 10px 12px;
      background: #fafafa;
      cursor: pointer;
      user-select: none;
      transition: background 0.2s;
    }

    .action-header:hover {
      background: #f0f0f0;
    }

    .action-toggle {
      font-size: 12px;
      color: #666;
    }

    .action-name {
      font-weight: 600;
      font-size: 14px;
      color: #333;
    }

    .action-properties {
      padding: 8px 12px 8px 32px;
      background: white;
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
      background: #f9f9f9;
    }

    .property-icon {
      font-size: 16px;
      flex-shrink: 0;
    }

    .property-name {
      font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
      font-size: 13px;
      color: #333;
      flex-grow: 1;
    }

    .property-time {
      font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
      font-size: 12px;
      color: #666;
      margin-left: auto;
      padding: 2px 6px;
      background: #f5f5f5;
      border-radius: 3px;
      white-space: nowrap;
    }

    .property-row.status-proven {
      background: #f6ffed;
      border-left: 3px solid #52c41a;
    }

    .property-row.status-disproven {
      background: #fff1f0;
      border-left: 3px solid #ff4d4f;
    }

    .property-row.status-error {
      background: #fff7e6;
      border-left: 3px solid #fa8c16;
    }

    .property-row.status-unknown {
      background: #f0f5ff;
      border-left: 3px solid #1890ff;
    }

    .property-row.status-pending {
      background: #fefefe;
      border-left: 3px solid #d9d9d9;
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
      color: #999;
      font-style: italic;
    }
  `;

  return (
    <>
      <style>{styles}</style>
      <div className="vr-root">
        {/* Filters */}
        <div className="vr-filters">
          <span className="vr-filter-label">Filter by status ({results.totalVCs} VCs):</span>
          {(['all', 'pending', 'proven', 'disproven', 'unknown', 'error'] as StatusFilter[]).map((filter) => (
            <button
              key={filter}
              className={`vr-filter-button ${statusFilter === filter ? 'active' : ''}`}
              onClick={() => setStatusFilter(filter)}
            >
              {getFilterButtonContent(filter)} ({statusCounts[filter]})
            </button>
          ))}
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
      </div>
    </>
  );
};

export default VerificationResultsView;
