export type ProjectAddRequest = {
  name: string;
  description: string;
  start_date: number;
  expected_end_date: number;
  user_id: number;
  department: string;
  teacher_id: number;
  batch: string;
  source: string;
  participant: number[];
  result_type: string;
  file_path: string;
};
