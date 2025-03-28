import { CancelablePromise, OpenAPI, PermissionPageResponse } from "@/api";
import { request as __request } from "@/api/core/request";
import { PageRequest } from "@/api/models/PageRequest";

export class PermissionControllerService {
  public static List(
    requestBody: PageRequest
  ): CancelablePromise<PermissionPageResponse> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/permission/list",
      body: requestBody,
      mediaType: "application/json",
    });
  }
}
