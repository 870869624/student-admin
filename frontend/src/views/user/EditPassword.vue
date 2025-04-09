<template>
    <a-card title="个人信息管理" style="max-width: 1200px; margin: 5px auto;background-color: #e8e8e8;">
        <div class="change-password-container">
            <h1 class="page-title">修改密码</h1>
            <a-form @finish="handleSubmit" layout="vertical" :model="formData" ref="formRef">
                <a-form-item label="原密码" name="oldPassword" :rules="[{ required: true, message: '请输入原密码' }]">
                    <a-input-password v-model:value="formData.oldPassword" placeholder="请输入原密码" />
                </a-form-item>
                <a-form-item label="新密码" name="newPassword" :rules="[{ required: true, message: '请输入新密码' }]">
                    <a-input-password v-model:value="formData.newPassword" placeholder="请输入新密码" />
                </a-form-item>
                <a-form-item label="确认新密码" :rules="[
                    { required: true, message: '请确认新密码' },
                    { validator: validateConfirmPassword }
                ]">
                    <a-input-password v-model:value="formData.confirmPassword" placeholder="请再次输入新密码" />
                </a-form-item>
                <a-form-item>
                    <a-button type="primary" html-type="submit" class="submit-button">提交</a-button>
                    <a-button style="margin-left: 8px" @click="handleCancel">取消</a-button>
                </a-form-item>
            </a-form>
        </div>
    </a-card>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue';
import { FormInstance, message } from 'ant-design-vue';
import { userStore } from "@/store/user";
import { UserUpdateRequest } from "@/api";
import { UserControllerService } from "@/api/services/UserControllerService";

const editForm = reactive<UserUpdateRequest>({
    id: 0,
    account: "",
    password: "",
    username: "",
    position: "",
    phone: "",
    email: "",
    department: "",
    role_id: 0,
    job: "",
    gender: "",
    organization: "",
});
const user = userStore();
Object.assign(editForm, user);

// 表单数据绑定
const formData = reactive({
    oldPassword: '',
    newPassword: '',
    confirmPassword: ''
});

// 表单引用
const formRef = ref<FormInstance>();

// 提交表单
const handleSubmit = async () => {
    const form = formRef.value;
    if (!form) return;

    try {
        // 验证表单
        await form.validateFields();
        editForm.password = formData.newPassword;

        const res = await UserControllerService.Update(editForm);
        if (res.code === 0) {
            message.success("密码修改成功");
            form.resetFields();
            setTimeout(() => {
                location.reload();
            }, 500);
        } else {
            message.error(res.msg || "密码修改失败，请稍后重试");
        }
    } catch (error) {
        // 表单验证失败
        if (error instanceof Error) {
            message.error("请填写完整并确保信息正确");
        } else {
            console.error("网络请求错误:", error);
            message.error("网络请求错误，请稍后重试");
        }
    }
};

// 确认密码校验
const validateConfirmPassword = (rule: any, value: string) => {
    if (rule && value !== formData.newPassword) {
        return Promise.reject(new Error('确认密码与新密码不一致'));
    }
    return Promise.resolve();
};

// 取消操作
const handleCancel = () => {
    const form = formRef.value;
    if (form) {
        form.resetFields();
    }
};

</script>

<style scoped>
.change-password-container {
    max-width: 450px;
    margin: auto;
    padding: 20px;
    border: 1px solid #e8e8e8;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    background: white;
}

.page-title {
    font-size: 20px;
    text-align: center;
    margin-bottom: 20px;
}

.submit-button {
    background: #000120;
    width: 80%;
}
</style>