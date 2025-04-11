<template>
  <a-card title="预设项目列表" style="max-width: 1200px; margin: 5px auto">
    <template #extra>
      <a-button type="primary" @click="showModal">新增</a-button>
    </template>
    <a-table
      :data-source="projects"
      :pagination="pagination"
      row-key="id"
      bordered
      size="middle"
      :loading="loading"
      @change="handleTableChange"
    >
      <a-table-column title="项目名称" data-index="name" key="name" />
      <a-table-column title="项目描述" data-index="description" key="description" />
      <a-table-column title="项目开始时间" data-index="start_date" key="start_date">
        <template #default="{ text }">{{ formatDate(text) }}</template>
      </a-table-column>
      <a-table-column title="项目结束时间" data-index="expected_end_date" key="expected_end_date">
        <template #default="{ text }">{{ formatDate(text) }}</template>
      </a-table-column>
      <a-table-column title="项目审核状态" data-index="status" key="status" />
      <!-- <a-table-column title="操作" data-index="operation" key="operation" /> -->
    </a-table>
  </a-card>

  <a-modal
    v-model:visible="visible"
    title="新增预设项目"
    @ok="handleOk"
    @cancel="handleCancel"
  >
    <a-form
      ref="formRef"
      :model="formState"
      :label-col="{ span: 6 }"
      :wrapper-col="{ span: 16 }"
    >
      <a-form-item label="项目名称" name="name">
        <a-input v-model:value="formState.name" />
      </a-form-item>
      <a-form-item label="项目描述" name="description">
        <a-textarea v-model:value="formState.description" />
      </a-form-item>
      <a-form-item label="开始时间" name="start_date">
        <a-date-picker
          v-model:value="formState.start_date"
          style="width: 100%"
        />
      </a-form-item>
      <a-form-item label="结束时间" name="expected_end_date">
        <a-date-picker
          v-model:value="formState.expected_end_date"
          style="width: 100%"
        />
      </a-form-item>
    </a-form>
  </a-modal>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted } from 'vue';
import { message } from 'ant-design-vue';
import axios from 'axios';
import { userStore } from '@/store/user';
import type { FormInstance } from 'ant-design-vue';

// 定义 formatDate 函数并添加类型定义
const visible = ref(false);
const formRef = ref<FormInstance>();
const formState = ref({
  name: '',
  description: '',
  start_date: '',
  expected_end_date: ''
});

const showModal = () => {
  visible.value = true;
};

const handleCancel = () => {
  visible.value = false;
  formState.value = {
    name: '',
    description: '',
    start_date: '',
    expected_end_date: ''
  };
};

const formatDate = (timestamp: number | null | undefined): string => {
  if (!timestamp) return ''; // 处理可能的 null 或 undefined 值
  const date = new Date(timestamp * 1000);
  const year = date.getFullYear();
  const month = (date.getMonth() + 1).toString().padStart(2, "0");
  const day = date.getDate().toString().padStart(2, "0");
  return `${year}-${month}-${day}`;
};

export default defineComponent({
  name: 'PreProjectList',
  setup() {
    const user = userStore();
    const projects = ref([]);
    const loading = ref(false);
    const pagination = ref({
      current: 1,
      pageSize: 10,
      total: 0,
      showSizeChanger: true,
      showTotal: (total: number) => `共 ${total} 条`
    });

    const fetchProjects = async () => {
      loading.value = true;
      try {
        const response = await axios.post('http://localhost:8100/api/preProject/myList', {
          current: pagination.value.current,
          page_size: pagination.value.pageSize,
          user_id: user.id // 使用当前登录用户的ID
        });
        
        if (response.data.code === 0) {
          projects.value = response.data.data.records;
          pagination.value.total = response.data.data.total;
        } else {
          message.error('获取项目列表失败');
        }
      } catch (error) {
        console.error('获取项目列表出错:', error);
        message.error('获取项目列表失败');
      } finally {
        loading.value = false;
      }
    };

    onMounted(() => {
      fetchProjects();
    });
    const handleTableChange = (pag: any) => {
      pagination.value.current = pag.current;
      pagination.value.pageSize = pag.pageSize;
      fetchProjects();
    };


    const handleOk = async () => {
      try {
        const startDate = Math.floor(new Date(formState.value.start_date).getTime() / 1000);
        const endDate = Math.floor(new Date(formState.value.expected_end_date).getTime() / 1000);
        
        const response = await axios.post('http://localhost:8100/api/preProject/add', {
          name: formState.value.name,
          description: formState.value.description,
          start_date: startDate,
          expected_end_date: endDate,
          user_id: user.id
        });

        if (response.data.code === 0) {
          message.success('添加成功');
          visible.value = false;
          fetchProjects();
          formState.value = {
            name: '',
            description: '',
            start_date: '',
            expected_end_date: ''
          };
        } else {
          message.error('添加失败');
        }
      } catch (error) {
        console.error('添加项目出错:', error);
        message.error('添加失败');
      }
    };
    // 将 formatDate 添加到返回值中
    return {
      projects,
      loading,
      pagination,
      handleTableChange,
      formatDate,
      visible,
      formState,
      formRef,
      showModal,
      handleOk,
      handleCancel,
      
    };
  }


}




);
</script>