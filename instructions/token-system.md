# Design Token System

*Covers: Token Architecture, Format, 3-Layer Pattern, Cross-Platform Usage, Styling Strategy, Naming Convention*

---

## What is a Design Token?

A design token is the **smallest unit of a design decision** stored as data, not as platform-specific code. Instead of hardcoding a value like `#2563eb` directly inside a component, that value is stored in a named token such as `color.interactive.default` — which can then be consumed consistently by web, mobile, and Figma.

```
Without tokens:  button { background: #2563eb }  ← hardcoded, duplicated across every platform
With tokens:     button.primary.background = color.interactive.default = #2563eb
                                                   ↑ single source, all platforms use this
```

### Why It Matters

| Problem | Without Tokens | With Tokens |
|---|---|---|
| Brand color change | Update every file across every platform | Change 1 line in the semantic layer |
| Dark mode | Add conditions inside every component | Swap alias values in the semantic layer |
| New platform | Manually copy-paste all values | Auto-generate from a single source |
| Designer updates a color | Notify every developer individually | Auto-sync: Figma → JSON → all platforms |
| Consistency | Hard to maintain, prone to drift | Guaranteed — single source of truth |

---

## Token Storage: Everything is JSON

All tokens are stored as **plain JSON files** inside `src/`. No code, no logic, no framework — just data.

```json
{
  "color": {
    "blue": {
      "600": { "$value": "#2563eb", "$type": "color" }
    }
  }
}
```

This is a plain text file. Any text editor can open it, any platform can read it. The JSON itself does nothing — **Style Dictionary** is what reads it and transforms it into platform-specific output.

---

## Format: W3C Design Token Community Group (DTCG)

BTech DS uses the **W3C DTCG** format — the industry standard compatible with Style Dictionary, Tokens Studio, and Figma Variables.

### Anatomy of a Token

```json
{
  "token-name": {
    "$value": "the actual value or a reference to another token",
    "$type": "the data type of the token",
    "$description": "explains when and how to use this token"
  }
}
```

### Available Properties

| Property | Required | Description |
|---|---|---|
| `$value` | ✅ | Actual value (`#2563eb`) or a reference (`{color.blue.600}`) |
| `$type` | ✅ | Data type — see full list below |
| `$description` | ✗ | Documents the intended usage of the token |
| `$extensions` | ✗ | Platform-specific metadata (Tokens Studio, Style Dictionary) |

### Token Types (`$type`)

| Type | Example Value | Used For |
|---|---|---|
| `color` | `"#2563eb"`, `"oklch(0.5 0.2 250)"` | Any color value |
| `dimension` | `"16px"`, `"1rem"` | Sizes, spacing, radius |
| `typography` | Object (fontFamily, fontSize, etc.) | Composite text style |
| `fontFamily` | `["Inter", "sans-serif"]` | Font stack |
| `fontWeight` | `600` | Font thickness |
| `duration` | `"200ms"` | Animation duration |
| `cubicBezier` | `"cubic-bezier(0.4, 0, 0.2, 1)"` | Animation easing |
| `shadow` | Object (offsetX, offsetY, blur, color) | Drop shadow / elevation |
| `number` | `1.5` | Line height, opacity, ratio |
| `boolean` | `true` / `false` | Binary conditions |

### Referencing Other Tokens

Use curly braces `{...}` to reference another token:

```json
{
  "color": {
    "blue": {
      "600": { "$value": "#2563eb", "$type": "color" }
    },
    "interactive": {
      "default": { "$value": "{color.blue.600}", "$type": "color" }
    }
  },
  "button": {
    "primary": {
      "background": { "$value": "{color.interactive.default}", "$type": "color" }
    }
  }
}
```

Style Dictionary resolves the full chain automatically:

```
button.primary.background
  → {color.interactive.default}
    → {color.blue.600}
      → #2563eb  ✅
```

---

## 3-Layer Architecture

BTech DS uses a 3-layer architecture to clearly separate **values**, **meaning**, and **usage**.

```
Layer 1: Primitive   →   Layer 2: Semantic   →   Layer 3: Component
"What is the value?"      "What does it mean?"     "Where is it used?"
```

| | Primitive | Semantic | Component |
|---|---|---|---|
| **Contains** | Raw values | Aliases | Aliases |
| **Named by** | Scale position | Intent / meaning | UI location |
| **Changes when** | New colors added | Rebrand / dark mode | Component redesign |
| **Example** | `color.blue.600` | `color.interactive.default` | `button.primary.background` |
| **Who edits** | Rarely changes | Designer / rebrand | Designer + Developer |

### Layer 1 — Primitive

Raw values. No context. No meaning. Just numbers and colors.

```json
{
  "color": {
    "blue": {
      "500": { "$value": "#3b82f6", "$type": "color" },
      "600": { "$value": "#2563eb", "$type": "color" },
      "700": { "$value": "#1d4ed8", "$type": "color" }
    },
    "neutral": {
      "0":   { "$value": "#ffffff", "$type": "color" },
      "900": { "$value": "#0f172a", "$type": "color" }
    }
  },
  "spacing": {
    "1": { "$value": "4px",  "$type": "dimension" },
    "2": { "$value": "8px",  "$type": "dimension" },
    "4": { "$value": "16px", "$type": "dimension" }
  },
  "radius": {
    "sm":   { "$value": "4px",    "$type": "dimension" },
    "md":   { "$value": "6px",    "$type": "dimension" },
    "full": { "$value": "9999px", "$type": "dimension" }
  }
}
```

!!! warning "Primitive Rule"
    Primitive tokens **must never** be used directly inside components. Always access them through semantic or component tokens.

### Layer 2 — Semantic

Assigns names and intent to primitives. Answers the question **"what is this for?"**. Dark mode and rebranding happen at this layer.

```json
{
  "color": {
    "background": {
      "default": { "$value": "{color.neutral.0}",    "$type": "color", "$description": "Primary page surface" },
      "subtle":   { "$value": "{color.neutral.50}",  "$type": "color", "$description": "Secondary surface, cards, sidebars" },
      "muted":    { "$value": "{color.neutral.100}", "$type": "color", "$description": "Disabled or inactive surface" }
    },
    "text": {
      "default":  { "$value": "{color.neutral.900}", "$type": "color" },
      "subtle":   { "$value": "{color.neutral.500}", "$type": "color" },
      "disabled": { "$value": "{color.neutral.300}", "$type": "color" },
      "inverse":  { "$value": "{color.neutral.0}",   "$type": "color" }
    },
    "border": {
      "default": { "$value": "{color.neutral.200}", "$type": "color" },
      "focus":   { "$value": "{color.blue.500}",    "$type": "color" }
    },
    "interactive": {
      "default":  { "$value": "{color.blue.600}",    "$type": "color" },
      "hover":    { "$value": "{color.blue.700}",    "$type": "color" },
      "disabled": { "$value": "{color.neutral.300}", "$type": "color" }
    },
    "feedback": {
      "error":   { "$value": "{color.red.500}",    "$type": "color" },
      "success": { "$value": "{color.green.500}",  "$type": "color" },
      "warning": { "$value": "{color.yellow.500}", "$type": "color" },
      "info":    { "$value": "{color.blue.500}",   "$type": "color" }
    }
  }
}
```

### Layer 3 — Component

The most specific layer. Maps tokens directly to a specific UI component. This is what developers across all platforms consume directly.

```json
{
  "button": {
    "primary": {
      "background":         { "$value": "{color.interactive.default}", "$type": "color" },
      "backgroundHover":    { "$value": "{color.interactive.hover}",   "$type": "color" },
      "backgroundDisabled": { "$value": "{color.interactive.disabled}","$type": "color" },
      "text":               { "$value": "{color.text.inverse}",        "$type": "color" },
      "radius":             { "$value": "{radius.md}",                 "$type": "dimension" },
      "paddingX":           { "$value": "{spacing.4}",                 "$type": "dimension" },
      "paddingY":           { "$value": "{spacing.2}",                 "$type": "dimension" }
    },
    "ghost": {
      "background":         { "$value": "transparent",                 "$type": "color" },
      "backgroundHover":    { "$value": "{color.background.subtle}",   "$type": "color" },
      "text":               { "$value": "{color.interactive.default}", "$type": "color" }
    }
  },
  "input": {
    "background":  { "$value": "{color.background.default}", "$type": "color" },
    "border":      { "$value": "{color.border.default}",     "$type": "color" },
    "borderFocus": { "$value": "{color.border.focus}",       "$type": "color" },
    "text":        { "$value": "{color.text.default}",       "$type": "color" },
    "placeholder": { "$value": "{color.text.subtle}",        "$type": "color" },
    "radius":      { "$value": "{radius.md}",                "$type": "dimension" }
  }
}
```

---

## Naming Convention

Use **dot notation** with the order: `category.context.property.state`

```
color.interactive.default     ✅
color.button-primary-bg       ❌ (too specific for the semantic layer)
btnPrimaryBg                  ❌ (camelCase, inconsistent)
```

### Naming Guide by Layer

| Layer | Pattern | Example |
|---|---|---|
| Primitive | `category.scale.step` | `color.blue.600`, `spacing.4` |
| Semantic | `category.intent.state` | `color.interactive.hover`, `color.text.subtle` |
| Component | `component.variant.property` | `button.primary.background`, `input.borderFocus` |

### Common States

| State | When to Use |
|---|---|
| `default` | Normal / rest condition |
| `hover` | Cursor is over the element |
| `active` | Element is being pressed or is currently active |
| `focus` | Element has keyboard focus |
| `disabled` | Element cannot be interacted with |
| `inverse` | Opposite of default (e.g. white text on dark background) |

---

## File Structure

```
packages/tokens/
├── src/                       ← Edit here — JSON source files
│   ├── primitives/
│   │   ├── color.json         ← All raw color values
│   │   ├── spacing.json       ← Spacing scale (4px base)
│   │   ├── typography.json    ← Font family, size, weight, line height
│   │   ├── radius.json        ← Border radius scale
│   │   ├── shadow.json        ← Elevation / shadow scale
│   │   └── motion.json        ← Duration and easing values
│   ├── semantic/
│   │   ├── color.json         ← Semantic color aliases + dark mode
│   │   ├── spacing.json       ← Semantic spacing aliases
│   │   └── typography.json    ← Composite typography tokens
│   └── component/
│       ├── button.json
│       ├── input.json
│       ├── card.json
│       └── ...
├── generated/                 ← Auto-generated — DO NOT edit manually
│   ├── web/
│   │   ├── tokens.scss        ← SCSS variables (used by UI components)
│   │   └── tokens.js          ← JS / TS object
│   ├── flutter/
│   │   └── tokens.dart        ← Dart constants class
│   ├── ios/
│   │   └── tokens.swift       ← Swift constants
│   ├── android/
│   │   └── colors.xml         ← Android resource XML
│   └── python/
│       └── tokens.py          ← Python constants
├── style-dictionary.config.js ← Transform rules per platform
└── package.json
```

!!! info "Why `generated/` not `dist/`?"
    `dist/` implies a build cache that is often gitignored. `generated/` makes it explicit that these files are auto-generated by Style Dictionary and should never be edited manually.

---

## Styling Strategy

BTech DS uses a **clear boundary** between styling approaches:

```
packages/ui/          ← SCSS territory
├── src/
│   ├── button/
│   │   ├── Button.vue
│   │   └── button.scss    ← uses $button-primary-background

packages/tokens/      ← SCSS territory
└── generated/
    └── web/
        └── tokens.scss    ← $color-interactive-default: #2563eb

apps/docs/            ← Tailwind territory
└── pages/
    └── index.vue     ← class="flex gap-4 p-8"  (layout only)
```

### Rule of Thumb

| What | Use |
|---|---|
| Component styling | SCSS |
| Design token variables (web output) | SCSS |
| Docs site layout & typography | Tailwind |
| Component logic | Vue `<script setup>` |

### Why This Split?

- **SCSS for components** — gives full control with nesting, mixins, and `&` syntax. Components stay framework-agnostic and consistent.
- **Tailwind for docs** — docs layout is built fast with utility classes. Docs pages are not reusable components — they are one-off layouts.

### Component Styling with SCSS Tokens

```vue
<!-- packages/ui/src/button/Button.vue -->
<template>
  <button :class="['btn', `btn--${variant}`]">
    <slot />
  </button>
</template>

<style lang="scss">
@import '@btech-ds/tokens/generated/web/tokens.scss';

.btn {
  border-radius: $button-primary-radius;
  padding: $button-primary-padding-y $button-primary-padding-x;
  font-weight: 500;
  cursor: pointer;

  &--primary {
    background: $button-primary-background;
    color: $button-primary-text;

    &:hover   { background: $button-primary-background-hover; }
    &:disabled { background: $button-primary-background-disabled; }
  }

  &--ghost {
    background: $button-ghost-background;
    color: $button-ghost-text;

    &:hover { background: $button-ghost-background-hover; }
  }
}
</style>
```

### Dark Mode with SCSS

Since SCSS variables are compile-time only, dark mode requires a `.dark` class toggle on `<html>`:

```scss
// generated/web/tokens.scss (auto-generated)
$color-background-default:      #ffffff;
$color-background-default-dark: #0f172a;
$button-primary-background:      #2563eb;
$button-primary-background-dark: #1d4ed8;

// button.scss
.btn--primary {
  background: $button-primary-background;

  .dark & {
    background: $button-primary-background-dark;
  }
}
```

Toggle dark mode in JavaScript:

```javascript
// toggle dark mode
document.documentElement.classList.toggle('dark')
```

---

## Complete Flow

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         DESIGN TOKEN FLOW                               │
└─────────────────────────────────────────────────────────────────────────┘

  DESIGNER                    TOKEN REPO                    ALL PLATFORMS
  ─────────                   ──────────                    ─────────────

  ┌──────────┐                ┌──────────────────────┐
  │  Figma   │                │  packages/tokens/    │
  │Variables │ ──sync via──▶  │  src/                │
  └──────────┘  Tokens Studio │  ├── primitives/     │
                              │  │   └── color.json  │
                              │  ├── semantic/        │
                              │  │   └── color.json  │
                              │  └── component/       │
                              │      └── button.json  │
                              └──────────┬───────────┘
                                         │
                                         │ PR merge to main
                                         │
                              ┌──────────▼───────────┐
                              │   GitHub Actions      │
                              │   CI/CD               │
                              │                       │
                              │  npx style-dictionary │
                              │        build          │
                              └──────────┬───────────┘
                                         │
                                         │ auto-generate
                                         │
                              ┌──────────▼───────────┐
                              │  generated/           │
                              │  ├── web/             │──────▶ Web Developer
                              │  │   ├── tokens.scss  │       @import tokens.scss
                              │  │   └── tokens.js    │       $button-primary-bg
                              │  │                    │
                              │  ├── flutter/         │──────▶ Flutter Developer
                              │  │   └── tokens.dart  │       flutter pub get
                              │  │                    │       AppTokens.buttonPrimaryBg
                              │  ├── ios/             │──────▶ iOS Developer
                              │  │   └── tokens.swift │       Swift Package / copy file
                              │  │                    │       AppTokens.Button.primaryBg
                              │  ├── android/         │──────▶ Android Developer
                              │  │   └── colors.xml   │       copy to res/values/
                              │  │                    │       @color/button_primary_bg
                              │  └── python/          │──────▶ Python Developer
                              │      └── tokens.py    │       AppTokens.BUTTON_PRIMARY_BG
                              └──────────────────────┘
```

!!! note "Who runs `npx style-dictionary build`?"
    Only **CI/CD** (GitHub Actions) runs this command — automatically on every PR merge to main. Individual platform developers never need to run it. They simply pull the latest `generated/` files or update their package dependency.

---

## Per-Role Responsibilities

| Role | Tools Used | What They Do |
|---|---|---|
| Designer | Figma, Tokens Studio | Edit variables in Figma → sync to GitHub |
| Token Maintainer | Node.js, JSON editor | Review PRs, maintain `src/` JSON files |
| CI/CD | GitHub Actions | Runs `style-dictionary build` on every merge |
| Web Developer | SCSS, Vue/React | `@import tokens.scss`, use `$token-name` |
| Flutter Developer | Dart, Flutter | `flutter pub get`, use `AppTokens.xxx` |
| iOS Developer | Swift, Xcode | Add Swift Package, use `AppTokens.xxx` |
| Android Developer | Kotlin, Gradle | Copy `colors.xml`, use `@color/xxx` |
| Python Developer | pip | `pip install` or copy, use `AppTokens.XXX` |

---

## Cross-Platform Output

From a single token source, Style Dictionary auto-generates output for every platform. Developers receive values already resolved — no need to trace references manually.

=== "Web (SCSS)"
    ```scss
    // generated/web/tokens.scss — DO NOT EDIT
    // Auto-generated by Style Dictionary

    // Primitives
    $color-blue-600: #2563eb;
    $color-neutral-0: #ffffff;

    // Semantic
    $color-interactive-default: #2563eb;
    $color-interactive-hover: #1d4ed8;
    $color-text-default: #0f172a;
    $color-text-inverse: #ffffff;

    // Component — Button
    $button-primary-background: #2563eb;
    $button-primary-background-hover: #1d4ed8;
    $button-primary-text: #ffffff;
    $button-primary-radius: 6px;
    $button-primary-padding-x: 16px;
    $button-primary-padding-y: 8px;

    // Component — Input
    $input-border: #e2e8f0;
    $input-border-focus: #3b82f6;
    $input-text: #0f172a;
    $input-placeholder: #64748b;
    $input-radius: 6px;
    ```

=== "Web (JS / TS)"
    ```typescript
    // generated/web/tokens.ts — DO NOT EDIT
    export const tokens = {
      color: {
        interactive: { default: '#2563eb', hover: '#1d4ed8' },
        text: { default: '#0f172a', subtle: '#64748b' },
      },
      button: {
        primary: {
          background: '#2563eb',
          backgroundHover: '#1d4ed8',
          radius: '6px',
          paddingX: '16px',
        }
      }
    } as const
    ```

=== "Flutter (Dart)"
    ```dart
    // generated/flutter/tokens.dart — DO NOT EDIT
    // Auto-generated by Style Dictionary

    import 'package:flutter/material.dart';

    class AppTokens {
      AppTokens._();

      // Color — Interactive
      static const Color colorInteractiveDefault = Color(0xFF2563EB);
      static const Color colorInteractiveHover   = Color(0xFF1D4ED8);

      // Color — Text
      static const Color colorTextDefault = Color(0xFF0F172A);
      static const Color colorTextInverse = Color(0xFFFFFFFF);

      // Button — Primary
      static const Color  buttonPrimaryBackground      = Color(0xFF2563EB);
      static const Color  buttonPrimaryBackgroundHover = Color(0xFF1D4ED8);
      static const Color  buttonPrimaryText            = Color(0xFFFFFFFF);
      static const double buttonPrimaryRadius          = 6.0;
      static const double buttonPrimaryPaddingX        = 16.0;
      static const double buttonPrimaryPaddingY        = 8.0;
    }
    ```

=== "iOS (Swift)"
    ```swift
    // generated/ios/tokens.swift — DO NOT EDIT
    public enum AppTokens {
      public enum Color {
        public static let interactiveDefault = UIColor(hex: "#2563eb")
        public static let interactiveHover   = UIColor(hex: "#1d4ed8")
        public static let textDefault        = UIColor(hex: "#0f172a")
      }
      public enum Button {
        public static let primaryBackground      = UIColor(hex: "#2563eb")
        public static let primaryBackgroundHover = UIColor(hex: "#1d4ed8")
        public static let primaryRadius: CGFloat = 6
        public static let primaryPaddingX: CGFloat = 16
      }
    }
    ```

=== "Android (Kotlin / XML)"
    ```xml
    <!-- generated/android/colors.xml — DO NOT EDIT -->
    <resources>
      <color name="color_interactive_default">#2563EB</color>
      <color name="color_interactive_hover">#1D4ED8</color>
      <color name="color_text_default">#0F172A</color>
      <color name="button_primary_background">#2563EB</color>
    </resources>
    ```
    ```kotlin
    // generated/android/AppTokens.kt — DO NOT EDIT
    object AppTokens {
      val buttonPrimaryRadius   = 6.dp
      val buttonPrimaryPaddingX = 16.dp
      val buttonPrimaryPaddingY = 8.dp
    }
    ```

=== "Python"
    ```python
    # generated/python/tokens.py — DO NOT EDIT
    # Auto-generated by Style Dictionary

    class AppTokens:
        # Color — Interactive
        COLOR_INTERACTIVE_DEFAULT = "#2563eb"
        COLOR_INTERACTIVE_HOVER   = "#1d4ed8"

        # Color — Text
        COLOR_TEXT_DEFAULT = "#0f172a"
        COLOR_TEXT_INVERSE = "#ffffff"

        # Button — Primary
        BUTTON_PRIMARY_BACKGROUND       = "#2563eb"
        BUTTON_PRIMARY_BACKGROUND_HOVER = "#1d4ed8"
        BUTTON_PRIMARY_RADIUS           = "6px"
        BUTTON_PRIMARY_PADDING_X        = "16px"
    ```

---

## Flutter Developer Usage Example

This shows the end-to-end experience for a Flutter developer consuming tokens.

### Setup (Once)

```yaml
# pubspec.yaml
dependencies:
  btech_tokens:
    git:
      url: https://github.com/btech/btech-ds
      path: packages/tokens/generated/flutter
```

```bash
flutter pub get
```

### Usage in Widgets

```dart
import 'package:btech_tokens/tokens.dart';

// Button
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: AppTokens.buttonPrimaryBackground,
    foregroundColor: AppTokens.buttonPrimaryText,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppTokens.buttonPrimaryRadius),
    ),
    padding: EdgeInsets.symmetric(
      horizontal: AppTokens.buttonPrimaryPaddingX,
      vertical: AppTokens.buttonPrimaryPaddingY,
    ),
  ),
  onPressed: () {},
  child: Text('Submit'),
)

// TextField
TextField(
  decoration: InputDecoration(
    hintStyle: TextStyle(color: AppTokens.inputPlaceholder),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppTokens.inputBorder),
      borderRadius: BorderRadius.circular(AppTokens.inputRadius),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppTokens.inputBorderFocus),
      borderRadius: BorderRadius.circular(AppTokens.inputRadius),
    ),
  ),
)
```

### When Tokens Update

```
Designer changes primary color in Figma
      ↓
CI/CD auto-regenerates tokens.dart
      ↓
Flutter developer runs: flutter pub get
      ↓
All widgets using AppTokens.buttonPrimaryBackground
update automatically — no component code changed
```

---

## Figma Integration

Design tokens are synchronized bidirectionally with Figma using the **Tokens Studio** plugin.

```
Figma Variables ←──────────────────────────── Push tokens
      │                                              ↑
      │ Pull / Export                                │
      ↓                                              │
packages/tokens/src/*.json ──── Style Dictionary ───┘
                                       │
                                       ↓
                            generated/ (all platforms)
```

### Mapping to Figma Variables

| Token Type | Figma Equivalent |
|---|---|
| `color` | Color Variables |
| `dimension` (spacing, radius) | Number Variables |
| `number` (line height, opacity) | Number Variables |
| `boolean` | Boolean Variables |
| `string` | String Variables |
| `typography` (composite) | Text Styles |
| `shadow` (composite) | Effect Styles |

### Setup with Tokens Studio

1. Install the **Tokens Studio** plugin in Figma
2. Connect to the GitHub repository where `packages/tokens/src/` lives
3. Tokens Studio reads the JSON files and creates Figma Variables automatically
4. Any change in JSON → push to Figma, or pull from Figma back to JSON

!!! info "Figma MCP Integration"
    BTech DS has integrated the Figma MCP server, which allows tokens to be read from and written to Figma Variables programmatically — without manually opening Figma.

---

## Workflows

### Designer Updates a Color

```
1. Designer changes a color in Figma Variables
2. Tokens Studio syncs → updates JSON on GitHub via PR
3. CI/CD runs Style Dictionary → generated/ updated
4. All platforms receive the updated color automatically
```

### Developer Adds a New Token

```
1. Developer adds token to src/*.json
2. PR reviewed and merged
3. CI/CD runs Style Dictionary → generates all platform files
4. Tokens Studio pushes changes back to Figma Variables
5. Designer can immediately use the new token in Figma
```

### Rebranding (Example: Blue → Green)

```json
// Before
"color.interactive.default": "{color.blue.600}"

// After — change 1 line only
"color.interactive.default": "{color.green.600}"
```

**Result:** Every button, link, and interactive element across ALL platforms automatically becomes green — without touching a single component file.

---

!!! tip "Quick Rules"
    - **Use SCSS variables** (`$token-name`) inside UI component styles
    - **Use Tailwind classes** only for docs site layout
    - **Use component tokens** inside component SCSS files
    - **Use semantic tokens** for shared layout styles
    - **Never** use primitive tokens directly in components
    - **Never** hardcode colors or sizes — always reference a token
    - **Never** edit files inside `generated/` manually
