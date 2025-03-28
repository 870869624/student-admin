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
        <a-collapse  v-model:activeKey="activeKey">
          <a-collapse-panel key="1" header="公告1">
            <p>请确保在截止日期前提交项目报告。</p>
          </a-collapse-panel>
          <a-collapse-panel key="2" header="公告2">
            <p>
              <p>尊敬的科研人员，</p>
              <p>为了进一步提升科研项目的管理效率，现发布以下通知：</p>
              <ul style="margin-left: 30px;">
                <li>请确保项目申请书于截止日期前提交。</li>
                <li>每个项目需按季度提交进展报告。</li>
                <li>请各位科研人员密切配合，确保系统内信息的准确性。</li>
              </ul>
              <p style="text-align: right;">科研项目管理系统团队<br>2025年2月6日</p>
            </p>
          </a-collapse-panel>
        </a-collapse>
        <p>请确保在截止日期前提交项目报告。</p>
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
import { ref, watch } from 'vue';
const activeKey = ref(['2']);
  watch(activeKey, val => {
    console.log(val);
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
