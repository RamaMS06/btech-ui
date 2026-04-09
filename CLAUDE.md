# CLAUDE.md - Btech Design System

## Project Overview
Btech is a multi-framework design system monorepo. Design tokens are the single
source of truth, authored as DTCG JSON (OKLCH color space, dark mode support)
and compiled via Style Dictionary to platform-specific outputs.

## Repository Structure
```
tokens/                  ← Source of truth
  src/                   ← DTCG JSON (primitive/semantic/component layers)
  config/                ← Style Dictionary config + custom formats
  generated/             ← Auto-generated outputs — DO NOT edit manually
    web/tokens.css       ← CSS custom properties (:root + .dark)
    web/tokens.scss      ← SCSS variables
    web/tokens.mjs       ← JS/TS provider object
    flutter/tokens.dart  ← Dart class (AppTokens)
    figma/               ← Tokens Studio compatible JSON

ui/
  vue/                   ← @btech/vue-ui (Vue 3)
  react/                 ← @btech/react-ui (React 18)
  flutter/               ← btech_ui (Flutter, NOT managed by pnpm)
  shared/                ← @btech/shared (shared TypeScript types)

apps/                    ← Internal testing (DS team only)
  playground-vue/  playground-react/  playground-flutter/
  storybook-vue/   storybook-react/

.claude/                 ← Claude-oriented automation
  rules/                 ← Coding conventions
  skills/                ← Reusable workflows
```

## Token Architecture
- **Format**: W3C DTCG ($value, $type, $description)
- **Color space**: OKLCH in CSS output, hex in JSON source
- **Dark mode**: $extensions.dark in semantic JSON → :root + .dark CSS
- **3 layers**: primitive → semantic → component
- **Naming**: flat role-based in CSS output (--primary, --border, --radius)
- **Package ships both**: raw JSON (`@btech/tokens/json`) + pre-built (`@btech/tokens/css`)

## Token Consumption
```
Web:     import '@btech/tokens/css'  →  var(--primary), var(--border)
JS/TS:   import { tokens } from '@btech/tokens'  →  tokens.primary
Flutter: import 'package:btech_ui/btech_ui.dart'  →  AppTokens.primary
Raw JSON: import from '@btech/tokens/json'  →  run your own Style Dictionary
```

## Key Commands
```bash
pnpm install              # Install all dependencies
pnpm build                # Build everything (tokens first, then UI packages)
pnpm build:tokens         # Build only tokens (Style Dictionary)
pnpm flutter:pub-get      # Install Flutter dependencies (resolves btech_tokens path dep)
pnpm test                 # Run all tests
pnpm lint                 # Lint all packages
pnpm flutter:test         # Run Flutter tests
pnpm flutter:golden-update # Update golden reference screenshots
pnpm changeset            # Create a changeset for versioning
```

## Token Conventions
- Primitives: raw values (hex, rem), no context. Never used directly in components.
- Semantics: role-based names (primary, border, muted), reference primitives.
  Dark mode via $extensions.dark.$value.
- Components: map to specific UI (button.primary.background), reference semantics.
- NEVER skip layers. NEVER hardcode values. NEVER edit generated/ manually.

## Component Conventions
- Vue: prefix `Btech`, Composition API, `<script setup lang="ts">`
- React: `forwardRef` + `displayName`, TypeScript props
- Flutter: prefix `Btech`, `AppTokens` class, prefer StatelessWidget
- CSS uses flat role vars: var(--primary), var(--radius), var(--border)

## Flutter Notes
- Flutter package in `ui/flutter/` (outside pnpm workspace)
- Dart tokens: `btech_tokens` package at `tokens/generated/flutter/` (auto-generated)
- `ui/flutter` depends on `btech_tokens` via path dependency — no sync script needed
- `AppTokens` class has all token constants. Never edit generated files manually.
- Golden tests in `test/goldens/` for visual regression
