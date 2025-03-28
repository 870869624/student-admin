import { ProjectResponse } from "@/api/models/project/ProjectResponse";

export type ProjectPageResponse = {
  code: number;
  data: PageResponse;
  msg: string;
};

export type PageResponse = {
  total: number;
  size: number;
  pages: number;
  records: Array<ProjectResponse>;
};
