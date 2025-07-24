import * as React from 'react';
import styles from './SubmissionForm.module.scss';
import { ISubmissionFormProps } from './ISubmissionFormProps';

const priorities = ['High', 'Medium', 'Low'];

const SubmissionForm: React.FC<ISubmissionFormProps> = (props): JSX.Element => {
  const [title, setTitle] = React.useState('');
  const [description, setDescription] = React.useState('');
  const [priority, setPriority] = React.useState(priorities[1]);
  const [status, setStatus] = React.useState('Submitted');
  const [loading, setLoading] = React.useState(false);
  const [success, setSuccess] = React.useState('');
  const [error, setError] = React.useState('');

  const handleSubmit = async (e: React.FormEvent): Promise<void> => {
    e.preventDefault();
    setLoading(true);
    setSuccess('');
    setError('');
    try {
      await props.sp.web.lists.getByTitle('Internal Change Requests').items.add({
        Title: title,
        Description: description,
        Priority: priority,
        Status: status
      });
      setSuccess('Change request submitted successfully!');
      setTitle('');
      setDescription('');
      setPriority(priorities[1]);
      setStatus('Submitted');
    } catch {
      setError('Error submitting change request. Please try again.');
    }
    setLoading(false);
  };

  return (
    <form className={styles.submissionForm} onSubmit={handleSubmit}>
      <h2>Submit Internal Change Request</h2>
      {success && <div className={styles.success}>{success}</div>}
      {error && <div className={styles.error}>{error}</div>}
      <div>
        <label>Title</label>
        <input type="text" value={title} onChange={e => setTitle(e.target.value)} required />
      </div>
      <div>
        <label>Description</label>
        <textarea value={description} onChange={e => setDescription(e.target.value)} required />
      </div>
      <div>
        <label>Priority</label>
        <select value={priority} onChange={e => setPriority(e.target.value)}>
          {priorities.map(p => <option key={p} value={p}>{p}</option>)}
        </select>
      </div>
      <div>
        <label>Status</label>
        <input type="text" value={status} onChange={e => setStatus(e.target.value)} readOnly />
      </div>
      <button type="submit" disabled={loading}>{loading ? 'Submitting...' : 'Submit'}</button>
    </form>
  );
};

export default SubmissionForm;
