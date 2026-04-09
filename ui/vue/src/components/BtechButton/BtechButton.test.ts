import { describe, it, expect } from 'vitest';
import { mount } from '@vue/test-utils';
import BtechButton from './BtechButton.vue';

describe('BtechButton', () => {
  it('renders slot content', () => {
    const wrapper = mount(BtechButton, {
      slots: { default: 'Click me' },
    });
    expect(wrapper.text()).toBe('Click me');
  });

  it('applies primary variant by default', () => {
    const wrapper = mount(BtechButton);
    expect(wrapper.classes()).toContain('btech-button--primary');
  });

  it('applies the specified variant class', () => {
    const wrapper = mount(BtechButton, {
      props: { variant: 'secondary' },
    });
    expect(wrapper.classes()).toContain('btech-button--secondary');
  });

  it('applies the specified size class', () => {
    const wrapper = mount(BtechButton, {
      props: { size: 'lg' },
    });
    expect(wrapper.classes()).toContain('btech-button--lg');
  });

  it('applies md size by default', () => {
    const wrapper = mount(BtechButton);
    expect(wrapper.classes()).toContain('btech-button--md');
  });

  it('sets disabled attribute when disabled prop is true', () => {
    const wrapper = mount(BtechButton, {
      props: { disabled: true },
    });
    expect(wrapper.attributes('disabled')).toBeDefined();
  });

  it('emits click event when clicked', async () => {
    const wrapper = mount(BtechButton);
    await wrapper.trigger('click');
    expect(wrapper.emitted('click')).toHaveLength(1);
  });

  it('sets button type attribute', () => {
    const wrapper = mount(BtechButton, {
      props: { type: 'submit' },
    });
    expect(wrapper.attributes('type')).toBe('submit');
  });

  it('defaults to button type', () => {
    const wrapper = mount(BtechButton);
    expect(wrapper.attributes('type')).toBe('button');
  });
});
