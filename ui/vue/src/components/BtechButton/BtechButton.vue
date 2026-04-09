<script setup lang="ts">
import type { BtechSize, BtechVariant } from '@btech/shared';

export interface BtechButtonProps {
  variant?: BtechVariant;
  size?: BtechSize;
  disabled?: boolean;
  type?: 'button' | 'submit' | 'reset';
}

withDefaults(defineProps<BtechButtonProps>(), {
  variant: 'primary',
  size: 'md',
  disabled: false,
  type: 'button',
});

defineEmits<{
  click: [event: MouseEvent];
}>();
</script>

<template>
  <button
    :class="['btech-button', `btech-button--${variant}`, `btech-button--${size}`]"
    :type="type"
    :disabled="disabled"
    @click="$emit('click', $event)"
  >
    <slot />
  </button>
</template>

<style scoped>
.btech-button {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  font-family: var(--font-sans);
  font-weight: 500;
  border-width: 1px;
  border-style: solid;
  cursor: pointer;
  transition: background-color var(--duration-fast) var(--ease-default),
              border-color var(--duration-fast) var(--ease-default);
}

.btech-button:disabled {
  cursor: not-allowed;
  background-color: var(--muted);
  color: var(--muted-foreground);
  border-color: var(--muted);
}

/* Variants */
.btech-button--primary {
  background-color: var(--primary);
  color: var(--primary-foreground);
  border-color: var(--primary);
}

.btech-button--primary:hover:not(:disabled) {
  opacity: 0.9;
}

.btech-button--secondary {
  background-color: var(--secondary);
  color: var(--secondary-foreground);
  border-color: var(--border);
}

.btech-button--secondary:hover:not(:disabled) {
  opacity: 0.8;
}

.btech-button--ghost {
  background-color: transparent;
  color: var(--accent-foreground);
  border-color: transparent;
}

.btech-button--ghost:hover:not(:disabled) {
  background-color: var(--accent);
}

/* Sizes */
.btech-button--sm {
  padding: 0.25rem 0.5rem;
  font-size: 0.75rem;
  border-radius: calc(var(--radius) - 4px);
}

.btech-button--md {
  padding: 0.5rem 1rem;
  font-size: 0.875rem;
  border-radius: calc(var(--radius) - 2px);
}

.btech-button--lg {
  padding: 1rem 1.5rem;
  font-size: 1rem;
  border-radius: var(--radius);
}
</style>
