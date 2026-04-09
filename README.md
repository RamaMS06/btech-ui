# Btech Design System

A multi-framework design system monorepo with design tokens as the single source of truth.

## Architecture

```
btech-ui/
├── tokens/                  Source of truth (DTCG JSON + Style Dictionary)
│   ├── src/                 Token source files (edited by humans)
│   │   ├── primitive/       Raw values: colors, spacing, radius, shadow, z-index, motion
│   │   ├── semantic/        Intent + dark mode: primary, border, muted, destructive...
│   │   └── component/       Component-specific: button, input, card
│   ├── config/              Style Dictionary transforms + formats
│   └── generated/           Auto-generated outputs (DO NOT EDIT)
│       ├── web/             CSS, SCSS, JS/TS (any web framework)
│       ├── flutter/         Dart package: btech_tokens (AppTokens class)
│       └── figma/           Tokens Studio compatible JSON
│
├── ui/                      Framework component libraries
│   ├── vue/                 @btech/vue-ui (Vue 3 Composition API)
│   ├── react/               @btech/react-ui (React 18 + forwardRef)
│   ├── flutter/             btech_ui (Flutter widgets + BtechTheme)
│   └── shared/              @btech/shared (TypeScript types)
│
├── apps/                    Internal testing (DS team only)
│   ├── playground-vue/      Vue test app
│   ├── playground-react/    React test app
│   ├── playground-flutter/  Flutter test app
│   ├── storybook-vue/       Vue component docs
│   └── storybook-react/     React component docs
│
├── instructions/            Design spec (source of truth for token values)
└── .claude/                 AI automation rules + skills
```

## Token Pipeline

Design tokens flow from JSON source through Style Dictionary to platform-specific outputs:

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         TOKEN PIPELINE                                  │
│                                                                         │
│  ┌──────────────┐                          ┌──────────────────────┐    │
│  │  Figma       │  Tokens Studio sync      │  tokens/generated/   │    │
│  │  Variables   │─────────────────────┐    │                      │    │
│  └──────────────┘                     │    │  web/                │    │
│                                       ▼    │  ├── tokens.css      │──▶ Vue / React / Any Web
│  ┌──────────────┐   Style Dictionary  ┌──┐ │  ├── tokens.scss     │    │
│  │  tokens/src/ │──────────────────▶│SD│─▶│  ├── tokens.mjs      │    │
│  │              │   pnpm build:tokens └──┘ │  └── tokens.d.ts     │    │
│  │  primitive/  │                          │                      │    │
│  │  semantic/   │                          │  flutter/            │    │
│  │  component/  │                          │  └── btech_tokens/   │──▶ Flutter
│  └──────────────┘                          │     (Dart package)   │    │
│       ▲                                    │                      │    │
│       │ Developer edits                    │  figma/              │    │
│       │ JSON source files                  │  └── figma-tokens.json──▶ Tokens Studio
│                                            └──────────────────────┘    │
└─────────────────────────────────────────────────────────────────────────┘
```

## 3-Layer Token Architecture

Tokens are organized in 3 strict layers. Components never reference primitives directly.

```
┌──────────────────┐    ┌──────────────────┐    ┌──────────────────┐
│ PRIMITIVE         │    │ SEMANTIC          │    │ COMPONENT        │
│ "What is it?"     │    │ "What does it     │    │ "Where is it     │
│                   │    │  mean?"           │    │  used?"          │
│ color.blue.600    │───▶│ primary           │───▶│ button.primary   │
│ = #2563eb         │    │ = {color.blue.600}│    │ .background      │
│                   │    │                   │    │ = {primary}      │
│ spacing.4         │    │ + dark mode via   │    │                  │
│ = 1rem            │    │ $extensions.dark  │    │ input.border     │
│                   │    │                   │    │ = {border}       │
│ radius.base       │    │ border            │    │                  │
│ = 0.625rem        │    │ = {color.neutral  │    │ card.background  │
│                   │    │    .200}          │    │ = {card}         │
└──────────────────┘    └──────────────────┘    └──────────────────┘

Rules:
  ✗ Components NEVER reference primitives directly
  ✗ Never skip layers
  ✗ Never edit generated/ files manually
  ✓ Semantic layer handles dark mode + rebrand
  ✓ Change 1 JSON value → all platforms update
```

## Dark Mode

Dark mode is built into the semantic token layer. CSS toggles via `.dark` class.

```
JSON Source                       CSS Output                    Runtime
┌─────────────────────┐          ┌──────────────────┐         ┌─────────┐
│ "primary": {        │  build   │ :root {          │         │ Light   │
│   $value: light     │────────▶│   --primary: ... │────────▶│(default)│
│   $extensions: {    │          │ }                │         └─────────┘
│     dark: {         │────────▶│ .dark {          │────────▶┌─────────┐
│       $value: dark  │          │   --primary: ... │         │ Dark    │
│     }               │          │ }                │         └─────────┘
│ }                   │          └──────────────────┘
└─────────────────────┘          Toggle: document.documentElement
                                         .classList.toggle('dark')
```

## CSS Variable Naming

CSS output uses flat, role-based names following the shadcn/ui convention:

```
Surface       --background        --card              --popover
Brand         --primary           --secondary         --accent
State         --muted             --muted-foreground
Feedback      --destructive       --success           --warning       --info
Form          --border            --input             --ring
Layout        --radius            --shadow-md         --z-modal
Motion        --duration-normal   --ease-default
Typography    --font-sans         --font-mono
```

Each role has a `*-foreground` pair (e.g., `--primary` + `--primary-foreground`).

## Developer Consumption

### Web (Vue / React / Any Framework)

**Inside this monorepo:**
```json
{ "dependencies": { "@btech/tokens": "workspace:*" } }
```

**External project (via GitHub Packages):**
```ini
# .npmrc
@btech:registry=https://npm.pkg.github.com
//npm.pkg.github.com/:_authToken=${GITHUB_TOKEN}
```
```json
{ "dependencies": { "@btech/tokens": "^0.2.0" } }
```

**Usage:**
```ts
// Import CSS once — all custom properties available globally
import '@btech/tokens/css'

// Use in any component (framework-agnostic)
.my-button {
  background: var(--primary);
  color: var(--primary-foreground);
  border: 1px solid var(--border);
  border-radius: var(--radius);
}

// Dark mode: just toggle the class
document.documentElement.classList.toggle('dark')
// All vars switch automatically — zero component changes

// Programmatic access (JS/TS)
import { tokens } from '@btech/tokens'
tokens.primary // '#0f172a'
```

### Flutter

```yaml
# pubspec.yaml — tokens only
dependencies:
  btech_tokens:
    git:
      url: https://github.com/RamaMS06/btech-ui.git
      path: tokens/generated/flutter

# OR full UI library (includes tokens)
dependencies:
  btech_ui:
    git:
      url: https://github.com/RamaMS06/btech-ui.git
      path: ui/flutter
```

**Usage:**
```dart
import 'package:btech_ui/btech_ui.dart';

MaterialApp(
  theme: BtechTheme.light(),
  darkTheme: BtechTheme.dark(),
  home: BtechButton(
    label: 'Submit',
    variant: BtechButtonVariant.primary,
    onPressed: () {},
  ),
)

// Direct token access
AppTokens.primary         // Color(0xFF0F172A)
AppTokens.spacing4        // 16.0
AppTokens.radiusMd        // 8.0
AppTokens.fontSizeSm      // 14.0
```

### Raw JSON (Custom Build)

For platforms not covered (iOS, Android, Python), get raw DTCG JSON and run your own Style Dictionary:

```js
// your-style-dictionary.config.js
export default {
  source: ['node_modules/@btech/tokens/src/**/*.json'],
  platforms: {
    ios:     { /* Swift config */ },
    android: { /* Kotlin config */ },
  }
}
```

## When Are Tokens Regenerated?

```
┌─────────────────────────────────────────────────────────────────────────┐
│                                                                         │
│  Scenario 1: Designer changes Figma                                     │
│  Figma → Tokens Studio → PR → merge → CI runs build:tokens → done     │
│                                                                         │
│  Scenario 2: Developer edits JSON                                       │
│  Edit tokens/src/*.json → pnpm build:tokens → commit generated/ → PR  │
│                                                                         │
│  Platform developers (Vue/React/Flutter) NEVER run the build.          │
│  They install the package → tokens are already there.                  │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

## Why Tokens?

```
WITHOUT tokens                        WITH tokens
─────────────────                     ───────────────
"Change primary to green"             "Change primary to green"

Vue dev:     12 files changed         1 JSON line changed:
React dev:   8 files changed          primary: {color.green.600}
Flutter dev: 15 files changed
                                      Style Dictionary rebuilds
Total: 35+ files                      Vue:     0 files changed
Risk: someone misses one              React:   0 files changed
Colors drift between platforms        Flutter: 0 files changed

        ❌                             Total: 1 file. All platforms. ✅
```

## Package Distribution

| Package | Registry | Install |
|---------|----------|---------|
| `@btech/tokens` | GitHub Packages | `npm install @btech/tokens` |
| `@btech/vue-ui` | GitHub Packages | `npm install @btech/vue-ui` |
| `@btech/react-ui` | GitHub Packages | `npm install @btech/react-ui` |
| `btech_tokens` | Git dependency | `path:` in pubspec.yaml |
| `btech_ui` | Git dependency | `path:` in pubspec.yaml |

## Commands

```bash
pnpm install              # Install all dependencies
pnpm build                # Build everything (tokens → UI packages)
pnpm build:tokens         # Build tokens only (Style Dictionary)
pnpm test                 # Run all web tests
pnpm flutter:test         # Run Flutter tests
pnpm flutter:pub-get      # Install Flutter dependencies
pnpm flutter:golden-update # Update golden test baselines
pnpm changeset            # Create a changeset for versioning
```

## CI/CD

| Workflow | Trigger | What it does |
|----------|---------|-------------|
| **CI** | PR + push to main | Install → build tokens → build UI → test |
| **Release** | Push to main (after CI) | Build → publish to GitHub Packages |
| **Flutter CI** | PR touching `ui/flutter/` or `tokens/` | Build tokens → flutter pub get → analyze → test |

## Tech Stack

| Area | Technology |
|------|-----------|
| Monorepo | pnpm workspaces |
| Token format | W3C DTCG (`$value`, `$type`) |
| Token build | Style Dictionary v4 |
| Color space | OKLCH (CSS), hex (JSON source) |
| Vue | Vue 3, Composition API, Vite |
| React | React 18, forwardRef, tsup |
| Flutter | Dart 3.x, AppTokens, golden tests |
| Testing | Vitest (web), flutter_test (mobile) |
| Versioning | Changesets (linked) |
| Registry | GitHub Packages (private npm) |
| CI/CD | GitHub Actions |
