import {
  CancelablePromise,
  OpenAPI,
  ProjectDelayAddRequest,
  Response,
} from "@/api";
import { request as __request } from "@/api/core/request";
import { DeleteRequest } from "@/api/models/DeleteRequest";

export class ProjectDelayControllerService {
  public static Delete(
    requestBody: DeleteRequest
  ): CancelablePromise<Response> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/project/delay/delete",
      body: requestBody,
      mediaType: "application/json",
    });
  }

  public static Add(
    requestBody: ProjectDelayAddRequest
  ): CancelablePromise<Response> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/project/delay/add",
      body: requestBody,
      mediaType: "application/json",
    });
  }
}
