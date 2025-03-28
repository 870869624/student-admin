import {
  CancelablePromise,
  OpenAPI,
  RoleAddRequest,
  RolePageResponse,
  RoleUpdateRequest,
  Response,
} from "@/api";
import { request as __request } from "@/api/core/request";
import { DeleteRequest } from "@/api/models/DeleteRequest";
import { PageRequest } from "@/api/models/PageRequest";
import { RolePermission } from "@/api/models/role/RolePermission";

export class RoleControllerService {
  public static Add(requestBody: RoleAddRequest): CancelablePromise<Response> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/role/add",
      body: requestBody,
      mediaType: "application/json",
    });
  }

  public static Update(
    requestBody: RoleUpdateRequest
  ): CancelablePromise<Response> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/role/update",
      body: requestBody,
      mediaType: "application/json",
    });
  }

  public static Delete(
    requestBody: DeleteRequest
  ): CancelablePromise<Response> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/role/delete",
      body: requestBody,
      mediaType: "application/json",
    });
  }

  public static List(
    requestBody: PageRequest
  ): CancelablePromise<RolePageResponse> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/role/list",
      body: requestBody,
      mediaType: "application/json",
    });
  }

  public static Permission(
    requestBody: RolePermission
  ): CancelablePromise<RolePageResponse> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/role/permission",
      body: requestBody,
      mediaType: "application/json",
    });
  }
}
