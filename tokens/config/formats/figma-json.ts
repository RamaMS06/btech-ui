import StyleDictionary from 'style-dictionary';

export function registerFigmaJsonFormat(sd: typeof StyleDictionary) {
  sd.registerFormat({
    name: 'json/figma-tokens-studio',
    format: ({ dictionary }) => {
      const result: Record<string, unknown> = {};

      dictionary.allTokens.forEach((token) => {
        const path = token.path;
        let current = result;

        for (let i = 0; i < path.length - 1; i++) {
          if (!current[path[i]]) {
            current[path[i]] = {};
          }
          current = current[path[i]] as Record<string, unknown>;
        }

        const lastKey = path[path.length - 1];
        current[lastKey] = {
          value: token.original.$value ?? token.value,
          type: token.$type,
        };
      });

      return JSON.stringify(result, null, 2);
    },
  });
}
