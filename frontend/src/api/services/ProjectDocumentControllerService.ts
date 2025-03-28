import { PageRequest } from "@/api/models/PageRequest";
import { CancelablePromise, OpenAPI } from "@/api";
import { request as __request } from "@/api/core/request";
import { ProjectDocumentPageResponse } from "@/api/models/project_document/PageResponse";

export class ProjectDocumentControllerService {
  public static List(
    requestBody: PageRequest
  ): CancelablePromise<ProjectDocumentPageResponse> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/project/document/list",
      body: requestBody,
      mediaType: "application/json",
    });
  }
}
