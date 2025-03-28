import { Permission } from "@/api/models/permission/Permission";

export type RoleResponse = {
  id: number;
  name: string;
  permissions: Array<Permission>;
};
