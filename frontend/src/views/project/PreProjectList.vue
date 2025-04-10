<template>
  <a-card title="预设项目列表" style="max-width: 1200px; margin: 5px auto">
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
    </a-table>
  </a-card>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted } from 'vue';
import { message } from 'ant-design-vue';
import axios from 'axios';
import { userStore } from "@/store/user";

// 定义 formatDate 函数并添加类型定义
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

    // 将 formatDate 添加到返回值中
    return {
      projects,
      loading,
      pagination,
      handleTableChange,
      formatDate // 暴露 formatDate 函数
    };
  }
});
</script>