import { CancelablePromise, OpenAPI, Response } from "@/api";
import { request as __request } from "@/api/core/request";
import { ProjectDownAddRequest } from "@/api/models/project_down/ProjectDownAddRequest";

export class ProjectDownControllerService {
  public static Add(
    requestBody: ProjectDownAddRequest
  ): CancelablePromise<Response> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/project/down/add",
      body: requestBody,
      mediaType: "application/json",
    });
  }
}
