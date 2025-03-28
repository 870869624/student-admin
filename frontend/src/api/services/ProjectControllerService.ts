import {
  CancelablePromise,
  OpenAPI,
  ProjectAddRequest,
  ProjectListRequest,
  ProjectPageResponse,
  ProjectUpdateRequest,
  ProjectUpdateStatusRequest,
  Response,
} from "@/api";
import { request as __request } from "@/api/core/request";
import { DeleteRequest } from "@/api/models/DeleteRequest";

export class ProjectControllerService {
  public static Add(
    requestBody: ProjectAddRequest
  ): CancelablePromise<Response> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/project/add",
      body: requestBody,
      mediaType: "application/json",
    });
  }

  public static List(
    requestBody: ProjectListRequest
  ): CancelablePromise<ProjectPageResponse> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/project/list",
      body: requestBody,
      mediaType: "application/json",
    });
  }

  public static Delete(
    requestBody: DeleteRequest
  ): CancelablePromise<Response> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/project/delete",
      body: requestBody,
      mediaType: "application/json",
    });
  }

  public static Update(
    requestBody: ProjectUpdateRequest
  ): CancelablePromise<Response> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/project/update",
      body: requestBody,
      mediaType: "application/json",
    });
  }

  public static UpdateStatus(
    requestBody: ProjectUpdateStatusRequest
  ): CancelablePromise<Response> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/project/update/status",
      body: requestBody,
      mediaType: "application/json",
    });
  }
}
