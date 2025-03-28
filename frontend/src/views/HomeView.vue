<template>
  <a-layout-content class="content">
    <!-- 页面头部 -->
    <div class="page-header">
      <h1>欢迎进入科研管理系统</h1>
      <p>一站式科研项目管理平台</p>
    </div>

    <!-- 公告板块 -->
    <div class="announcements">
      <a-card title="系统公告">
        <a-collapse v-model:activeKey="activeKey">
          <a-collapse-panel v-for="item in announcements" :key="item.id" :header="item.title">
            <p>{{ item.content }}</p>
          </a-collapse-panel>
        </a-collapse>
      </a-card>
    </div>

    <!-- 项目展示轮播 -->
    <div class="project-carousel">
      <a-carousel autoplay>
        <div>
          <img alt="科研项目封面1" src="@/assets/img.png" />
          <p class="carousel-caption">科研项目一</p>
        </div>
        <div>
          <img alt="科研项目封面2" src="@/assets/img2.png" />
          <p class="carousel-caption">科研项目二</p>
        </div>
        <div>
          <img alt="科研项目封面3" src="@/assets/img3.png" />
          <p class="carousel-caption">科研项目三</p>
        </div>
      </a-carousel>
    </div>

    <!-- 最近项目动态 -->
    <div class="placeholder-section">
      <a-card title="最近项目动态" bordered>
        <p>暂无数据展示</p>
      </a-card>
    </div>
  </a-layout-content>
</template>

<script lang="ts" setup>
import { ref, onMounted } from 'vue';
import { message } from 'ant-design-vue';

const activeKey = ref([]);
const announcements = ref([]);

const fetchAnnouncements = async () => {
  try {
    const response = await fetch('http://localhost:8100/api/announce/list');
    const data = await response.json();
    if (data.code === 0) {
      announcements.value = data.data.records;
      if (announcements.value.length > 0) {
        activeKey.value = [announcements.value[0].id];
      }
    } else {
      message.error(data.msg || '获取公告列表失败');
    }
  } catch (error) {
    console.error('获取公告列表失败:', error);
    message.error('获取公告列表失败');
  }
};

onMounted(() => {
  fetchAnnouncements();
});
</script>

<style scoped>
.content {
  padding: 24px;
  background: #f0f2f5;
}

.page-header h1 {
  font-size: 28px;
  margin: 0;
}

.page-header p {
  color: #888;
}

.announcements {
  margin-bottom: 24px;
}

.project-carousel {
  width: 100%; /* 让宽度自适应 */
  height: 600px; /* 设置固定高度，或你需要的值 */
  overflow: hidden; /* 防止内容溢出 */
}

.project-carousel .ant-carousel .slick-slide img {
  width: 100%; /* 让图片宽度自适应 */
  height: 100%; /* 让图片的高度填满父容器 */
  object-fit: cover; /* 保持图片的纵横比，裁剪超出部分 */
}

.carousel-caption {
  position: absolute;
  bottom: 20px;
  left: 20px;
  color: #fff;
  font-size: 16px;
  background-color: rgba(0, 0, 0, 0.5);
  padding: 5px 10px;
}
</style>
