import {
  CancelablePromise,
  OpenAPI,
  ProjectStageUpdateRequest,
  Response,
} from "@/api";
import { request as __request } from "@/api/core/request";

export class ProjectStageControllerService {
  public static Update(
    requestBody: ProjectStageUpdateRequest
  ): CancelablePromise<Response> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/project/stage/update",
      body: requestBody,
      mediaType: "application/json",
    });
  }
}
