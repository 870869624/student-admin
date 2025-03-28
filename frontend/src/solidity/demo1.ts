import * as crypto from 'crypto';

// 生成 RSA 公私钥对
function generateKeyPair(): { publicKey: string, privateKey: string } {
  const { publicKey, privateKey } = crypto.generateKeyPairSync('rsa', {
    modulusLength: 512,
    publicKeyEncoding: {
      type: 'spki',
      format: 'pem'
    },
    privateKeyEncoding: {
      type: 'pkcs8',
      format: 'pem'
    }
  });
  return { publicKey, privateKey };
}

// 使用公钥加密数据
function encryptWithPublicKey(publicKey: string, data: string): string {
  const bufferData = Buffer.from(data, 'utf8');
  const encryptedData = crypto.publicEncrypt(publicKey, bufferData);
  return encryptedData.toString('base64');
}

// 使用私钥解密数据
function decryptWithPrivateKey(privateKey: string, encryptedData: string): string {
  const bufferEncryptedData = Buffer.from(encryptedData, 'base64');
  const decryptedData = crypto.privateDecrypt(privateKey, bufferEncryptedData);
  return decryptedData.toString('utf8');
}
// 示例使用
const { publicKey, privateKey } = generateKeyPair();
console.log(publicKey);
console.log(privateKey);
const originalData = "Hello, World!";
const encryptedData = encryptWithPublicKey(publicKey, originalData);
console.log("Encrypted Data:", encryptedData);
const decryptedData = decryptWithPrivateKey(privateKey, encryptedData);
console.log("Decrypted Data:", decryptedData);