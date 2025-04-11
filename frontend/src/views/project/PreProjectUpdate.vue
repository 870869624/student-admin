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

    onMounted(() => {
      fetchData()
    })

    return {
      columns,
      dataSource,
      pagination,
      handleTableChange
    }
  }
})
</script>

<style scoped>
.container {
  padding: 24px;
}
</style>