import StyleDictionary from 'style-dictionary';
import { cssConfig } from './platforms/css.js';
import { scssConfig } from './platforms/scss.js';
import { jsConfig } from './platforms/js.js';
import { dartConfig } from './platforms/dart.js';
import { figmaJsonConfig } from './platforms/json-figma.js';
import { registerCustomTransforms } from './transforms/custom-transforms.js';
import { registerDartFormat } from './formats/dart-class.js';
import { registerFigmaJsonFormat } from './formats/figma-json.js';
import { registerCssWithDarkFormat } from './formats/css-with-dark.js';

// Register custom transforms and formats
registerCustomTransforms(StyleDictionary);
registerDartFormat(StyleDictionary);
registerFigmaJsonFormat(StyleDictionary);
registerCssWithDarkFormat(StyleDictionary);

const sd = new StyleDictionary({
  source: ['src/**/*.json'],
  platforms: {
    css: cssConfig,
    scss: scssConfig,
    js: jsConfig,
    dart: dartConfig,
    figma: figmaJsonConfig,
  },
});

await sd.buildAllPlatforms();
console.log('Token build complete!');
