<template>
  <a-card title="用户列表" style="max-width: 1200px; margin: 50px auto">
    <!-- 搜索框区域 -->
    <a-form layout="inline" style="margin-bottom: 20px">
      <a-form-item label="用户名">
        <a-input
          v-model:value="pageRequest.username"
          placeholder="请输入用户名"
          style="width: 200px"
        />
      </a-form-item>

      <a-form-item label="部门">
        <a-input
          v-model:value="pageRequest.department"
          placeholder="请输入部门"
          style="width: 200px"
        />
      </a-form-item>

      <a-form-item label="组织">
        <a-input
          v-model:value="pageRequest.organization"
          placeholder="请输入组织"
          style="width: 200px"
        />
      </a-form-item>

      <a-form-item label="工作">
        <a-input
          v-model:value="pageRequest.job"
          placeholder="请输入工作"
          style="width: 200px"
        />
      </a-form-item>

      <a-form-item style="margin-top: 10px">
        <a-button type="primary" @click="handleUsers" style="margin-left: 10px">
          搜索
        </a-button>
      </a-form-item>
    </a-form>

    <a-table
      :data-source="users"
      :pagination="false"
      row-key="id"
      bordered
      size="middle"
      :loading="loading"
    >
      <a-table-column title="用户名" data-index="username" key="username" />
      <a-table-column title="账号" data-index="account" key="account" />
      <a-table-column title="职位" data-index="position" key="position" />
      <a-table-column title="电话" data-index="phone" key="phone" />
      <a-table-column title="邮箱" data-index="email" key="email" />
      <a-table-column title="部门" data-index="department" key="department" />
      <a-table-column title="工作" data-index="job" key="job" />
      <a-table-column
        title="组织"
        data-index="organization"
        key="organization"
      />
      <a-table-column title="操作" key="action">
        <template #default="{ record }">
          <a-button type="link" @click="handleEdit(record)"> 编辑</a-button>
          <a-button
            v-if="record.role_id !== 1"
            type="link"
            @click="handleDelete(record)"
          >
            删除
          </a-button>
        </template>
      </a-table-column>
    </a-table>

    <div style="text-align: right; margin-top: 20px">
      <a-pagination
        v-model:current="pageRequest.current"
        :total="total"
        :page-size="pageRequest.page_size"
        @change="handlePageChange"
        size="small"
        show-less-items
      />
    </div>

    <!-- Modal for Editing User -->
    <a-modal
      v-model:visible="isModalVisible"
      title="编辑用户"
      @ok="handleUpdate"
      @cancel="handleCancel"
    >
      <a-form :model="editForm" layout="vertical">
        <a-form-item label="用户名">
          <a-input
            v-model:value="editForm.username"
            placeholder="请输入用户名"
          />
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
          <a-input
            v-model:value="editForm.department"
            placeholder="请输入部门"
          />
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
  </a-card>
</template>

<script setup lang="ts">
import { onMounted, reactive, ref } from "vue";
import { UserListRequest, UserResponse, UserUpdateRequest } from "@/api";
import { message } from "ant-design-vue";
import { userStore } from "@/store/user";
import { UserControllerService } from "@/api/services/UserControllerService";

const pageRequest = reactive<UserListRequest>({
  current: 1,
  page_size: 10,
  account: "",
  username: "",
  department: "",
  organization: "",
  job: "",
  role_id: 0,
});

const total = ref(0);
const users = ref<UserResponse[]>([]);
const user = userStore();
const loading = ref(false);

// Modal visibility
const isModalVisible = ref(false);

// Edit form data
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

// 获取用户列表
const handleUsers = async () => {
  loading.value = true;
  const res = await UserControllerService.List(pageRequest);
  if (res.code === 0) {
    users.value = res.data.records;
    total.value = res.data.total;
  } else {
    message.error(res.msg);
  }
  loading.value = false;
};

// 分页
const handlePageChange = (page: number) => {
  pageRequest.current = page;
  handleUsers();
};

// 编辑用户
const handleEdit = (record: UserResponse) => {
  Object.assign(editForm, record);

  isModalVisible.value = true;
};

// 取消编辑
const handleCancel = () => {
  isModalVisible.value = false;
};

// 更新用户
const handleUpdate = async () => {
  const res = await UserControllerService.Update(editForm);
  if (res.code === 0) {
    message.success("更新成功");
    await handleUsers();
    isModalVisible.value = false;
  } else {
    message.error(res.msg);
  }
};

// 删除用户
const handleDelete = async (record: UserResponse) => {
  const res = await UserControllerService.Delete({ id: record.id });
  if (res.code === 0) {
    message.success("删除成功");
    setTimeout(() => {
      location.reload();
    }, 500);
  } else {
    message.error(res.msg);
  }
};

onMounted(() => {
  handleUsers();
});
</script>

<style scoped>
.a-form-item {
  margin-bottom: 20px;
}

.a-button[type="primary"] {
  background-color: #3f6ad8;
  border-color: #3f6ad8;
  border-radius: 4px;
}

.a-button[type="primary"]:hover {
  background-color: #2f4bbf;
  border-color: #2f4bbf;
}

.ant-table-thead > tr > th {
  background-color: #f0f2f5;
  color: #333;
  font-weight: 500;
}

.ant-table-tbody > tr > td {
  background-color: #fff;
  color: #555;
}

.ant-table-tbody > tr:hover {
  background-color: #fafafa;
}

.ant-table-tbody > tr > td,
.ant-table-thead > tr > th {
  border: 1px solid #e8e8e8;
  padding: 12px 16px;
  text-align: center;
}

.ant-table-pagination {
  display: flex;
  justify-content: flex-end;
  margin-top: 20px;
}
</style>
