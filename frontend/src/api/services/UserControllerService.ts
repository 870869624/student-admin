import {
  CancelablePromise,
  OpenAPI,
  UserRegisterRequest,
  Response,
  UserLoginRequest,
  UserUpdateRequest,
  UserPageResponse,
  ResponseData,
  UserListRequest,
} from "@/api";

import { request as __request } from "../core/request";
import { DeleteRequest } from "@/api/models/DeleteRequest";

export class UserControllerService {
  public static Register(
    requestBody: UserRegisterRequest
  ): CancelablePromise<Response> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/user/register",
      body: requestBody,
      mediaType: "application/json",
    });
  }

  public static Login(
    requestBody: UserLoginRequest
  ): CancelablePromise<Response> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/user/login",
      body: requestBody,
      mediaType: "application/json",
    });
  }

  public static Update(
    requestBody: UserUpdateRequest
  ): CancelablePromise<Response> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/user/update",
      body: requestBody,
      mediaType: "application/json",
    });
  }

  public static List(
    requestBody: UserListRequest
  ): CancelablePromise<UserPageResponse> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/user/list",
      body: requestBody,
      mediaType: "application/json",
    });
  }

  public static Delete(
    requestBody: DeleteRequest
  ): CancelablePromise<Response> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/user/delete",
      body: requestBody,
      mediaType: "application/json",
    });
  }

  public static Get(): CancelablePromise<ResponseData> {
    return __request(OpenAPI, {
      method: "GET",
      url: "/user/get",
    });
  }
}
