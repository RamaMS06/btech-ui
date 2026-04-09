import { Platform } from 'style-dictionary/types';

export const scssConfig: Platform = {
  transformGroup: 'scss',
  buildPath: 'generated/web/',
  files: [
    {
      destination: 'tokens.scss',
      format: 'scss/variables',
    },
  ],
};
