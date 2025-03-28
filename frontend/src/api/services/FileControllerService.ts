import type { Response, CancelablePromise } from "@/api";
import { OpenAPI } from "@/api";
import { request as __request } from "../core/request";

export class FileControllerService {
  public static Upload(requestBody?: {
    file: Blob;
  }): CancelablePromise<Response> {
    return __request(OpenAPI, {
      method: "POST",
      url: "/files/upload",
      formData: {
        file: requestBody?.file,
      },
    });
  }
}
