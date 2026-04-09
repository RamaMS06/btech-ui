# Vue Component Rules (applies to: ui/vue/)

- Use Vue 3 Composition API with `<script setup lang="ts">`
- Component prefix: `Btech` (e.g., BtechButton, BtechInput)
- Props: `defineProps<T>()` with TypeScript interfaces
- Emits: `defineEmits<T>()`
- Styling: `<style scoped>` with CSS custom properties from @btech/tokens
- Component folder: ComponentName/ComponentName.vue + index.ts
- Every component needs: .vue, .stories.ts, .test.ts, .figma.ts, index.ts
- Slots for composition, props for configuration
- Import shared types from @btech/shared
