<template>
  <div class="announcement-container">
    <div class="header">
      <h2>系统公告管理</h2>
      <a-button type="primary" @click="showAddModal" v-if="isAdmin">
        <plus-outlined /> 新增公告
      </a-button>
    </div>

    <a-list
      class="announcement-list"
      :data-source="announcements"
      :loading="loading"
    >
      <template #renderItem="{ item }">
        <a-list-item>
          <a-list-item-meta>
            <template #title>
              <div class="announcement-title">
                {{ item.title }}
                <a-tag v-if="item.important" color="red">重要</a-tag>
              </div>
            </template>
            <template #description>
              <div class="announcement-content">
                {{ item.content }}
                <div class="announcement-date">发布时间: {{ item.createTime }}</div>
              </div>
            </template>
          </a-list-item-meta>
          <template #extra>
            <a-button type="link" danger @click="deleteAnnouncement(item.id)" v-if="isAdmin">
              <delete-outlined /> 删除
            </a-button>
          </template>
        </a-list-item>
      </template>
    </a-list>

    <a-modal
      v-model:visible="modalVisible"
      title="新增公告"
      @ok="handleAddAnnouncement"
      @cancel="handleCancel"
    >
      <a-form :model="formState" :rules="rules" ref="formRef">
        <a-form-item label="公告标题" name="title">
          <a-input v-model:value="formState.title" placeholder="请输入公告标题" />
        </a-form-item>
        <a-form-item label="公告内容" name="content">
          <a-textarea
            v-model:value="formState.content"
            :rows="4"
            placeholder="请输入公告内容"
          />
        </a-form-item>
        <a-form-item name="important">
          <a-checkbox v-model:checked="formState.important">标记为重要公告</a-checkbox>
        </a-form-item>
      </a-form>
    </a-modal>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted, computed } from 'vue';
import { message } from 'ant-design-vue';
import { PlusOutlined, DeleteOutlined } from '@ant-design/icons-vue';
import { userStore } from "@/store/user";

export default defineComponent({
  name: 'AnnouncementList',
  components: {
    PlusOutlined,
    DeleteOutlined
  },
  setup() {
    const user = userStore();
    const loading = ref(false);
    const modalVisible = ref(false);
    const formRef = ref();
    const announcements = ref([]);

    const formState = ref({
      title: '',
      content: '',
      important: false
    });

    const rules = {
      title: [{ required: true, message: '请输入公告标题', trigger: 'blur' }],
      content: [{ required: true, message: '请输入公告内容', trigger: 'blur' }]
    };

    const isAdmin = computed(() => {
      return user.role_id === 1;
    });

    const fetchAnnouncements = async () => {
      loading.value = true;
      try {
        // TODO: 调用后端API获取公告列表
        announcements.value = [];
      } catch (error) {
        message.error('获取公告列表失败');
      } finally {
        loading.value = false;
      }
    };

    const showAddModal = () => {
      modalVisible.value = true;
    };

    const handleCancel = () => {
      modalVisible.value = false;
      formState.value = {
        title: '',
        content: '',
        important: false
      };
    };

    const handleAddAnnouncement = async () => {
      try {
        await formRef.value.validate();
        // TODO: 调用后端API添加公告
        message.success('添加公告成功');
        modalVisible.value = false;
        fetchAnnouncements();
      } catch (error) {
        console.error('表单验证失败:', error);
      }
    };

    const deleteAnnouncement = async (id: string) => {
      try {
        // TODO: 调用后端API删除公告
        message.success('删除公告成功');
        fetchAnnouncements();
      } catch (error) {
        message.error('删除公告失败');
      }
    };

    onMounted(() => {
      fetchAnnouncements();
    });

    return {
      loading,
      announcements,
      modalVisible,
      formState,
      formRef,
      rules,
      isAdmin,
      showAddModal,
      handleCancel,
      handleAddAnnouncement,
      deleteAnnouncement
    };
  }
});
</script>

<style scoped>
.announcement-container {
  padding: 24px;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}

.announcement-list {
  background: #fff;
  padding: 24px;
  border-radius: 4px;
}

.announcement-title {
  display: flex;
  align-items: center;
  gap: 8px;
}

.announcement-content {
  white-space: pre-wrap;
}

.announcement-date {
  color: #999;
  font-size: 12px;
  margin-top: 8px;
}
</style>