import { defineStore } from "pinia";
import { UserResponse } from "@/api";
import { UserControllerService } from "@/api/services/UserControllerService";

export const userStore = defineStore("user", {
  state: (): UserResponse => ({
    id: 0,
    account: "",
    password: "",
    position: "",
    phone: "",
    email: "",
    department: "",
    username: "",
    role_id: 0,
    gender: "",
    organization: "",
    job: "",
    permission_ids: [],
  }),
  getters: {},
  actions: {
    async getLoginUser() {
      const res = await UserControllerService.Get();
      if (res.code === 0 && res.data != undefined) {
        /**
         * 从 API 响应中获取的数据
         */
        const userData: Partial<UserResponse> = res.data;

        /**
         * 使用对象解构赋值更新状态对象的属性
         */
        Object.assign(this, userData);
      }
    },
  },
});
