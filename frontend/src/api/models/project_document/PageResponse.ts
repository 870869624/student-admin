import { ProjectDocumentResponse } from "@/api/models/project_document/ProjectDocumentResponse";

export type ProjectDocumentPageResponse = {
  code: number;
  data: PageResponse;
  msg: string;
};

export type PageResponse = {
  total: number;
  size: number;
  pages: number;
  records: Array<ProjectDocumentResponse>;
};
