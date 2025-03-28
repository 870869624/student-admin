export type ProjectListRequest = {
  current: number;
  page_size: number;
  name: string;
  description: string;
  department: string;
  batch: string;
  source: string;
  result_type: string;
  status: string;
  user_id: number;
};
