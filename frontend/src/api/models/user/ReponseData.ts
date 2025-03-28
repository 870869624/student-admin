import { UserResponse } from "@/api";

export type ResponseData = {
  code: number;
  data: UserResponse;
  msg: string;
};
