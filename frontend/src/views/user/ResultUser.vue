<template>
  <a-card title="项目列表" style="max-width: 1200px; margin: 50px auto">
    <!-- 搜索框区域 -->
    <a-form layout="inline" style="margin-bottom: 20px">
      <a-form-item label="项目名称">
        <a-input
          v-model:value="pageRequest.name"
          placeholder="请输入项目名称"
          style="width: 200px"
        />
      </a-form-item>

      <a-form-item label="部门">
        <a-input
          v-model:value="pageRequest.department"
          placeholder="请输入部门"
          style="width: 200px"
        />
      </a-form-item>

      <a-form-item label="项目描述">
        <a-input
          v-model:value="pageRequest.description"
          placeholder="请输入项目描述"
          style="width: 200px"
        />
      </a-form-item>

      <a-form-item label="项目批次">
        <a-input
          v-model:value="pageRequest.batch"
          placeholder="请输入项目批次"
          style="width: 200px"
        />
      </a-form-item>

      <a-form-item style="margin-top: 10px" label="项目来源">
        <a-input
          v-model:value="pageRequest.source"
          placeholder="请输入项目来源"
          style="width: 200px"
        />
      </a-form-item>

      <a-form-item label="项目状态" style="margin-top: 10px">
        <a-select
          v-model:value="pageRequest.status"
          placeholder="请选择状态"
          style="width: 200px"
        >
          <a-select-option value="declared">已申报</a-select-option>
          <a-select-option value="initiated">已立项</a-select-option>
          <a-select-option value="progress">进行中</a-select-option>
          <a-select-option value="completed">已完成</a-select-option>
          <a-select-option value="extended">已延期</a-select-option>
          <a-select-option value="terminated">已终止</a-select-option>
        </a-select>
      </a-form-item>

      <a-form-item style="margin-top: 10px">
        <a-button
          type="primary"
          @click="handleProjects"
          style="margin-left: 10px"
        >
          搜索
        </a-button>
      </a-form-item>
    </a-form>

    <a-table
      :data-source="projects"
      :pagination="false"
      row-key="id"
      bordered
      size="middle"
      :loading="loading"
    >
      <a-table-column title="项目名称" data-index="name" key="name" />
      <a-table-column title="描述" data-index="description" key="description" />
      <a-table-column title="开始日期" data-index="start_date" key="start_date">
        <template #default="{ text }">{{ formatDate(text) }}</template>
      </a-table-column>

      <a-table-column
        title="预计结束日期"
        data-index="expected_end_date"
        key="expected_end_date"
      >
        <template #default="{ text }">{{ formatDate(text) }}</template>
      </a-table-column>
      <a-table-column title="状态" data-index="status" key="status">
        <template #default="{ text }">
          <a-tag :color="getStatusColor(text)">{{ getStatusText(text) }}</a-tag>
        </template>
      </a-table-column>
      <a-table-column title="部门" data-index="department" key="department" />
      <a-table-column title="批次" data-index="batch" key="batch" />
      <a-table-column title="来源" data-index="source" key="source" />
      <a-table-column title="操作" key="action">
        <template #default="{ record }">
          <a-button type="link" @click="handleDownload(record)">
            下载文件
          </a-button>
        </template>
      </a-table-column>
    </a-table>
    <div style="text-align: right; margin-top: 20px">
      <a-pagination
        v-model:current="pageRequest.current"
        :total="total"
        :page-size="pageRequest.page_size"
        @change="handlePageChange"
        size="small"
        show-less-items
      />
    </div>
  </a-card>

  <a-card hoverable style="width: 90%; margin: auto">
    <div class="chart-container">
    <VueUiQuickChart
      :dataset="dataset1"
      :config="config1"
    />
    <VueUiQuickChart
      :dataset="dataset"
      :config="config"
    />
    </div>
  </a-card>

</template>

<script setup lang="ts">
import { onMounted, reactive, ref } from "vue";
import {
  FileControllerService,
  ProjectControllerService,
  ProjectListRequest,
  ProjectResponse,
  ProjectUpdateRequest,
  UserResponse,
} from "@/api";
import { message } from "ant-design-vue";
import { userStore } from "@/store/user";
import { UploadRequestOption } from "ant-design-vue/es/vc-upload/interface";
import { UserControllerService } from "@/api/services/UserControllerService";
//数据可视化图表
import { VueUiQuickChart } from "vue-data-ui";
import "vue-data-ui/style.css";

const pageRequest = reactive<ProjectListRequest>({
  current: 1,
  page_size: 10,
  name: "",
  description: "",
  department: "",
  batch: "",
  source: "",
  result_type: "",
  status: "",
  user_id: 0,
});
const total = ref(0);

const projects = ref<ProjectResponse[]>([]);

const user = userStore();

const formatDate = (timestamp: number) => {
  const date = new Date(timestamp * 1000);
  const year = date.getFullYear();
  const month = (date.getMonth() + 1).toString().padStart(2, "0");
  const day = date.getDate().toString().padStart(2, "0");
  return `${year}-${month}-${day}`;
};

const getStatusText = (status: string) => {
  switch (status) {
    case "declared":
      return "已申报";
    case "initiated":
      return "已立项";
    case "progress":
      return "进行中";
    case "completed":
      return "已完成";
    case "extended":
      return "已延期";
    case "terminated":
      return "已终止";
    default:
      return "未知状态";
  }
};

const getStatusColor = (status: string) => {
  switch (status) {
    case "declared":
      return "blue";
    case "initiated":
      return "green";
    case "progress":
      return "orange";
    case "completed":
      return "red";
    case "extended":
      return "purple";
    case "terminated":
      return "gray";
    default:
      return "default";
  }
};

const dataset1 = ref([89,66,88]);
const config1 = ref({
  responsive: false, backgroundColor: "#FFFFFF", barAnimated: true, barGap: 12, barStrokeWidth: 1, blurOnHover: true, chartIsBarUnderDatasetLength: 6, color: "#2D353C", dataLabelFontSize: 14,
  dataLabelRoundingPercentage: 1, dataLabelRoundingValue: 1, donutHideLabelUnderPercentage: 3, donutLabelMarkerStrokeWidth: 1, donutRadiusRatio: 0.4, donutShowTotal: true, donutStrokeWidth: 2, donutThicknessRatio: 0.18, donutTotalLabelFontSize: 24, donutTotalLabelOffsetY: 0,
  donutTotalLabelText: "总数", donutUseShadow: false, donutShadowColor: "#1A1A1A", fontFamily: "inherit", height: 338,
  legendFontSize: 12, legendIcon: "circleFill", legendIconSize: 12, lineAnimated: true, lineSmooth: true, lineStrokeWidth: 2, paletteStartIndex: 0,
  showDataLabels: true, showLegend: true, showTooltip: true, showUserOptions: true,
  userOptionsButtons: { tooltip: true, pdf: true, img: true, fullscreen: true, annotator: true },
  userOptionsButtonTitles: { open: "打开选项", close: "关闭选项", tooltip: "切换提示", pdf: "下载PDF", img: "下载PNG", fullscreen: "切换全屏", annotator: "切换注释器" },
  title: "一个快速图表", titleBold: true, titleFontSize: 16, titleTextAlign: "center",
  tooltipCustomFormat: null, tooltipBorderRadius: 4, tooltipBorderColor: "#e1e5e8", tooltipBorderWidth: 1, tooltipFontSize: 14, tooltipBackgroundOpacity: 30, tooltipPosition: "center", tooltipOffsetY: 24,
  useCustomLegend: false, valuePrefix: "", valueSuffix: "", width: 512, xyAxisStroke: "#CCCCCC", xyAxisStrokeWidth: 1, xyGridStroke: "#e1e5e8", xyGridStrokeWidth: 0.5, xyHighlighterColor: "#000000", xyHighlighterOpacity: 0.05, xyLabelsXFontSize: 8, xyLabelsYFontSize: 12, xyPaddingBottom: 48, xyPaddingLeft: 48, xyPaddingRight: 12, xyPaddingTop: 24,
  xyPeriods: ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"], // 修改月份为中文
  xyPeriodLabelsRotation: 0, xyScaleSegments: 10, xyShowAxis: true, xyShowGrid: true, xyShowScale: true,
  yAxisLabel: "数量", xAxisLabel: "时间", axisLabelsFontSize: 12, userOptionsPosition: "right",
  zoomXy: true, zoomColor: "#CCCCCC", zoomHighlightColor: "#4A4A4A", zoomFontSize: 14, zoomUseResetSlot: false, zoomMinimap: { show: true, smooth: true, selectedColor: "#1f77b4", selectedColorOpacity: 0.2, lineColor: "#1f77b4", selectionRadius: 2, indicatorColor: "#1A1A1A" }, zoomStartIndex: null, zoomEndIndex: null,
  showUserOptionsOnChartHover: false, keepUserOptionsStateOnChartLeave: true, zoomEnableRangeHandles: true, zoomEnableSelectionDrag: true
});
const dataset = ref([{ name: '教育', value: 10 }]);
const config = ref({
  responsive: false, backgroundColor: "#FFFFFF", barAnimated: true, barGap: 12, barStrokeWidth: 1, blurOnHover: true, chartIsBarUnderDatasetLength: 6, color: "#2D353C",
  dataLabelFontSize: 14, dataLabelRoundingPercentage: 1, dataLabelRoundingValue: 1,
  donutHideLabelUnderPercentage: 3, donutLabelMarkerStrokeWidth: 1, donutRadiusRatio: 0.4, donutShowTotal: true, donutStrokeWidth: 2, donutThicknessRatio: 0.18, donutTotalLabelFontSize: 24, donutTotalLabelOffsetY: 0, donutTotalLabelText: "科研总数", donutUseShadow: false,donutShadowColor: "#1A1A1A",
  fontFamily: "inherit", height: 338,
  legendFontSize: 12, legendIcon: "circleFill", legendIconSize: 12, lineAnimated: true, lineSmooth: true, lineStrokeWidth: 2, paletteStartIndex: 0,
  showDataLabels: true, showLegend: true, showTooltip: true, showUserOptions: true,
  userOptionsButtons: { tooltip: true, pdf: true, img: true, fullscreen: true, annotator: true },
  userOptionsButtonTitles: { open: "打开选项", close: "关闭选项", tooltip: "切换提示", pdf: "下载PDF", img: "下载PNG", fullscreen: "切换全屏", annotator: "切换注释器" },
  title: "科研总数饼状分析图", titleBold: true, titleFontSize: 16, titleTextAlign: "center",
  tooltipCustomFormat: null, tooltipBorderRadius: 4, tooltipBorderColor: "#e1e5e8", tooltipBorderWidth: 1, tooltipFontSize: 14, tooltipBackgroundOpacity: 30, tooltipPosition: "center", tooltipOffsetY: 24,
  useCustomLegend: false, valuePrefix: "", valueSuffix: "", width: 512,
  xyAxisStroke: "#CCCCCC", xyAxisStrokeWidth: 1, xyGridStroke: "#e1e5e8", xyGridStrokeWidth: 0.5, xyHighlighterColor: "#000000", xyHighlighterOpacity: 0.05, xyLabelsXFontSize: 8, xyLabelsYFontSize: 12, xyPaddingBottom: 48, xyPaddingLeft: 48, xyPaddingRight: 12, xyPaddingTop: 24,
  yAxisLabel: "数量", xAxisLabel: "类别", axisLabelsFontSize: 12, userOptionsPosition: "right",
  zoomXy: true, zoomColor: "#CCCCCC", zoomHighlightColor: "#4A4A4A", zoomFontSize: 14, zoomUseResetSlot: false,
  zoomMinimap: { show: true, smooth: true, selectedColor: "#1f77b4", selectedColorOpacity: 0.2, lineColor: "#1f77b4", selectionRadius: 2, indicatorColor: "#1A1A1A" },
  zoomStartIndex: null, zoomEndIndex: null, showUserOptionsOnChartHover: false, keepUserOptionsStateOnChartLeave: true, zoomEnableRangeHandles: true, zoomEnableSelectionDrag: true
});
const getMonthName = (month: number) => {
  const monthNames = ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"];
  return monthNames[month - 1];
};

// 加载状态
const loading = ref(false);
// 处理分页
const handles = async () => {
  // 获取第一页数据以获取总页数
  const firstPageRes = await ProjectControllerService.List({
    ...pageRequest,
    current: 1,
    page_size: pageRequest.page_size,
  });
  if (firstPageRes.code === 0) {
    const totalPages = Math.ceil(firstPageRes.data.total / pageRequest.page_size);

    // 用于存储所有项目数据
    let allProjects: ProjectResponse[] = [];

    // 逐页请求数据
    for (let page = 1; page <= totalPages; page++) {
      const res = await ProjectControllerService.List({
        ...pageRequest,
        current: page,
        page_size: pageRequest.page_size,
      });
      if (res.code === 0) {
        allProjects = allProjects.concat(res.data.records);
      } else {
        message.error(res.msg);
        return;
      }
    }

    // 更新projects数组
    projects.value = allProjects;

    // 统计每个状态的数量
    const statusCount: { [key: string]: number } = {};
    allProjects.forEach((project) => {
      if (statusCount[project.status]) {
        statusCount[project.status]++;
      } else {
        statusCount[project.status] = 1;
      }
    });

    // 更新dataset
    dataset.value = Object.entries(statusCount).map(([name, value]) => ({
      name: getStatusText(name),
      value,
    }));

    // 初始化每个月份的数量为0
    const monthCount: { [key: string]: number } = {
      "1月": 0, "2月": 0, "3月": 0, "4月": 0, "5月": 0, "6月": 0,
      "7月": 0, "8月": 0, "9月": 0, "10月": 0, "11月": 0, "12月": 0,
    };

    // 统计每个月份的数量
    allProjects.forEach((project) => {
      if (project.start_date) {
        const month = new Date(project.start_date * 1000).getMonth() + 1;
        const monthName = getMonthName(month);
        monthCount[monthName]++;
      }
    });

    // 更新dataset1
    dataset1.value = Object.values(monthCount);
  } else {
    message.error(firstPageRes.msg);
  }
};

const handleProjects = async () => {
  pageRequest.user_id = user.id;
  const res = await ProjectControllerService.List(pageRequest);
  if (res.code === 0) {
    projects.value = res.data.records;
    total.value = res.data.total;
  } else {
    message.error(res.msg);
  }
};
onMounted(() => {
  handleProjects();
  handles();
});

const handlePageChange = (page: number) => {
  pageRequest.current = page;
  handleProjects();
};

// 下载文件
const handleDownload = (record: ProjectResponse) => {
  window.location.href = record.file_path;
  message.success("下载成功");
};
</script>

<style scoped>
.a-form-item {
  margin-bottom: 20px;
}

.a-button[type="primary"] {
  background-color: #3f6ad8;
  border-color: #3f6ad8;
  border-radius: 4px;
}

.a-button[type="primary"]:hover {
  background-color: #2f4bbf;
  border-color: #2f4bbf;
}

.ant-table-thead > tr > th {
  background-color: #f0f2f5;
  color: #333;
  font-weight: 500;
}

.ant-table-tbody > tr > td {
  background-color: #fff;
  color: #555;
}

.ant-table-tbody > tr:hover {
  background-color: #fafafa;
}

.ant-table-tbody > tr > td,
.ant-table-thead > tr > th {
  border: 1px solid #e8e8e8;
  padding: 12px 16px;
  text-align: center;
}

.ant-table-pagination {
  display: flex;
  justify-content: flex-end;
  margin-top: 20px;
}

.chart-container {
  display: flex;
  flex-wrap: nowrap; /* 不换行 */
  justify-content: space-between; /* 在两个图表之间留出空间 */
  position: relative; /* 设置相对定位，以便伪元素可以相对于它定位 */
}

.chart-container::before {
  content: '';
  position: absolute;
  top: 0;
  bottom: 0;
  left: 50%; /* 分隔线位于中间 */
  width: 1px; /* 分隔线宽度 */
  background-color: #ccc; /* 分隔线颜色 */
  transform: translateX(-50%); /* 确保分隔线正好位于中间 */
}

.chart-container > * {
  flex: 1; /* 让每个图表占据相等的空间 */
  margin: 0 10px; /* 添加一些间距 */
}
</style>
