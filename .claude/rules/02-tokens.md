# Token Rules (applies to: tokens/)

- All tokens follow DTCG format: `{ "$value": "...", "$type": "..." }`
- Token layers: primitive -> semantic -> component (strict hierarchy)
- Primitive tokens: raw values only (hex, rem). No layer prefix in key names.
- Semantic tokens reference primitives: `{color.blue.600}`, `{spacing.4}`
- Component tokens reference semantics: `{primary}`, `{border}`
- Never skip layers (component must not directly reference primitive)
- Semantic color tokens include dark mode via `$extensions.dark.$value`
- Color values: hex lowercase (#rrggbb). OKLCH conversion happens at CSS transform level.
- Spacing uses Tailwind numeric scale (0, 0.5, 1, 2, 4, 8...)
- CSS output uses flat role names: --primary, --border, --radius (not layered prefixes)
- After ANY token change, run `pnpm build:tokens` to regenerate
- Generated files in generated/ are auto-created; NEVER edit manually
