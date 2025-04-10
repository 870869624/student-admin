<template>
  <a-tabs>
    <a-tab-pane key="all" tab="全部">
      <!-- 全部项目列表 -->
    </a-tab-pane>
    <a-tab-pane key="open" tab="开放申报基金">
      <!-- 开放申报基金项目列表 -->
    </a-tab-pane>
    <a-tab-pane key="closed" tab="结束申报基金">
      <!-- 结束申报基金项目列表 -->
    </a-tab-pane>
  </a-tabs>
</template>

<script>
export default {
  name: 'OPreProjectList',
  data() {
    return {
      // 数据属性
    };
  },
  methods: {
    // 方法
  }
};
</script>

<style scoped>
/* 样式 */
</style>