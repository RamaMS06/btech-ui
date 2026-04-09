import { Platform } from 'style-dictionary/types';

export const cssConfig: Platform = {
  transformGroup: 'css',
  buildPath: 'generated/web/',
  files: [
    {
      destination: 'tokens.css',
      format: 'css/oklch-with-dark',
    },
  ],
};
