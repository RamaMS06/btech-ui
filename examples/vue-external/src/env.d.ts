/// <reference types="vite/client" />

declare module '*.vue' {
  import type { DefineComponent } from 'vue';
  const component: DefineComponent<{}, {}, any>;
  export default component;
}

// Allow importing CSS from btech-ui
declare module 'btech-ui/tokens/generated/web/tokens.css';
