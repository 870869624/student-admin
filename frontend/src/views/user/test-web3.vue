<template>
  <div class="wallet-app">
    <button @click="connectWallet" class="btn">连接钱包</button>
    <div v-if="account" class="account-info">
      <p>账号：{{ account }}</p>
      <p>余额：{{ balance }} ETH</p>
      <div class="input-group">
        <input v-model="depositAmount" type="number" placeholder="存款金额" class="input" />
        <button @click="deposit" class="btn">存款</button>
      </div>
      <div class="input-group">
        <input v-model="withdrawAmount" type="number" placeholder="取款金额" class="input" />
        <input v-model="recipientAddress" placeholder="接收方地址" class="input" />
        <button @click="withdraw" class="btn">取款</button>
      </div>
      <div class="input-group">
        <button @click="getContractBalance" class="btn">获取合约余额</button>
        <p>合约余额：{{ contractBalance }} ETH</p>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue';
import useWallet from '../../solidity/web3';

export default {
  setup() {
    const {
      account,
      balance,
      depositAmount,
      withdrawAmount,
      recipientAddress,
      contractBalance,
      connectWallet,
      deposit,
      withdraw,
      getContractBalance
    } = useWallet();

    return {
      account,
      balance,
      depositAmount,
      withdrawAmount,
      recipientAddress,
      contractBalance,
      connectWallet,
      deposit,
      withdraw,
      getContractBalance
    };
  },
};
</script>

<style>
.wallet-app {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
  background-color: #f9f9f9;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.wallet-app .btn {
  display: inline-block;
  padding: 10px 20px;
  margin: 10px 0;
  background-color: #007bff;
  color: #fff;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.wallet-app .btn:hover {
  background-color: #0056b3;
}

.wallet-app .input-group {
  display: flex;
  margin: 10px 0;
}

.wallet-app .input-group .input {
  flex: 1;
  padding: 10px;
  margin-right: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

.wallet-app .account-info {
  background-color: #fff;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.wallet-app p {
  margin: 10px 0;
  font-size: 16px;
  color: #333;
}
</style>