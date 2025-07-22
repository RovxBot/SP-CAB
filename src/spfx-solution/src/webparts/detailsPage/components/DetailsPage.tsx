import * as React from 'react';
import styles from './DetailsPage.module.scss';

export interface IDetailsPageProps {
  change: {
    Title: string;
    Description: string;
    Status: string;
    Priority: string;
    CreatedDate: string;
    ModifiedDate: string;
    Impact?: string;
    Category?: string;
    PublishedDate?: string;
    IngestedDate?: string;
    UserPriority?: string;
  };
  auditLog?: Array<{ date: string; action: string; user: string; comment?: string }>;
  onApprove?: () => void;
  onReject?: () => void;
  onEdit?: () => void;
  onBack?: () => void;
}

const statusClassMap: { [key: string]: string } = {
  approved: styles.approved,
  rejected: styles.rejected,
  submitted: styles.submitted,
  inprogress: styles.inprogress
};

const DetailsPage: React.FC<IDetailsPageProps> = ({ change, auditLog = [], onApprove, onReject, onEdit, onBack }) => {
  return (
    <div className={styles.detailsCard}>
      <div className={styles.header}>
        <h2>{change.Title}</h2>
        <span className={`${styles.badge} ${statusClassMap[change.Status.toLowerCase()] || ''}`}>{change.Status}</span>
      </div>
      <div className={styles.section}>
        <label>Description</label>
        <p>{change.Description}</p>
      </div>
      <div className={styles.meta}>
        <span className={styles.badge}>{change.Priority}</span>
        <span>Created: {change.CreatedDate}</span>
        <span>Modified: {change.ModifiedDate}</span>
        {change.Impact && <span>Impact: {change.Impact}</span>}
        {change.Category && <span>Category: {change.Category}</span>}
        {change.PublishedDate && <span>Published: {change.PublishedDate}</span>}
        {change.IngestedDate && <span>Ingested: {change.IngestedDate}</span>}
        {change.UserPriority && <span>User Priority: {change.UserPriority}</span>}
      </div>
      <div className={styles.actions}>
        {onApprove && <button onClick={onApprove}>Approve</button>}
        {onReject && <button onClick={onReject}>Reject</button>}
        {onEdit && <button onClick={onEdit}>Edit</button>}
        {onBack && <button onClick={onBack}>Back to Dashboard</button>}
      </div>
      <div className={styles.auditLog}>
        <h3>Change Log</h3>
        <ul>
          {auditLog.map((log, idx) => (
            <li key={idx}>
              <strong>{log.date}</strong>: {log.action} by {log.user} {log.comment && `- ${log.comment}`}
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
};

export default DetailsPage;
