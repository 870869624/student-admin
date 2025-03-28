<template>
  <a-card title="角色列表" style="max-width: 1200px; margin: 50px auto">
    <a-table
      :data-source="permissions"
      :pagination="false"
      row-key="id"
      bordered
      size="middle"
    >
      <a-table-column title="id" data-index="id" key="id" />
      <a-table-column title="权限名称" data-index="name" key="name" />
      <a-table-column title="角色" key="roles">
        <template #default="{ record }">
          <span v-for="(role, index) in record.roles" :key="index">
            <a-tag>{{ role.name }}</a-tag>
          </span>
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
</template>

<script setup lang="ts">
import { onMounted, reactive, ref } from "vue";
import {
  Permission,
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
  page_size: 3,
});

const total = ref(0);
const permissions = ref<PermissionResponse[]>([]);

const handlePermissions = async () => {
  const res = await PermissionControllerService.List({
    current: 1,
    page_size: 3,
  });
  if (res.code === 0) {
    permissions.value = res.data.records;
  } else {
    message.error(res.msg);
  }
};

// 分页处理
const handlePageChange = (page: number) => {
  pageRequest.current = page;
  handlePermissions();
};

onMounted(() => {
  handlePermissions();
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
