import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import { createPinia } from "pinia";
import "ant-design-vue/dist/reset.css";
import Antd from "ant-design-vue";
import { routerBeforeEach } from "@/access";

router.beforeEach(routerBeforeEach);

const pinia = createPinia();
const app = createApp(App);

app.use(router);
app.use(Antd);
app.use(pinia);

app.mount("#app");
