import { Platform } from 'style-dictionary/types';

export const dartConfig: Platform = {
  transforms: ['name/camel', 'color/hex8flutter', 'dimension/remToDouble'],
  buildPath: 'generated/flutter/',
  files: [
    {
      destination: 'tokens.dart',
      format: 'dart/class',
      options: {
        className: 'AppTokens',
      },
    },
  ],
};
