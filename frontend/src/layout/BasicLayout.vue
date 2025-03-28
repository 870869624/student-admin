<template>
  <a-layout style="height: 100vh">
    <a-layout-sider
      v-model:collapsed="collapsed"
      :trigger="null"
      collapsible
      style="height: 100vh; position: fixed; left: 0; top: 0"
    >
      <router-link to="/">
        <div class="logo">
          <img
            src="../assets/logo2.png"
            alt="Background Image"
            class="logo-image"
          />
          <h1>科研管理系统</h1>
        </div>
      </router-link>
      <a-menu v-model:selectedKeys="selectedKeys" theme="dark" mode="inline">
        <a-sub-menu key="1">
          <template #title>
            <span>
              <HolderOutlined />
              项目申报
            </span>
          </template>
          <a-menu-item key="1-1">
            <router-link to="/project/add">
              <SwitcherOutlined />
              <span>申报项目</span>
            </router-link>
          </a-menu-item>
          <a-menu-item key="2-1">
            <router-link to="/project/user">
              <LayoutOutlined />
              <span>查看项目进度</span>
            </router-link>
          </a-menu-item>
        </a-sub-menu>
        <a-sub-menu
          v-if="hashPermission(user.permission_ids, adminPermissionIds)"
          key="2"
        >
          <template #title>
            <span>
              <user-outlined />
              用户管理
            </span>
          </template>
          <a-menu-item key="2-1">
            <router-link to="/user/add">
              <RobotOutlined />
              <span>添加用户</span>
            </router-link>
          </a-menu-item>
          <a-menu-item key="2-2">
            <router-link to="/user/list">
              <RocketOutlined />
              <span>用户列表</span>
            </router-link>
          </a-menu-item>
          <a-menu-item key="2-3">
            <router-link to="/user/role">
              <SafetyCertificateOutlined />
              <span>角色列表</span>
            </router-link>
          </a-menu-item>
          <a-menu-item key="2-4">
            <router-link to="/user/permission">
              <SmileOutlined />
              <span>权限列表</span>
            </router-link>
          </a-menu-item>
        </a-sub-menu>
        <a-sub-menu
          v-if="hashPermission(user.permission_ids, teacherPermissionIds)"
          key="3"
        >
          <template #title>
            <span>
              <BarcodeOutlined />
              项目管理
            </span>
          </template>
          <a-menu-item key="3-1">
            <router-link to="/project/declared">
              <TrophyOutlined />
              <span>项目申报</span>
            </router-link>
          </a-menu-item>
          <a-menu-item key="3-2">
            <router-link to="/project/initiated">
              <ToolOutlined />
              <span>项目立项</span>
            </router-link>
          </a-menu-item>
          <a-menu-item key="3-3">
            <router-link to="/project/progress">
              <TranslationOutlined />
              <span>项目中检</span>
            </router-link>
          </a-menu-item>
          <a-menu-item key="3-4">
            <router-link to="/project/completed">
              <ProfileOutlined />
              <span>项目结项</span>
            </router-link>
          </a-menu-item>
          <a-menu-item key="3-5">
            <router-link to="/project/extended">
              <MonitorOutlined />
              <span>项目延期</span>
            </router-link>
          </a-menu-item>
          <a-menu-item key="3-6">
            <router-link to="/project/terminated">
              <LayoutOutlined />
              <span>项目终止</span>
            </router-link>
          </a-menu-item>
          <a-menu-item key="3-7">
            <router-link to="/project/down">
              <SyncOutlined />
              <span>项目驳回</span>
            </router-link>
          </a-menu-item>
        </a-sub-menu>
        <a-sub-menu key="4">
          <template #title>
            <span>
              <CalendarOutlined />
              成果管理
            </span>
          </template>
          <a-menu-item key="4-1">
            <router-link to="/result/paper">
              <HourglassOutlined />
              <span>论文管理</span>
            </router-link>
          </a-menu-item>
          <a-menu-item key="4-2">
            <router-link to="/result/software">
              <GoldOutlined />
              <span>论著管理</span>
            </router-link>
          </a-menu-item>
          <a-menu-item key="4-3">
            <router-link to="/result/project">
              <HddOutlined />
              <span>项目管理</span>
            </router-link>
          </a-menu-item>
          <a-menu-item key="4-4">
            <router-link to="/result/patent">
              <LaptopOutlined />
              <span>专利管理</span>
            </router-link>
          </a-menu-item>
        </a-sub-menu>
        <a-sub-menu key="5">
          <template #title>
            <span>
              <InsertRowAboveOutlined />
              科研业绩查看
            </span>
          </template>
          <a-menu-item key="5-1">
            <router-link to="/result/user">
              <InsertRowRightOutlined />
              <span>个人业绩查看</span>
            </router-link>
          </a-menu-item>
        </a-sub-menu>
        <a-sub-menu key="6" v-if="hashPermission(user.permission_ids, [1])">
          <template #title>
            <span>
              <NotificationOutlined />
              公告管理
            </span>
          </template>
          <a-menu-item key="6-1">
            <router-link to="/announcement/list">
              <BellOutlined />
              <span>系统公告</span>
            </router-link>
          </a-menu-item>
        </a-sub-menu>
      </a-menu>
    </a-layout-sider>
    <a-layout style="margin-left: 200px; height: 100vh">
      <!-- 头部 -->
      <a-layout-header
        style="
          background: #fff;
          padding: 0;
          display: flex;
          justify-content: space-between;
          align-items: center;
          height: 64px; /* 设置头部固定高度 */
        "
      >
        <div>
          <menu-unfold-outlined
            v-if="collapsed"
            class="trigger"
            @click="() => (collapsed = !collapsed)"
          />
          <menu-fold-outlined
            v-else
            class="trigger"
            @click="() => (collapsed = !collapsed)"
          />
        </div>

        <div style="display: flex; align-items: center">
          <a-popover placement="bottom" trigger="click" v-model:visible="notificationVisible">
            <template #content>
              <div style="width: 300px; max-height: 400px; overflow-y: auto;">
                <div v-if="notifications.length === 0" style="text-align: center; padding: 20px;">
                  暂无待办通知
                </div>
                <a-list v-else>
                  <a-list-item v-for="item in notifications" :key="item.id">
                    <div style="width: 100%">
                      <div style="display: flex; justify-content: space-between; align-items: center">
                        <span style="font-weight: bold">{{ item.title }}</span>
                      </div>
                      <div style="margin: 8px 0">{{ item.content }}</div>
                      <div style="display: flex; justify-content: flex-end; gap: 8px">
                        <a-button size="small" @click="markAsRead(item.id)">已阅</a-button>
                        <a-button size="small" type="primary" @click="remindLater(item.id)">再次提醒</a-button>
                      </div>
                    </div>
                  </a-list-item>
                </a-list>
              </div>
            </template>
            <a-badge :count="notifications.length" :dot="notifications.length > 0">
              <BellOutlined style="font-size: 20px; margin-right: 16px; cursor: pointer" />
            </a-badge>
          </a-popover>
          <span v-if="user.role_id === 1"
            ><a-tag color="blue">管理员</a-tag></span
          >
          <a-button type="link" @click="handleEdit">
            {{ user.account }}
          </a-button>
          <a-button
            type="primary"
            @click="handleLogout"
            style="margin-right: 16px; margin-left: 20px"
            >退出
          </a-button>
        </div>
      </a-layout-header>

      <a-layout-content
        style="
          margin: 0 16px;
          padding: 24px;
          background: #fff;
          overflow-y: auto;
          flex: 1;
          height: calc(100vh - 64px);
        "
      >
        <router-view />
      </a-layout-content>
    </a-layout>
  </a-layout>

  <a-modal v-model:visible="isModalVisible" title="编辑用户" @ok="handleUpdate">
    <a-form :model="editForm" layout="vertical">
      <a-form-item label="用户名">
        <a-input v-model:value="editForm.username" placeholder="请输入用户名" />
      </a-form-item>
      <a-form-item label="账号">
        <a-input v-model:value="editForm.account" placeholder="请输入账号" />
      </a-form-item>
      <a-form-item label="职位">
        <a-input v-model:value="editForm.position" placeholder="请输入职位" />
      </a-form-item>
      <a-form-item label="电话">
        <a-input v-model:value="editForm.phone" placeholder="请输入电话" />
      </a-form-item>
      <a-form-item label="邮箱">
        <a-input v-model:value="editForm.email" placeholder="请输入邮箱" />
      </a-form-item>
      <a-form-item label="部门">
        <a-input v-model:value="editForm.department" placeholder="请输入部门" />
      </a-form-item>
      <a-form-item label="工作">
        <a-input v-model:value="editForm.job" placeholder="请输入工作" />
      </a-form-item>
      <a-form-item label="组织">
        <a-input
          v-model:value="editForm.organization"
          placeholder="请输入组织"
        />
      </a-form-item>
    </a-form>
  </a-modal>
</template>

<script lang="ts" setup>
import { reactive, ref, onMounted } from "vue";
import {
  UserOutlined,
  RobotOutlined,
  HolderOutlined,
  MenuUnfoldOutlined,
  MenuFoldOutlined,
  BarcodeOutlined,
  CalendarOutlined,
  InsertRowAboveOutlined,
  SafetyCertificateOutlined,
  SmileOutlined,
  RocketOutlined,
  TrophyOutlined,
  ToolOutlined,
  TranslationOutlined,
  ProfileOutlined,
  MonitorOutlined,
  LayoutOutlined,
  HourglassOutlined,
  GoldOutlined,
  HddOutlined,
  LaptopOutlined,
  InsertRowRightOutlined,
  SwitcherOutlined,
  SyncOutlined,
  BellOutlined,
} from "@ant-design/icons-vue";
import { message } from "ant-design-vue";
import router from "@/router";
import { userStore } from "@/store/user";
import { UserResponse, UserUpdateRequest } from "@/api";
import { UserControllerService } from "@/api/services/UserControllerService";

const selectedKeys = ref<string[]>(["1"]);
const collapsed = ref<boolean>(false);

const isModalVisible = ref(false);
const notificationVisible = ref(false);
const notifications = ref<any[]>([]);

const fetchNotifications = async () => {
  try {
    const response = await fetch('http://localhost:8100/api/note/list', {
      credentials: 'include',
      headers: {
        'Cookie': document.cookie
      }
    });
    const data = await response.json();
    if (data.code === 0) {
      notifications.value = data.data.records;
    } else {
      message.error(data.msg || '获取待办通知失败');
    }
  } catch (error) {
    console.error('获取待办通知失败:', error);
    message.error('获取待办通知失败');
  }
};

const markAsRead = async (id: number) => {
  try {
    const response = await fetch('http://localhost:8100/api/note/update', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ id })
    });
    const data = await response.json();
    if (data.code === 0) {
      message.success('已标记为已读');
      fetchNotifications();
    } else {
      message.error(data.msg || '操作失败');
    }
  } catch (error) {
    console.error('操作失败:', error);
    message.error('操作失败');
  }
};

const remindLater = async (id: number) => {
  notificationVisible.value = false;
  message.success('将在稍后提醒');
};

onMounted(() => {
  fetchNotifications();
});

const handleEdit = (record: UserResponse) => {
  Object.assign(editForm, user);

  isModalVisible.value = true;
};

const clearAllCookies = () => {
  const cookies = document.cookie.split("; ");
  for (const cookie of cookies) {
    const [name] = cookie.split("=");
    document.cookie = `${name}=;expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/`;
  }
};

const handleUpdate = async () => {
  const res = await UserControllerService.Update(editForm);
  if (res.code === 0) {
    message.success("更新成功");
    isModalVisible.value = false;
    setTimeout(() => {
      location.reload();
    }, 500);
  } else {
    message.error(res.msg);
  }
};

const handleLogout = () => {
  clearAllCookies();
  message.success("已成功退出");
  // 跳转到登录页面或其他操作
  router.push({
    path: "/login",
    replace: true,
  });
};

const editForm = reactive<UserUpdateRequest>({
  id: 0,
  account: "",
  password: "",
  username: "",
  position: "",
  phone: "",
  email: "",
  department: "",
  role_id: 0,
  job: "",
  gender: "",
  organization: "",
});

const user = userStore();

const adminPermissionIds = ref([1]);
const teacherPermissionIds = ref([1, 3]);

const hashPermission = (
  userPermissions: number[],
  requiredPermissions: number[]
) => {
  return requiredPermissions.some((permission) =>
    userPermissions.includes(permission)
  );
};
</script>

<style>
.trigger {
  font-size: 18px;
  line-height: 64px;
  padding: 0 24px;
  cursor: pointer;
  transition: color 0.3s;
}

.trigger:hover {
  color: #1890ff;
}

.logo {
  height: 64px; /* 保持与侧边栏一致 */
  background: #001529; /* 侧边栏的默认背景色 */
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0; /* 去除间隙 */
}

.logo h1 {
  color: #ffffff;
  font-size: 22px; /* 根据需要调整字体大小 */
  font-weight: bold;
  margin: 0;
}
.logo-image {
  width: 50px;
  height: 50px; /* 确保图片为正方形 */
  border-radius: 30%; /* 使图片成为圆形 */
  overflow: hidden; /* 确保图片内容不超出圆形边界 */
}
</style>
