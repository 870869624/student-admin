import { createRouter, createWebHistory, RouteRecordRaw } from "vue-router";
import BasicLayout from "@/layout/BasicLayout.vue";
import LoginView from "@/views/LoginView.vue";
import ProjectAdd from "@/views/project/ProjectAdd.vue";
import ProjectUser from "@/views/project/ProjectUser.vue";
import ProjectDeclared from "@/views/project/ProjectDeclared.vue";
import ProjectInitiated from "@/views/project/ProjectInitiated.vue";
import ProjectProgress from "@/views/project/ProjectProgress.vue";
import ProjectCompleted from "@/views/project/ProjectCompleted.vue";
import ProjectExtended from "@/views/project/ProjectExtended.vue";
import ProjectTerminated from "@/views/project/ProjectTerminated.vue";
import ResultPaper from "@/views/result/ResultPaper.vue";
import ResultSoftware from "@/views/result/ResultSoftware.vue";
import ResultProject from "@/views/result/ResultProject.vue";
import ResultPatent from "@/views/result/ResultPatent.vue";
import ResultUser from "@/views/user/ResultUser.vue";
import UserAdd from "@/views/user/UserAdd.vue";
import UserList from "@/views/user/UserList.vue";
import RoleList from "@/views/user/RoleList.vue";
import PermissionList from "@/views/user/PermissionList.vue";
import HomeView from "@/views/HomeView.vue";
import ProjectDown from "@/views/project/ProjectDown.vue";
import TestWeb3 from "@/views/user/test-web3.vue";
import AnnouncementList from "@/views/announcement/AnnouncementList.vue";
import EditPassword from "@/views/user/EditPassword.vue";

const routes: Array<RouteRecordRaw> = [
  {
    name: "主页",
    path: "/",
    component: BasicLayout,
    meta: {
      requiresAuth: true,
      permissions: [1, 2, 3],
    },
    children: [
      {
        name: "首页",
        path: "/",
        component: HomeView,
        meta: {
          requiresAuth: true,
          permissions: [1, 2, 3],
        },
      },
      {
        name: "公告管理",
        path: "/announcement/list",
        component: AnnouncementList,
        meta: {
          requiresAuth: true,
          permissions: [1]
        },
      },
      {
        name: "申报项目",
        path: "/project/add",
        component: ProjectAdd,
        meta: {
          requiresAuth: true,
          permissions: [1, 2, 3],
        },
      },
      {
        name: "查看项目进度",
        path: "/project/user",
        component: ProjectUser,
        meta: {
          requiresAuth: true,
          permissions: [1, 2, 3],
        },
      },
      {
        name: "项目申报",
        path: "/project/declared",
        component: ProjectDeclared,
        meta: {
          requiresAuth: true,
          permissions: [1, 2, 3],
        },
      },
      {
        name: "项目立项",
        path: "/project/initiated",
        component: ProjectInitiated,
        meta: {
          requiresAuth: true,
          permissions: [1, 3],
        },
      },
      {
        name: "公告管理",
        path: "/announcement/list",
        component: AnnouncementList,
        meta: {
          requiresAuth: true,
          permissions: [1]
        },
      },
      {
        name: "项目中检",
        path: "/project/progress",
        component: ProjectProgress,
        meta: {
          requiresAuth: true,
          permissions: [1, 3],
        },
      },
      {
        name: "公告管理",
        path: "/announcement/list",
        component: AnnouncementList,
        meta: {
          requiresAuth: true,
          permissions: [1]
        },
      },
      {
        name: "项目结项",
        path: "/project/completed",
        component: ProjectCompleted,
        meta: {
          requiresAuth: true,
          permissions: [1, 3],
        },
      },
      {
        name: "公告管理",
        path: "/announcement/list",
        component: AnnouncementList,
        meta: {
          requiresAuth: true,
          permissions: [1]
        },
      },
      {
        name: "项目延期",
        path: "/project/extended",
        component: ProjectExtended,
        meta: {
          requiresAuth: true,
          permissions: [1, 3],
        },
      },
      {
        name: "公告管理",
        path: "/announcement/list",
        component: AnnouncementList,
        meta: {
          requiresAuth: true,
          permissions: [1]
        },
      },
      {
        name: "项目驳回",
        path: "/project/down",
        component: ProjectDown,
        meta: {
          requiresAuth: true,
          permissions: [1, 3],
        },
      },
      {
        name: "公告管理",
        path: "/announcement/list",
        component: AnnouncementList,
        meta: {
          requiresAuth: true,
          permissions: [1]
        },
      },
      {
        name: "项目终止",
        path: "/project/terminated",
        component: ProjectTerminated,
        meta: {
          requiresAuth: true,
          permissions: [1, 3],
        },
      },
      {
        name: "论文管理",
        path: "/result/paper",
        component: ResultPaper,
        meta: {
          requiresAuth: true,
          permissions: [1,2,3],
        },
      },
      {
        name: "公告管理",
        path: "/announcement/list",
        component: AnnouncementList,
        meta: {
          requiresAuth: true,
          permissions: [1]
        },
      },
      {
        name: "论著管理",
        path: "/result/software",
        component: ResultSoftware,
        meta: {
          requiresAuth: true,
          permissions: [1,2,3],
        },
      },
      {
        name: "公告管理",
        path: "/announcement/list",
        component: AnnouncementList,
        meta: {
          requiresAuth: true,
          permissions: [1]
        },
      },
      {
        name: "项目管理",
        path: "/result/project",
        component: ResultProject,
        meta: {
          requiresAuth: true,
          permissions: [1,2,3],
        },
      },
      {
        name: "公告管理",
        path: "/announcement/list",
        component: AnnouncementList,
        meta: {
          requiresAuth: true,
          permissions: [1]
        },
      },
      {
        name: "专利管理",
        path: "/result/patent",
        component: ResultPatent,
        meta: {
          requiresAuth: true,
          permissions: [1,2,3],
        },
      },
      {
        name: "公告管理",
        path: "/announcement/list",
        component: AnnouncementList,
        meta: {
          requiresAuth: true,
          permissions: [1]
        },
      },
      {
        name: "个人业绩查看",
        path: "/result/user",
        component: ResultUser,
        meta: {
          requiresAuth: true,
          permissions: [1, 2, 3],
        },
      },
      {
        name: "公告管理",
        path: "/announcement/list",
        component: AnnouncementList,
        meta: {
          requiresAuth: true,
          permissions: [1]
        },
      },
      {
        name:"修改密码",
        path:"/password/update",
        component:EditPassword,
      },
      {
        name: "添加用户",
        path: "/user/add",
        component: UserAdd,
        meta: {
          requiresAuth: true,
          permissions: [1],
        },
      },
      {
        name: "公告管理",
        path: "/announcement/list",
        component: AnnouncementList,
        meta: {
          requiresAuth: true,
          permissions: [1]
        },
      },
      {
        name: "用户列表",
        path: "/user/list",
        component: UserList,
        meta: {
          requiresAuth: true,
          permissions: [1],
        },
      },
      {
        name: "公告管理",
        path: "/announcement/list",
        component: AnnouncementList,
        meta: {
          requiresAuth: true,
          permissions: [1]
        },
      },
      {
        name: "角色列表",
        path: "/user/role",
        component: RoleList,
        meta: {
          requiresAuth: true,
          permissions: [1],
        },
      },
      {
        name: "公告管理",
        path: "/announcement/list",
        component: AnnouncementList,
        meta: {
          requiresAuth: true,
          permissions: [1]
        },
      },
      {
        name: "用户列表",
        path: "/user/list",
        component: UserList,
        meta: {
          requiresAuth: true,
          permissions: [1],
        },
      },
      {
        name: "公告管理",
        path: "/announcement/list",
        component: AnnouncementList,
        meta: {
          requiresAuth: true,
          permissions: [1]
        },
      },
      {
        name: "权限列表",
        path: "/user/permission",
        component: PermissionList,
        meta: {
          requiresAuth: true,
          permissions: [1],
        },
      },
    ],
  },
  {
    name: "登录",
    path: "/login",
    component: LoginView,
  },
  {
    name:"测试",
    path:"/test",
    component:TestWeb3,
  }
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

export default router;
