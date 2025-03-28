import { UserResponse } from "@/api/models/user/UserResponse";

export type UserPageResponse = {
  code: number;
  data: PageResponse;
  msg: string;
};

export type PageResponse = {
  total: number;
  size: number;
  pages: number;
  records: Array<UserResponse>;
};
