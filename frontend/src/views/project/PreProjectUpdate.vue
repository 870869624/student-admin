<template>
  <div class="container">
    <a-card title="待审核项目列表" :bordered="false">
      <a-table
        :columns="columns"
        :data-source="dataSource"
        :pagination="pagination"
        @change="handleTableChange"
      >
        <template #status="{ text }">
          <a-tag :color="text === '待审核' ? 'blue' : 'red'">
            {{ text }}
          </a-tag>
        </template>
        <template #operation="{ record }">
          <a-space>
            <a-button type="primary" size="small" @click="handleAudit(record.id, '1')">审核通过</a-button>
            <a-button type="danger" size="small" @click="handleAudit(record.id, '2')">审核不通过</a-button>
          </a-space>
        </template>
      </a-table>
    </a-card>
  </div>
</template>

<script lang="ts">
import { defineComponent, onMounted, ref } from 'vue'
import { message } from 'ant-design-vue'
import axios from 'axios'
import dayjs from 'dayjs'

export default defineComponent({
  name: 'PreProjectUpdate',
  setup() {
    const columns = [
      {
        title: '项目名称',
        dataIndex: 'name',
        key: 'name'
      },
      {
        title: '项目描述',
        dataIndex: 'description',
        key: 'description'
      },
      {
        title: '开始时间',
        dataIndex: 'start_date',
        key: 'start_date',
        customRender: ({ text }: { text: number }) => dayjs.unix(text).format('YYYY-MM-DD')
      },
      {
        title: '预计结束时间',
        dataIndex: 'expected_end_date',
        key: 'expected_end_date',
        customRender: ({ text }: { text: number }) => dayjs.unix(text).format('YYYY-MM-DD')
      },
      {
        title: '状态',
        dataIndex: 'status',
        key: 'status',
        slots: { customRender: 'status' }
      },{
        title: '操作',
        dataIndex: 'operation',
        key: 'operation',
        slots: { customRender: 'operation' }
      }
    ]

    const dataSource = ref([])
    const pagination = ref({
      current: 1,
      pageSize: 10,
      total: 0
    })

    const fetchData = async () => {
      try {
        const response = await axios.post('http://localhost:8100/api/preProject/allList', {
          current: pagination.value.current,
          page_size: pagination.value.pageSize
        })

        if (response.data.code === 0) {
          dataSource.value = response.data.data.records
          pagination.value.total = response.data.data.total
        } else {
          message.error('获取数据失败')
        }
      } catch (error) {
        message.error('请求失败')
        console.error(error)
      }
    }

    const handleTableChange = (pag: any) => {
      pagination.value.current = pag.current
      pagination.value.pageSize = pag.pageSize
      fetchData()
    }

    const handleAudit = async (projectId: number, status: string) => {
      try {
        const response = await axios.post('http://localhost:8100/api/preProject/update/status', {
          project_id: projectId,
          status: status
        });

        if (response.data.code === 0) {
          message.success('审核操作成功');
          fetchData();
        } else {
          message.error('审核操作失败');
        }
      } catch (error) {
        console.error('审核操作出错:', error);
        message.error('审核操作失败');
      }
    };

    onMounted(() => {
      fetchData()
    })

    return {
      columns,
      dataSource,
      pagination,
      handleTableChange,
      handleAudit
    }
  }
})
</script>

<style scoped>
.container {
  padding: 24px;
}
</style>