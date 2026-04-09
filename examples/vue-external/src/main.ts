import { createApp } from 'vue';
import App from './App.vue';

// Import tokens CSS — all custom properties available globally
// This single import gives you: --primary, --border, --radius, etc.
import 'btech-ui/tokens/generated/web/tokens.css';

createApp(App).mount('#app');
