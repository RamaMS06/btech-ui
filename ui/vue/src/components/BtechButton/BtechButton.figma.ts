import figma from '@figma/code-connect';
import BtechButton from './BtechButton.vue';

figma.connect(BtechButton, '<FIGMA_NODE_URL>', {
  props: {
    variant: figma.enum('Variant', {
      Primary: 'primary',
      Secondary: 'secondary',
      Ghost: 'ghost',
    }),
    size: figma.enum('Size', {
      Small: 'sm',
      Medium: 'md',
      Large: 'lg',
    }),
    disabled: figma.boolean('Disabled'),
    label: figma.string('Label'),
  },
  example: ({ variant, size, disabled, label }) =>
    `<BtechButton variant="${variant}" size="${size}" :disabled="${disabled}">${label}</BtechButton>`,
});
