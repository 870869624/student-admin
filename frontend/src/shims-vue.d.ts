/* eslint-disable */
declare module '*.vue' {
  import type { DefineComponent } from 'vue'
  const component: DefineComponent<{}, {}, any>
  export default component
}
// src/globals.d.ts
declare global {
  interface Window {
    ethereum: any;
  }
}
