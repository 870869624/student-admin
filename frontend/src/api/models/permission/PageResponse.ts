import { PermissionResponse } from "@/api/models/permission/PermissionResponse";

export type PermissionPageResponse = {
  code: number;
  data: PageResponse;
  msg: string;
};

export type PageResponse = {
  total: number;
  size: number;
  pages: number;
  records: Array<PermissionResponse>;
};
