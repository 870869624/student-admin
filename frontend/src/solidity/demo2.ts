import * as crypto from 'crypto';
import Web3 from 'web3';

const web3 = new Web3();
const account = web3.eth.accounts.create();

// 对私钥进行处理，使其适合作为对称密钥
function processPrivateKey(privateKey: string): Buffer {
  // 使用 SHA-256 对私钥进行哈希处理，得到 32 字节的密钥
  return crypto.createHash('sha256').update(privateKey).digest();
}

// 使用对称密钥加密数据
function encryptData(key: Buffer, data: string): { iv: string, encryptedData: string } {
  const iv = crypto.randomBytes(16); // 初始化向量，增加加密的随机性
  const cipher = crypto.createCipheriv('aes-256-cbc', key, iv);
  let encrypted = cipher.update(data, 'utf8', 'hex');
  encrypted += cipher.final('hex');
  return {
    iv: iv.toString('hex'),
    encryptedData: encrypted
  };
}

// 使用对称密钥解密数据
function decryptData(key: Buffer, iv: string, encryptedData: string): string {
  const decipher = crypto.createDecipheriv('aes-256-cbc', key, Buffer.from(iv, 'hex'));
  let decrypted = decipher.update(encryptedData, 'hex', 'utf8');
  decrypted += decipher.final('utf8');
  return decrypted;
}

// 示例使用
const privateKey = account.privateKey;
const processedKey = processPrivateKey(privateKey);
const originalData = "-----BEGIN PRIVATE KEY-----\n" +
  "MIIBVQIBADANBgkqhkiG9w0BAQEFAASCAT8wggE7AgEAAkEA17YSkM4K1CeephFf\n" +
  "2nwJwiLWdq44oqa2mEHrtdXi2pGbeY1eYZNxWMbKEn1Z7UEpBCxhpHEQOjHrQX5B\n" +
  "K1oYyQIDAQABAkEAhVv+LGIF1dXMwnS5YvUOf2RUXLknMH+LIaSXmipqfp8l2H2Q\n" +
  "Nc3U4yhdRAcEj1dW12XEfnixfPIL3A5qI84MZQIhAPMtNVwREw+7CkWzRdvJ/+S5\n" +
  "8X8K8Bb2GZJWRzvg+6YnAiEA4xYXi4Irbuj1/gdtku921RudpdJxho8T5oS0WzMU\n" +
  "D48CIDaAC1V2/i6oXMUCSMXZn+BDTDyM1wJOZazGaXCiG8RBAiBMQgb2Gmhrfl/d\n" +
  "RrFNPo0xU2zFWr406adNKhNG7Qg3kQIhALR3M4bZUdsGCl5nEif25aNe5zxw0wwm\n" +
  "tqC7uC6/7KZs\n" +
  "-----END PRIVATE KEY-----";
const { iv, encryptedData } = encryptData(processedKey, originalData);
console.log("Encrypted Data:", encryptedData);
console.log("Initialization Vector:", iv);
const decryptedData = decryptData(processedKey, iv, encryptedData);
console.log("Decrypted Data:", decryptedData);