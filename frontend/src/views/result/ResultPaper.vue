<template>
  <a-card title="论文列表" style="max-width: 1200px; margin: 50px auto">
    <!-- 搜索框区域 -->
    <a-form layout="inline" style="margin-bottom: 20px">
      <a-form-item label="论文名称">
        <a-input
          v-model:value="pageRequest.name"
          placeholder="请输入论文名称"
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

      <a-form-item label="论文描述">
        <a-input
          v-model:value="pageRequest.description"
          placeholder="请输入论文描述"
          style="width: 200px"
        />
      </a-form-item>

      <a-form-item label="论文批次">
        <a-input
          v-model:value="pageRequest.batch"
          placeholder="请输入论文批次"
          style="width: 200px"
        />
      </a-form-item>

      <a-form-item style="margin-top: 10px" label="论文来源">
        <a-input
          v-model:value="pageRequest.source"
          placeholder="请输入论文来源"
          style="width: 200px"
        />
      </a-form-item>

      <a-form-item label="论文状态" style="margin-top: 10px">
        <a-select
          v-model:value="pageRequest.status"
          placeholder="请选择状态"
          style="width: 200px"
        >
          <a-select-option value="declared">已申报</a-select-option>
          <a-select-option value="initiated">已立项</a-select-option>
          <a-select-option value="progress">进行中</a-select-option>
          <a-select-option value="completed">已完成</a-select-option>
          <a-select-option value="extended">已延期</a-select-option>
          <a-select-option value="terminated">已终止</a-select-option>
        </a-select>
      </a-form-item>

      <a-form-item style="margin-top: 10px">
        <a-button
          type="primary"
          @click="handleProjects"
          style="margin-left: 10px"
        >
          搜索
        </a-button>
      </a-form-item>
    </a-form>

    <a-table
      :data-source="projects"
      :pagination="false"
      row-key="id"
      bordered
      size="middle"
      :loading="loading"
    >
      <a-table-column title="论文名称" data-index="name" key="name" />
      <a-table-column title="描述" data-index="description" key="description" />
      <a-table-column title="开始日期" data-index="start_date" key="start_date">
        <template #default="{ text }">{{ formatDate(text) }}</template>
      </a-table-column>

      <a-table-column
        title="预计结束日期"
        data-index="expected_end_date"
        key="expected_end_date"
      >
        <template #default="{ text }">{{ formatDate(text) }}</template>
      </a-table-column>
      <a-table-column title="状态" data-index="status" key="status">
        <template #default="{ text }">
          <a-tag :color="getStatusColor(text)">{{ getStatusText(text) }}</a-tag>
        </template>
      </a-table-column>
      <a-table-column title="部门" data-index="department" key="department" />
      <a-table-column title="批次" data-index="batch" key="batch" />
      <a-table-column title="来源" data-index="source" key="source" />
      <a-table-column title="操作" key="action">
        <template #default="{ record }">
          <a-button type="link" @click="handleDownload(record)">
            下载文件
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
</template>

<script setup lang="ts">
import { onMounted, reactive, ref } from "vue";
import {
  ProjectControllerService,
  ProjectListRequest,
  ProjectResponse,
} from "@/api";
import { message } from "ant-design-vue";
import { userStore } from "@/store/user";

const pageRequest = reactive<ProjectListRequest>({
  current: 1,
  page_size: 5,
  name: "",
  description: "",
  department: "",
  batch: "",
  source: "",
  result_type: "paper",
  status: "",
  user_id: 0,
});
const total = ref(0);

const projects = ref<ProjectResponse[]>([]);

const user = userStore();

const formatDate = (timestamp: number) => {
  const date = new Date(timestamp * 1000);
  const year = date.getFullYear();
  const month = (date.getMonth() + 1).toString().padStart(2, "0");
  const day = date.getDate().toString().padStart(2, "0");
  return `${year}-${month}-${day}`;
};

const getStatusText = (status: string) => {
  switch (status) {
    case "declared":
      return "已申报";
    case "initiated":
      return "已立项";
    case "progress":
      return "进行中";
    case "completed":
      return "已完成";
    case "extended":
      return "已延期";
    case "terminated":
      return "已终止";
    case "down":
      return "驳回";
    default:
      return "未知状态";
  }
};

const getStatusColor = (status: string) => {
  switch (status) {
    case "declared":
      return "blue";
    case "initiated":
      return "green";
    case "progress":
      return "orange";
    case "completed":
      return "red";
    case "extended":
      return "purple";
    case "terminated":
      return "gray";
    case "down":
      return "magenta";
    default:
      return "default";
  }
};

// 加载状态
const loading = ref(false);

const handleProjects = async () => {
  pageRequest.user_id = user.id;
  const res = await ProjectControllerService.List(pageRequest);
  if (res.code === 0) {
    projects.value = res.data.records;
    total.value = res.data.total;
  } else {
    message.error(res.msg);
  }
};

onMounted(() => {
  handleProjects();
});

const handlePageChange = (page: number) => {
  pageRequest.current = page;
  handleProjects();
};

// 下载文件
const handleDownload = (record: ProjectResponse) => {
  window.location.href = record.file_path;
  message.success("下载成功");
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
