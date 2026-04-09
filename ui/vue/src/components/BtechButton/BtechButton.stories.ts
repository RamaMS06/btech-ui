import type { Meta, StoryObj } from '@storybook/vue3';
import BtechButton from './BtechButton.vue';

const meta: Meta<typeof BtechButton> = {
  title: 'Components/BtechButton',
  component: BtechButton,
  tags: ['autodocs'],
  argTypes: {
    variant: {
      control: 'select',
      options: ['primary', 'secondary', 'ghost'],
    },
    size: {
      control: 'select',
      options: ['sm', 'md', 'lg'],
    },
    disabled: {
      control: 'boolean',
    },
    type: {
      control: 'select',
      options: ['button', 'submit', 'reset'],
    },
  },
};

export default meta;
type Story = StoryObj<typeof BtechButton>;

export const Primary: Story = {
  args: {
    variant: 'primary',
    size: 'md',
  },
  render: (args) => ({
    components: { BtechButton },
    setup() {
      return { args };
    },
    template: '<BtechButton v-bind="args">Button</BtechButton>',
  }),
};

export const Secondary: Story = {
  args: {
    variant: 'secondary',
    size: 'md',
  },
  render: (args) => ({
    components: { BtechButton },
    setup() {
      return { args };
    },
    template: '<BtechButton v-bind="args">Button</BtechButton>',
  }),
};

export const Ghost: Story = {
  args: {
    variant: 'ghost',
    size: 'md',
  },
  render: (args) => ({
    components: { BtechButton },
    setup() {
      return { args };
    },
    template: '<BtechButton v-bind="args">Button</BtechButton>',
  }),
};

export const Disabled: Story = {
  args: {
    variant: 'primary',
    disabled: true,
  },
  render: (args) => ({
    components: { BtechButton },
    setup() {
      return { args };
    },
    template: '<BtechButton v-bind="args">Disabled</BtechButton>',
  }),
};

export const Sizes: Story = {
  render: () => ({
    components: { BtechButton },
    template: `
      <div style="display: flex; gap: 8px; align-items: center;">
        <BtechButton size="sm">Small</BtechButton>
        <BtechButton size="md">Medium</BtechButton>
        <BtechButton size="lg">Large</BtechButton>
      </div>
    `,
  }),
};
