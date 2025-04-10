import {
  CancelablePromise,
  OpenAPI,
  Response
} from "@/api";
import { request as __request } from "@/api/core/request";
import type { PreProjectAddRequest} from '@/api/models/pre_project/PreProjectAddRequest';
import type { PreProjectUpdateRequest} from '@/api/models/pre_project/PreProjectUpdateRequest';
import { PageRequest } from "@/api/models/PageRequest";
import { DeleteRequest } from "@/api/models/DeleteRequest";


export class PreProjectControllerService {
  /**
   * 获取预设项目列表
   */
  public static myPreProjectList(requestBody: PageRequest): CancelablePromise<Response> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/preProject/mylist",
      body: requestBody,
      mediaType: "application/json",
    });
  }

  /**
   * 添加预设项目
   */
  public static preProjectAdd(requestBody: PreProjectAddRequest): CancelablePromise<Response> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/pre-project/add",
      body: requestBody,
      mediaType: "application/json",
    });
  }

  /**
   * 更新预设项目
   */
  public static preProjectUpdate(requestBody: PreProjectUpdateRequest): CancelablePromise<Response> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/pre-project/update",
      body: requestBody,
      mediaType: "application/json",
    });
  }

  /**
   * 删除预设项目
   */
  public static preProjectDelete(requestBody: DeleteRequest): CancelablePromise<Response> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/pre-project/delete",
      body: requestBody,
      mediaType: "application/json",
    });
  }
}