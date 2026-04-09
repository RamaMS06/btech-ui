import { Platform } from 'style-dictionary/types';

export const figmaJsonConfig: Platform = {
  transformGroup: 'js',
  buildPath: 'generated/figma/',
  files: [
    {
      destination: 'figma-tokens.json',
      format: 'json/nested',
    },
  ],
};
