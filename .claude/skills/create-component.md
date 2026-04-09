# Skill: Create Component

## Trigger
User says "create component <Name>" or "scaffold <Name>"

## Steps

1. **Ask** for: component name, variants, props needed
2. **Create token file**: `tokens/src/component/<name>.json`
   - Define variant colors, spacing, typography tokens referencing semantic layer
   - Use flat semantic names: `{primary}`, `{border}`, `{muted}`, etc.
3. **Run** `pnpm build:tokens` to regenerate all outputs
4. **Scaffold Vue** in `ui/vue/src/components/Btech<Name>/`
   - Btech<Name>.vue (SFC with `<script setup lang="ts">`)
   - Btech<Name>.stories.ts
   - Btech<Name>.test.ts
   - Btech<Name>.figma.ts (Code Connect stub)
   - index.ts (named re-export)
   - CSS uses flat vars: var(--primary), var(--border), var(--radius)
5. **Scaffold React** in `ui/react/src/components/<Name>/`
   - <Name>.tsx (forwardRef + displayName)
   - <Name>.stories.tsx
   - <Name>.test.tsx
   - <Name>.figma.tsx
   - index.ts
6. **Scaffold Flutter** in `ui/flutter/lib/src/components/`
   - btech_<name>.dart (StatelessWidget using AppTokens)
   - Add golden test: `test/components/btech_<name>_golden_test.dart`
   - Add widget test: `test/components/btech_<name>_test.dart`
7. **Update barrel exports** in each package's index file
   - Flutter picks up token changes automatically via `btech_tokens` path dependency
