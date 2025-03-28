<template>
  <a-card
    :bordered="false"
    title="添加项目"
    style="max-width: 800px; margin: 30px auto"
  >
    <a-form @submit="handleSubmit" layout="vertical" style="padding: 20px 40px">
      <a-form-item label="项目名称" name="name">
        <a-input v-model:value="form.name" placeholder="请输入项目名称" />
      </a-form-item>

      <!-- 项目描述 -->
      <a-form-item label="项目描述" name="description">
        <a-textarea
          v-model:value="form.description"
          placeholder="请输入项目描述"
          rows="4"
        />
      </a-form-item>

      <!-- 开始日期 -->
      <a-form-item label="开始日期" name="start_date">
        <a-date-picker
          v-model:value="formDate.start_date"
          style="width: 100%"
        />
      </a-form-item>

      <!-- 预计结束日期 -->
      <a-form-item label="预计结束日期" name="expected_endDate">
        <a-date-picker
          v-model:value="formDate.expected_end_date"
          style="width: 100%"
        />
      </a-form-item>

      <!-- 部门 -->
      <a-form-item label="部门" name="department">
        <a-input v-model:value="form.department" placeholder="请输入部门" />
      </a-form-item>

      <a-form-item label="导师" name="teacher_id">
        <a-select
          v-model:value="form.teacher_id"
          placeholder="请选择导师"
          style="width: 100%"
        >
          <a-select-option
            v-for="teacher in teachers"
            :key="teacher.id"
            :value="teacher.id"
          >
            {{ teacher.account }}
          </a-select-option>
        </a-select>
      </a-form-item>

      <!-- 批次 -->
      <a-form-item label="批次" name="batch">
        <a-input v-model:value="form.batch" placeholder="请输入批次" />
      </a-form-item>

      <!-- 来源 -->
      <a-form-item label="来源" name="source">
        <a-input v-model:value="form.source" placeholder="请输入来源" />
      </a-form-item>

      <!-- 参与者 -->
      <a-form-item label="参与者" name="participant">
        <a-select
          mode="multiple"
          v-model:value="form.participant"
          placeholder="请选择参与者"
          style="width: 100%"
        >
          <a-select-option
            v-for="user in users"
            :key="user.id"
            :value="user.id"
          >
            {{ user.account }}
          </a-select-option>
        </a-select>
      </a-form-item>

      <!-- 结果类型 -->
      <a-form-item label="结果类型" name="result_type">
        <a-select
          v-model:value="form.result_type"
          placeholder="请选择项目类型"
          style="width: 100%"
        >
          <a-select-option value="paper">论文</a-select-option>
          <a-select-option value="software">论著</a-select-option>
          <a-select-option value="project">项目</a-select-option>
          <a-select-option value="patent">专利</a-select-option>
        </a-select>
      </a-form-item>

      <a-form-item label="上传文件" name="file_path">
        <a-upload
          v-model:value="form.file_path"
          :custom-request="handleCustomUpload"
          :show-upload-list="true"
        >
          <a-button icon="">
            <UploadOutlined />
            文件上传
          </a-button>
        </a-upload>
      </a-form-item>

      <a-form-item>
        <a-button
          type="primary"
          html-type="submit"
          block
          size="large"
          style="background-color: #3f6ad8; border-color: #3f6ad8"
        >
          添加项目
        </a-button>
      </a-form-item>
    </a-form>
  </a-card>
</template>

<script setup lang="ts">
import { onMounted, reactive, ref } from "vue";
import { message } from "ant-design-vue";
import {
  FileControllerService,
  ProjectAddRequest,
  ProjectControllerService,
  UserResponse,
} from "@/api";
import { UserControllerService } from "@/api/services/UserControllerService";
import { userStore } from "@/store/user";
import { UploadRequestOption } from "ant-design-vue/es/vc-upload/interface";
import { UploadOutlined } from '@ant-design/icons-vue';

const form = reactive<ProjectAddRequest>({
  name: "",
  description: "",
  start_date: 0,
  expected_end_date: 0,
  user_id: 0,
  department: "",
  teacher_id: 0,
  batch: "",
  source: "",
  participant: [],
  result_type: "",
  file_path: "",
});

const formDate = reactive({
  start_date: "",
  expected_end_date: "",
});

const user = userStore();

const handleSubmit = async () => {
  const startDate = new Date(formDate.start_date);
  startDate.setHours(0, 0, 0, 0);
  form.start_date = Math.floor(startDate.getTime() / 1000);

  const expectedEndDate = new Date(formDate.expected_end_date);
  expectedEndDate.setHours(0, 0, 0, 0);
  form.expected_end_date = Math.floor(expectedEndDate.getTime() / 1000);

  form.user_id = user.id;
  const res = await ProjectControllerService.Add(form);
  if (res.code === 0) {
    message.success("添加成功");
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
    page_size: 100,
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
    page_size: 100,
    account: "",
    username: "",
    department: "",
    organization: "",
    job: "",
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

const handleCustomUpload = async (options: UploadRequestOption) => {
  const formData = new FormData();
  formData.append("file", options.file as File);

  try {
    // 调用API上传文件
    const res = await FileControllerService.Upload({
      file: options.file as Blob,
    });

    // 检查响应状态码
    if (res.code !== 0) {
      message.error(res.msg || '文件上传失败');
      options.onError?.(new Error(res.msg || '文件上传失败')); // 调用onError方法
      return;
    }

    // 更新表单的file_path字段
    form.file_path = res.data;
    message.info('文件上传成功');

    // 调用onSuccess方法
    options.onSuccess?.(res);
  } catch (error) {
    console.error('文件上传异常:', error);
    message.error('文件上传异常，请稍后再试');
  }
};
</script>

<style scoped>
/* 提升卡片的设计感 */
a-card {
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
  border-radius: 12px;
}

/* 表单间距和内边距调整 */
a-form-item {
  margin-bottom: 20px;
}

/* 提交按钮样式 */
a-button[type="primary"] {
  background-color: #3f6ad8;
  border-color: #3f6ad8;
  transition: all 0.3s ease;
}

a-button[type="primary"]:hover {
  background-color: #2f4bbf;
  border-color: #2f4bbf;
}

/* 输入框和选择框样式 */
a-input,
a-select,
a-textarea {
  border-radius: 8px;
}

/* 上传按钮 */
a-button[icon="upload-outlined"] {
  background-color: #f0f5ff;
  border-color: #d9e2f4;
  transition: background-color 0.3s ease;
}

a-button[icon="upload-outlined"]:hover {
  background-color: #e6f4ff;
}
</style>
