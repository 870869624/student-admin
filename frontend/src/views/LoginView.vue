<template>
  <div class="login-register-page">
    <img src="../assets/login.jpg" alt="Background Image" class="background-image" />
    <div class="form-container">
      <a-tabs v-model:activeKey="activeTab" centered>
        <a-tab-pane key="login" tab="登录">
          <a-form @submit="handleLoginSubmit" layout="vertical">
            <a-form-item label="账号">
              <a-input v-model:value="loginForm.account" placeholder="请输入你的账号" />
            </a-form-item>
            <a-form-item label="密码">
              <a-input-password v-model:value="loginForm.password" placeholder="请输入你的密码" />
            </a-form-item>
            <a-form-item>
              <a-button type="primary" html-type="submit" block class="btn">登录</a-button>
            </a-form-item>
          </a-form>
        </a-tab-pane>
        <a-tab-pane key="register" tab="注册">
          <a-form @submit="handleRegisterSubmit" layout="vertical">
            <a-row gutter="{16}">
              <a-col :span="12">
                <a-form-item label="账号">
                  <a-input v-model:value="registerForm.account" placeholder="请输入账号" />
                </a-form-item>
              </a-col>
              <a-col :span="12">
                <a-form-item label="密码">
                  <a-input-password v-model:value="registerForm.password" placeholder="请输入密码" />
                </a-form-item>
              </a-col>
            </a-row>

            <a-row gutter="{16}">
              <a-col :span="12">
                <a-form-item label="邮箱">
                  <a-input v-model:value="registerForm.email" placeholder="请输入邮箱" />
                </a-form-item>
              </a-col>
              <a-col :span="12">
                <a-form-item label="电话">
                  <a-input v-model:value="registerForm.phone" placeholder="请输入电话" />
                </a-form-item>
              </a-col>
            </a-row>

            <a-row gutter="{16}">
              <a-col :span="12">
                <a-form-item label="姓名">
                  <a-input v-model:value="registerForm.username" placeholder="请输入用户名" />
                </a-form-item>
              </a-col>
              <a-col :span="12">
                <a-form-item label="性别">
                  <a-input v-model:value="registerForm.gender" placeholder="请输入性别" />
                </a-form-item>
              </a-col>
            </a-row>

            <a-row gutter="{16}">
              <a-col :span="12">
                <a-form-item label="部门">
                  <a-input v-model:value="registerForm.department" placeholder="请输入部门" />
                </a-form-item>
              </a-col>
              <a-col :span="12">
                <a-form-item label="职位">
                  <a-input v-model:value="registerForm.position" placeholder="请输入职位" />
                </a-form-item>
              </a-col>
            </a-row>

            <a-row gutter="{16}">
              <a-col :span="12">
                <a-form-item label="组织">
                  <a-input v-model:value="registerForm.organization" placeholder="请输入组织" />
                </a-form-item>
              </a-col>
              <a-col :span="12">
                <a-form-item label="工作">
                  <a-input v-model:value="registerForm.job" placeholder="请输入工作" />
                </a-form-item>
              </a-col>
            </a-row>

            <a-form-item label="角色">
              <a-select v-model:value="registerForm.role_id" placeholder="请选择角色">
                <a-select-option v-for="role in filteredRoles" :key="role.id" :value="role.id">
                  {{ role.name }}
                </a-select-option>
              </a-select>
            </a-form-item>

            <a-form-item>
              <a-button type="primary" html-type="submit" @click="handleRegisterSubmit" block class="btn">
                注册
              </a-button>
            </a-form-item>
          </a-form>
        </a-tab-pane>
      </a-tabs>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, computed } from "vue";
import { UserLoginRequest } from "@/api/models/user/UserLoginRequest";
import { Role, RoleControllerService, UserRegisterRequest } from "@/api";
import { UserControllerService } from "@/api/services/UserControllerService";
import { message } from "ant-design-vue";
import { PageRequest } from "@/api/models/PageRequest";
import router from "@/router";

const activeTab = ref("login");

const loginForm = reactive<UserLoginRequest>({
  account: "",
  password: "",
});

const registerForm = reactive<UserRegisterRequest>({
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
});

const handleLoginSubmit = async () => {
  const res = await UserControllerService.Login(loginForm);
  if (res.code === 0) {
    const token = document.cookie
      .split("; ")
      .find((row) => row.startsWith("a-token="))
      ?.split("=")[1];

    if (token) {
      localStorage.setItem("token", token);
    }

    message.success("登录成功");

    await router.push({
      path: "/",
      replace: true,
    });
    setTimeout(() => {
      location.reload();
    }, 500);
  } else {
    message.error(res.msg);
  }
};

const handleRegisterSubmit = async () => {
  const res = await UserControllerService.Register(registerForm);
  if (res.code === 0) {
    message.success("注册成功");
  } else {
    message.error(res.msg);
  }
};

const roles = ref<Role[]>([]);

const filteredRoles = computed(() => {
  return roles.value.filter((role) => role.id !== 1);
});

const handleRoles = async () => {
  const req = reactive<PageRequest>({
    current: 1,
    page_size: 10,
  });
  const res = await RoleControllerService.List(req);
  if (res.code === 0) {
    roles.value = res.data.records;
  } else {
    message.error(res.msg);
  }
};

onMounted(() => {
  handleRoles();
});
</script>

<style scoped>
.login-register-page {
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  /* 使子元素上下居中 */
  width: 100%;
  height: 100vh;
  overflow: hidden;
}

.background-image {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  z-index: -1;
}

.form-container {
  position: relative;
  min-width: 400px;
  margin-left: 30%;
  background-color: rgba(255, 255, 255, 0.7);
  padding: 24px;
  border-radius: 8px;
  box-shadow: 0 4px 20px rgba(0, 0, 50, 0.8);
  z-index: 1;
}

.form-container .btn {
  background: linear-gradient(45deg, #000050, #000120);
  border: none;
  color: white;
  font-weight: bold;
  text-shadow: 0 0 8px rgba(0, 255, 255, 0.8);
}

:deep(.ant-tabs-tab) {
  color: #000120 !important;
  /* 文字颜色 */
  font-size: 18px !important;
  /* 字体大小 */
}

:deep(.ant-tabs-ink-bar) {
  background: #000120 !important;
  /* 选中指示条颜色 */
}

.form-container .btn {
  background: linear-gradient(45deg, #000050, #000120);
  border: none;
  color: white;
  font-weight: bold;
  text-shadow: 0 0 8px rgba(0, 255, 255, 0.8);
}

:deep(.ant-tabs-tab) {
  color: #000120 !important;
  /* 文字颜色 */
  font-size: 18px !important;
  /* 字体大小 */
}

:deep(.ant-tabs-ink-bar) {
  background: #000120 !important;
  /* 选中指示条颜色 */
}
</style>
