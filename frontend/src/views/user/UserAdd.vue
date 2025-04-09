<template>
  <a-card title="" style="background-color: #f4f4f4;">
    <div class="container">
      <h1 class="page-title">添加用户</h1>
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
            <a-form-item label="职位">
              <a-input v-model:value="registerForm.position" placeholder="请输入职位" />
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
            <a-form-item label="邮箱">
              <a-input v-model:value="registerForm.email" placeholder="请输入邮箱" />
            </a-form-item>
          </a-col>
          <a-col :span="12">
            <a-form-item label="部门">
              <a-input v-model:value="registerForm.department" placeholder="请输入部门" />
            </a-form-item>
          </a-col>
        </a-row>

        <a-row gutter="{16}">
          <a-col :span="12">
            <a-form-item label="用户名">
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
            <a-select-option v-for="role in roles" :key="role.id" :value="role.id">
              {{ role.name }}
            </a-select-option>
          </a-select>
        </a-form-item>

        <a-form-item>
          <a-button type="primary" html-type="submit" block class="btn">确认</a-button>
        </a-form-item>
      </a-form>
    </div>
  </a-card>
</template>

<script setup lang="ts">
import { ref, reactive, computed, onMounted } from "vue";
import { Role, RoleControllerService, UserRegisterRequest } from "@/api";
import { message } from "ant-design-vue";
import { UserControllerService } from "@/api/services/UserControllerService";

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

const roles = ref<Role[]>([]);

const handleRegisterSubmit = async () => {
  const res = await UserControllerService.Register(registerForm);
  if (res.code === 0) {
    message.success("添加用户成功！");
  } else {
    message.error(res.msg);
  }
};

const handleRoles = async () => {
  const res = await RoleControllerService.List({ current: 1, page_size: 10 });
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
.container {
  max-width: 80%;
  margin: auto;
  padding: 20px;
  border: 1px solid #e8e8e8;
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  background: white;
}

.page-title {
  font-size: 20px;
  text-align: center;
  margin-bottom: 20px;
}

.btn {
  background: #000120;
}
</style>
