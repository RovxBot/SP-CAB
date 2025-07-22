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
