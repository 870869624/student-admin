export type UserListRequest = {
  current: number;
  page_size: number;
  account: string;
  username: string;
  department: string;
  organization: string;
  job: string;
  role_id: number;
};
