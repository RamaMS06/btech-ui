import { Platform } from 'style-dictionary/types';

export const jsConfig: Platform = {
  transformGroup: 'js',
  buildPath: 'generated/web/',
  files: [
    {
      destination: 'tokens.mjs',
      format: 'javascript/es6',
    },
    {
      destination: 'tokens.d.ts',
      format: 'typescript/es6-declarations',
    },
  ],
};
