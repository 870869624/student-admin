import { ref, onMounted } from 'vue';
import Web3 from 'web3';

// 智能合约的 ABI 和地址
const contractABI = [
  {
    "inputs": [],
    "name": "deposit",
    "outputs": [],
    "stateMutability": "payable",
    "type": "function"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": true,
        "internalType": "address",
        "name": "sender",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "amount",
        "type": "uint256"
      }
    ],
    "name": "Deposited",
    "type": "event"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "amount",
        "type": "uint256"
      },
      {
        "internalType": "address payable",
        "name": "recipient",
        "type": "address"
      }
    ],
    "name": "withdraw",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": true,
        "internalType": "address",
        "name": "recipient",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "amount",
        "type": "uint256"
      }
    ],
    "name": "Withdrawn",
    "type": "event"
  },
  {
    "inputs": [],
    "name": "getBalance",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  }
];
const contractAddress = '0x5659c48B2743Ca33cC990E6a088636C066C4B604';

export default function useWallet() {
  const account = ref(null);
  const balance = ref(null);
  const depositAmount = ref(0);
  const withdrawAmount = ref(0);
  const recipientAddress = ref('');
  const contractBalance = ref(null);

  const connectWallet = async () => {
    if (window.ethereum) {
      try {
        await window.ethereum.request({ method: 'eth_requestAccounts' });
        const accounts = await window.ethereum.request({ method: 'eth_accounts' });
        account.value = accounts[0];
        await updateBalance();
      } catch (error) {
        console.error('连接钱包失败:', error);
      }
    } else {
      alert('请安装MetaMask钱包');
    }
  };

  const updateBalance = async () => {
    if (account.value) {
      const web3 = new Web3(window.ethereum);
      const weiBalance = await web3.eth.getBalance(account.value);
      balance.value = web3.utils.fromWei(weiBalance, 'ether');
    }
  };

  const deposit = async () => {
    if (!account.value || depositAmount.value <= 0) {
      alert('请检查输入信息');
      return;
    }
    const web3 = new Web3(window.ethereum);
    const contract = new web3.eth.Contract(contractABI, contractAddress);
    try {
      await contract.methods.deposit().send({
        from: account.value,
        value: web3.utils.toWei(depositAmount.value.toString(), 'ether')
      });
      alert('存款成功');
      await updateBalance();
    } catch (error) {
      console.error('存款失败:', error);
      alert('存款失败');
    }
  };

  const withdraw = async () => {
    if (!account.value || withdrawAmount.value <= 0 || !recipientAddress.value) {
      alert('请检查输入信息');
      return;
    }
    const web3 = new Web3(window.ethereum);
    const contract = new web3.eth.Contract(contractABI, contractAddress);
    try {
      await contract.methods.withdraw(web3.utils.toWei(withdrawAmount.value.toString(), 'ether'), recipientAddress.value).send({ from: account.value });
      alert('取款成功');
      await updateBalance();
    } catch (error) {
      console.error('取款失败:', error);
      alert('取款失败');
    }
  };

  const getContractBalance = async () => {
    if (account.value) {
      const web3 = new Web3(window.ethereum);
      const contract = new web3.eth.Contract(contractABI, contractAddress);
      const weiBalance = await contract.methods.getBalance().call();
      contractBalance.value = web3.utils.fromWei(weiBalance, 'ether');
    }
  };

  onMounted(() => {
    if (window.ethereum) {
      window.ethereum.on('accountsChanged', async (newAccounts) => {
        if (newAccounts.length > 0) {
          account.value = newAccounts[0];
          await updateBalance();
        }
      });
    }
  });

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
}