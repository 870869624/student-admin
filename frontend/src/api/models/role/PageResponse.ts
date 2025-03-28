import { RoleResponse } from "@/api";

export type RolePageResponse = {
  code: number;
  data: PageResponse;
  msg: string;
};

export type PageResponse = {
  total: number;
  size: number;
  pages: number;
  records: Array<RoleResponse>;
};
