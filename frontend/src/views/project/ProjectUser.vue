<template>
  <a-card title="项目列表" style="max-width: 1200px; margin: 5px auto">
    <!-- 搜索框区域 -->
    <a-form layout="inline" style="margin-bottom: 20px">
      <a-form-item label="项目名称">
        <a-input v-model:value="pageRequest.name" placeholder="请输入项目名称" style="width: 200px" />
      </a-form-item>

      <a-form-item label="部门">
        <a-input v-model:value="pageRequest.department" placeholder="请输入部门" style="width: 200px" />
      </a-form-item>

      <a-form-item label="项目描述">
        <a-input v-model:value="pageRequest.description" placeholder="请输入项目描述" style="width: 200px" />
      </a-form-item>

      <a-form-item label="项目批次">
        <a-input v-model:value="pageRequest.batch" placeholder="请输入项目批次" style="width: 200px" />
      </a-form-item>

      <a-form-item style="margin-top: 10px" label="项目来源">
        <a-input v-model:value="pageRequest.source" placeholder="请输入项目来源" style="width: 200px" />
      </a-form-item>

      <a-form-item label="项目状态" style="margin-top: 10px">
        <a-select v-model:value="pageRequest.status" placeholder="请选择状态" style="width: 200px">
          <a-select-option value="declared">已申报</a-select-option>
          <a-select-option value="initiated">已立项</a-select-option>
          <a-select-option value="progress">进行中</a-select-option>
          <a-select-option value="completed">已完成</a-select-option>
          <a-select-option value="extended">已延期</a-select-option>
          <a-select-option value="terminated">已终止</a-select-option>
        </a-select>
      </a-form-item>

      <a-form-item style="margin-top: 10px">
        <a-button type="primary" @click="handleProjects" style="margin-left: 10px">
          搜索
        </a-button>
      </a-form-item>
    </a-form>

    <a-table :data-source="projects" :pagination="false" row-key="id" bordered size="middle" :loading="loading">
      <a-table-column title="项目名称" data-index="name" key="name" />
      <a-table-column title="描述" data-index="description" key="description" />
      <a-table-column title="开始日期" data-index="start_date" key="start_date">
        <template #default="{ text }">{{ formatDate(text) }}</template>
      </a-table-column>

      <a-table-column title="预计结束日期" data-index="expected_end_date" key="expected_end_date">
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
          <a-button type="link" @click="handleEdit(record)">修改</a-button>
          <a-button type="link" @click="handleDownload(record)">
            下载文件
          </a-button>
          <a-upload v-model:value="updateForm.file_path" :custom-request="handleCustomUpload" :show-upload-list="false">
            <a-button icon="">文件上传</a-button>
          </a-upload>
          <a-tooltip v-if="record.status === 'down'" :title="record.down_reason">
            <a-button type="link" style="margin-left: 3px">查看驳回原因
            </a-button>
          </a-tooltip>
        </template>
      </a-table-column>
    </a-table>
    <div style="text-align: right; margin-top: 20px">
      <a-pagination v-model:current="pageRequest.current" :total="total" :page-size="pageRequest.page_size"
        @change="handlePageChange" size="small" show-less-items />
    </div>
  </a-card>
  <a-modal v-model:visible="editModalVisible" title="修改项目" @ok="handleSubmit">
    <a-form layout="vertical">
      <!-- 项目名称 -->
      <a-form-item label="项目名称" name="name">
        <a-input v-model:value="updateForm.name" placeholder="请输入项目名称" />
      </a-form-item>

      <!-- 项目描述 -->
      <a-form-item label="项目描述" name="description">
        <a-textarea v-model:value="updateForm.description" placeholder="请输入项目描述" rows="4" />
      </a-form-item>

      <!-- 部门 -->
      <a-form-item label="部门" name="department">
        <a-input v-model:value="updateForm.department" placeholder="请输入部门" />
      </a-form-item>

      <!-- 导师 -->
      <a-form-item label="导师" name="teacher_id">
        <a-select v-model:value="updateForm.teacher_id" placeholder="请选择导师" style="width: 100%">
          <a-select-option v-for="teacher in teachers" :key="teacher.id" :value="teacher.id">
            {{ teacher.account }}
          </a-select-option>
        </a-select>
      </a-form-item>

      <!-- 批次和来源 -->
      <a-row gutter="16">
        <a-col :span="12">
          <a-form-item label="批次" name="batch">
            <a-input v-model:value="updateForm.batch" placeholder="请输入批次" />
          </a-form-item>
        </a-col>
        <a-col :span="12">
          <a-form-item label="来源" name="source">
            <a-input v-model:value="updateForm.source" placeholder="请输入来源" />
          </a-form-item>
        </a-col>
      </a-row>

      <!-- 上传文件 -->
      <a-row gutter="16">
        <a-col :span="12">
          <a-form-item label="上传文件" name="file_path">
            <a-upload v-model:value="updateForm.file_path" :custom-request="handleCustomUpload"
              :show-upload-list="false">
              <a-button icon="">文件上传</a-button>
            </a-upload>
          </a-form-item>
        </a-col>
        <a-col :span="12">
          <a-form-item label="参与者" name="participant">
            <a-select mode="multiple" v-model:value="updateForm.participant" placeholder="请选择参与者" style="width: 100%">
              <a-select-option v-for="user in users" :key="user.id" :value="user.id">
                {{ user.account }}
              </a-select-option>
            </a-select>
          </a-form-item>
        </a-col>
      </a-row>

      <!-- 结果类型 -->
      <a-form-item label="结果类型" name="result_type">
        <a-select v-model:value="updateForm.result_type" placeholder="请选择项目类型" style="width: 100%">
          <a-select-option value="paper">论文</a-select-option>
          <a-select-option value="software">论著</a-select-option>
          <a-select-option value="project">项目</a-select-option>
          <a-select-option value="patent">专利</a-select-option>
        </a-select>
      </a-form-item>
    </a-form>
  </a-modal>
</template>

<script setup lang="ts">
import { onMounted, reactive, ref } from "vue";
import {
  FileControllerService,
  ProjectControllerService,
  ProjectListRequest,
  ProjectResponse,
  ProjectUpdateRequest,
  UserResponse,
} from "@/api";
import { message } from "ant-design-vue";
import { userStore } from "@/store/user";
import { UploadRequestOption } from "ant-design-vue/es/vc-upload/interface";
import { UserControllerService } from "@/api/services/UserControllerService";

const pageRequest = reactive<ProjectListRequest>({
  current: 1,
  page_size: 5,
  name: "",
  description: "",
  department: "",
  batch: "",
  source: "",
  result_type: "",
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

const handleCustomUpload = async (options: UploadRequestOption) => {
  try {
    message.loading({ content: '文件上传中...', key: 'uploading' });
    const formData = new FormData();
    formData.append("file", options.file as File);

    const res = await FileControllerService.Upload({
      file: options.file as Blob,
    });
    if (res.code !== 0) {
      message.error({ content: res.msg, key: 'uploading' });
      if (options.onError) {
        options.onError(new Error(res.msg));
      }
      return;
    }
    updateForm.file_path = res.data;
    message.success({ content: '上传成功', key: 'uploading' });
    if (options.onSuccess) {
      options.onSuccess(res.data);
    }
  } catch (error) {
    message.error({ content: '上传失败', key: 'uploading' });
    if (options.onError) {
      options.onError(error as Error);
    }
  }
};

const editModalVisible = ref(false);

const updateForm = reactive<ProjectUpdateRequest>({
  id: 0,
  name: "",
  description: "",
  start_date: 0,
  expected_end_date: 0,
  department: "",
  teacher_id: 0,
  batch: "",
  source: "",
  participant: [],
  result_type: "",
  file_path: "",
  stage_id: 0,
  stage_status: "",
  status: "",
  userId: 0,
});

const handleEdit = (record: ProjectResponse) => {
  Object.assign(updateForm, record);
  editModalVisible.value = true;
};

const handleSubmit = async () => {
  const res = await ProjectControllerService.Update(updateForm);
  if (res.code === 0) {
    message.success("修改成功");
    setTimeout(() => {
      location.reload();
    }, 500);
  } else {
    message.error(res.msg);
  }
};

const teachers = ref<UserResponse[]>([]);
const users = ref<UserResponse[]>([]);

const handleTeacherIds = async () => {
  const res = await UserControllerService.List({
    current: 1,
    page_size: 10,
    account: "",
    username: "",
    department: "",
    organization: "",
    job: "",
    role_id: 3,
  });
  if (res.code === 0) {
    teachers.value = res.data.records;
  }
};

const handleUserIds = async () => {
  const res = await UserControllerService.List({
    current: 1,
    account: "",
    username: "",
    department: "",
    organization: "",
    job: "",
    page_size: 10,
    role_id: 2,
  });
  if (res.code === 0) {
    users.value = res.data?.records;
  }
};

onMounted(() => {
  handleTeacherIds();
  handleUserIds();
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

.ant-table-thead>tr>th {
  background-color: #f0f2f5;
  color: #333;
  font-weight: 500;
}

.ant-table-tbody>tr>td {
  background-color: #fff;
  color: #555;
}

.ant-table-tbody>tr:hover {
  background-color: #fafafa;
}

.ant-table-tbody>tr>td,
.ant-table-thead>tr>th {
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
