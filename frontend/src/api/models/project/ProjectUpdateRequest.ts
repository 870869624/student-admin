export type ProjectUpdateRequest = {
  id: number;
  name: string;
  description: string;
  start_date: number;
  expected_end_date?: number;
  status: string;
  userId: number;
  department: string;
  teacher_id: number;
  batch: string;
  source: string;
  participant?: number[];
  result_type: string;
  file_path: string;
  stage_id: number;
  stage_status: string;
};
