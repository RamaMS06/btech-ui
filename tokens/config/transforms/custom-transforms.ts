import StyleDictionary from 'style-dictionary';

export function registerCustomTransforms(sd: typeof StyleDictionary) {
  // Convert hex color to Flutter ARGB format: #2563eb → 0xFF2563EB
  sd.registerTransform({
    name: 'color/hex8flutter',
    type: 'value',
    filter: (token) => token.$type === 'color' && String(token.value).startsWith('#'),
    transform: (token) => {
      const hex = String(token.value).replace('#', '');
      if (hex.length === 6) {
        return `0xFF${hex.toUpperCase()}`;
      }
      if (hex.length === 8) {
        return `0x${hex.toUpperCase()}`;
      }
      return token.value;
    },
  });

  // Convert rem/px dimensions to plain double for Flutter/native
  // "1rem" → 16, "0.5rem" → 8, "16px" → 16, "0" → 0
  sd.registerTransform({
    name: 'dimension/remToDouble',
    type: 'value',
    filter: (token) => token.$type === 'dimension',
    transform: (token) => {
      const value = String(token.value);
      if (value === '0') return '0';
      if (value.endsWith('rem')) {
        const rem = parseFloat(value);
        return isNaN(rem) ? value : (rem * 16).toString();
      }
      if (value.endsWith('px')) {
        const px = parseFloat(value);
        return isNaN(px) ? value : px.toString();
      }
      if (value.endsWith('em')) {
        const em = parseFloat(value);
        return isNaN(em) ? value : (em * 16).toString();
      }
      const num = parseFloat(value);
      return isNaN(num) ? value : num.toString();
    },
  });
}
