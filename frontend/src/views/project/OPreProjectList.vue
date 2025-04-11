<template>
  <a-tabs v-model:activeKey="activeKey">
    <a-tab-pane key="all" tab="全部">
      <div class="card-container">
        <a-row :gutter="[16, 16]">
          <a-col :span="8" v-for="item in projectList" :key="item.id">
            <a-card hoverable>
              <template #title>
                <div class="card-title">{{ item.name }}</div>
              </template>
              <div class="card-content">
                <p>{{ item.description }}</p>
                <p>开始时间: {{ formatDate(item.start_date) }}</p>
                <p>预计结束时间: {{ formatDate(item.expected_end_date) }}</p>
                <p>状态: {{ item.status }}</p>
              </div>
              <template #actions>
                <a-button type="primary" @click="handleDownload(item)">下载材料</a-button>
                <a-button type="primary" @click="handleApply(item)">项目申报</a-button>
              </template>
            </a-card>
          </a-col>
        </a-row>
        <div class="pagination">
          <a-pagination
            v-model:current="current"
            :total="total"
            :pageSize="pageSize"
            @change="handlePageChange"
          />
        </div>
      </div>
    </a-tab-pane>
    <!-- <a-tab-pane key="open" tab="开放申报基金"> -->
      <!-- 开放申报基金项目列表 -->
    <!-- </a-tab-pane> -->
    <!-- <a-tab-pane key="closed" tab="结束申报基金"> -->
      <!-- 结束申报基金项目列表 -->
    <!-- </a-tab-pane> -->
  </a-tabs>
</template>

<script>
import { defineComponent } from 'vue';
import { message } from 'ant-design-vue';
import dayjs from 'dayjs';
import axios from 'axios';

export default defineComponent({
  name: 'OPreProjectList',
  data() {
    return {
      activeKey: 'all',
      projectList: [],
      current: 1,
      pageSize: 10,
      total: 0
    };
  },
  mounted() {
    this.fetchProjects();
  },
  methods: {
    async fetchProjects() {
      try {
        const response = await axios.post('http://localhost:8100/api/preProject/oList', {
          current: this.current,
          page_size: this.pageSize
        });
        if (response.data.code === 0) {
          this.projectList = response.data.data.records;
          this.total = response.data.data.total;
        } else {
          message.error('获取项目列表失败');
        }
      } catch (error) {
        console.error('获取项目列表出错:', error);
        message.error('获取项目列表失败');
      }
    },
    formatDate(timestamp) {
      return dayjs(timestamp * 1000).format('YYYY-MM-DD');
    },
    handlePageChange(page) {
      this.current = page;
      this.fetchProjects();
    },
    handleDownload(item) {
      // 实现下载材料功能
      console.log('下载材料:', item);
    },
    handleApply(item) {
      // 将时间戳转换为YYYY-MM-DD格式的日期字符串
      const startDate = dayjs(item.start_date * 1000).format('YYYY-MM-DD');
      const expectedEndDate = dayjs(item.expected_end_date * 1000).format('YYYY-MM-DD');
      
      // 通过路由导航到申报项目页面，并传递项目信息
      this.$router.push({
        name: '申报项目',
        query: {
          name: item.name,
          description: item.description,
          start_date: startDate,
          expected_end_date: expectedEndDate
        }
      });
    }
  }
});
</script>

<style scoped>
.card-container {
  padding: 24px;
}
.card-title {
  font-size: 16px;
  font-weight: bold;
  color: #1890ff;
}
.card-content {
  margin: 12px 0;
}
.card-content p {
  margin-bottom: 8px;
  color: #666;
}
.pagination {
  margin-top: 24px;
  text-align: center;
}
</style>