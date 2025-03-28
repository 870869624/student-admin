<template>
  <a-card title="角色列表" style="max-width: 1200px; margin: 50px auto">
    <div style="text-align: right; margin-bottom: 20px">
      <a-button type="primary" @click="showAddRoleModal">添加角色</a-button>
    </div>

    <a-table
      :data-source="roles"
      :pagination="false"
      row-key="id"
      bordered
      size="middle"
      :loading="loading"
    >
      <a-table-column title="id" data-index="id" key="id" />
      <a-table-column title="角色名称" data-index="name" key="name" />
      <a-table-column title="权限" key="permissions">
        <template #default="{ record }">
          <span v-for="(permission, index) in record.permissions" :key="index">
            <a-tag>{{ permission.name }}</a-tag>
          </span>
        </template>
      </a-table-column>
      <a-table-column title="操作" key="action">
        <template #default="{ record }">
          <a-button type="link" @click="handleEdit(record)" v-if="record.id > 3"
            >编辑权限
          </a-button>
          <a-button
            type="link"
            @click="handleDelete(record)"
            v-if="record.id > 3"
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
  </a-card>

  <a-modal
    v-model:visible="isPermissionModalVisible"
    title="编辑权限"
    @ok="handleAddRolePermission"
  >
    <a-radio-group v-model:value="selectedPermission">
      <a-radio v-for="(perm, index) in permissions" :value="perm.id">
        {{ perm.name }}
      </a-radio>
    </a-radio-group>
  </a-modal>

  <a-modal
    v-model:visible="isAddRoleModalVisible"
    title="添加角色"
    @ok="handleAddRole"
  >
    <a-input v-model:value="roleAdd.name" placeholder="请输入角色名称" />
  </a-modal>
</template>

<script setup lang="ts">
import { onMounted, reactive, ref } from "vue";
import {
  PermissionControllerService,
  PermissionResponse,
  RoleAddRequest,
  RoleControllerService,
  RoleResponse,
  UserResponse,
} from "@/api";
import { message } from "ant-design-vue";
import { PageRequest } from "@/api/models/PageRequest";

const pageRequest = reactive<PageRequest>({
  current: 1,
  page_size: 20,
});

const total = ref(0);
const roles = ref<RoleResponse[]>([]);
const loading = ref(false);
const roleAdd = reactive<RoleAddRequest>({
  name: "",
});

// 获取角色列表
const handleRoles = async () => {
  const res = await RoleControllerService.List({
    current: 1,
    page_size: 100,
  });
  if (res.code === 0) {
    roles.value = res.data.records;
  } else {
    message.error(res.msg);
  }
};

// 分页处理
const handlePageChange = (page: number) => {
  pageRequest.current = page;
  handleRoles();
};

const handleDelete = async (record: UserResponse) => {
  const res = await RoleControllerService.Delete({ id: record.id });
  if (res.code === 0) {
    message.success("删除成功");
    await handleRoles();
  } else {
    message.error(res.msg);
  }
};

onMounted(() => {
  handleRoles();
  handlePermissions();
});

const isAddRoleModalVisible = ref(false);
const showAddRoleModal = () => {
  isAddRoleModalVisible.value = true;
};

const handleAddRole = async () => {
  const res = await RoleControllerService.Add(roleAdd);
  if (res.code === 0) {
    message.success("角色添加成功");
    isAddRoleModalVisible.value = false;
    await handleRoles();
  } else {
    message.error(res.msg);
  }
};

const isPermissionModalVisible = ref(false);
const permissions = ref<PermissionResponse[]>([]);
const selectedPermission = ref<number>(1);
const roleId = ref(0);

const handlePermissions = async () => {
  const res = await PermissionControllerService.List({
    current: 1,
    page_size: 100,
  });
  if (res.code === 0) {
    permissions.value = res.data.records;
  } else {
    message.error(res.msg);
  }
};

const handleAddRolePermission = async () => {
  console.log(selectedPermission.value);
  const res = await RoleControllerService.Permission({
    role_id: roleId.value,
    permission_id: selectedPermission.value,
  });
  if (res.code === 0) {
    message.success("权限添加成功");
    isPermissionModalVisible.value = false;
    await handleRoles();
  } else {
    message.error(res.msg);
  }
};

const handleEdit = (record: RoleResponse) => {
  isPermissionModalVisible.value = true;
  roleId.value = record.id;
};
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
