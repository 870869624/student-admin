import { NavigationGuardNext, RouteLocationNormalized } from "vue-router";
import { userStore } from "@/store/user";

export const routerBeforeEach = async (
  to: RouteLocationNormalized,
  from: RouteLocationNormalized,
  next: NavigationGuardNext
) => {
  const loginUser = userStore();

  /**
   * 如果是未登录就获取登录态
   */
  if (loginUser.role_id === 0) {
    await loginUser.getLoginUser();
  }

  // 如果目标路由需要权限校验
  if (to.meta.requiresAuth) {
    // 使用类型断言，告诉 TypeScript `permissions` 是 `number[]` 类型
    const requiredPermissions = to.meta.permissions as number[];
    const userPermissions = loginUser.permission_ids as number[];

    // 检查登录用户的权限是否包含目标路由的 permissions 中的任意一个权限
    const hasPermission = requiredPermissions.some((permission: number) =>
      userPermissions.includes(permission)
    );

    if (hasPermission) {
      // 如果有权限，允许访问
      next();
    } else {
      // 如果没有权限，跳转到登录页
      next({ path: "/login" });
    }
  } else {
    // 如果不需要认证，直接访问
    next();
  }
};
