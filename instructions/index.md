# Design Token System

*Source: UI/UX Specification, Area 1, Section 2*
*Covers: Color Palette (OKLCH light/dark), Typography, Spacing, Radius, Shadows, Z-Index, Animations*

## Design Token Specification (Detail)

### 2a. Color Palette

#### Color Philosophy
Uses OKLCH color space for perceptual uniformity. All colors are defined as CSS custom properties in `:root` (light) and `.dark` (dark mode).

#### CSS Variables — Light Mode (`:root`)

```css
:root {
  /* Background */
  --background: oklch(1 0 0);                    /* #ffffff */
  --background-foreground: oklch(0.145 0.017 285.5); /* #09090b */

  /* Card */
  --card: oklch(1 0 0);                          /* #ffffff */
  --card-foreground: oklch(0.145 0.017 285.5);   /* #09090b */

  /* Popover */
  --popover: oklch(1 0 0);                       /* #ffffff */
  --popover-foreground: oklch(0.145 0.017 285.5);/* #09090b */

  /* Primary */
  --primary: oklch(0.205 0.042 265.8);           /* #0f172a deep navy */
  --primary-foreground: oklch(0.985 0.002 106.4);/* #fafaf9 */

  /* Secondary */
  --secondary: oklch(0.965 0.001 286.4);         /* #f4f4f5 */
  --secondary-foreground: oklch(0.205 0.042 265.8); /* #0f172a */

  /* Muted */
  --muted: oklch(0.965 0.001 286.4);             /* #f4f4f5 */
  --muted-foreground: oklch(0.556 0.016 286.0);  /* #71717a */

  /* Accent */
  --accent: oklch(0.965 0.001 286.4);            /* #f4f4f5 */
  --accent-foreground: oklch(0.205 0.042 265.8); /* #0f172a */

  /* Destructive */
  --destructive: oklch(0.577 0.245 27.3);        /* #dc2626 */
  --destructive-foreground: oklch(0.985 0.002 106.4); /* #fafaf9 */

  /* Success */
  --success: oklch(0.596 0.172 149.2);           /* #16a34a */
  --success-foreground: oklch(0.985 0.002 106.4);/* #fafaf9 */

  /* Warning */
  --warning: oklch(0.768 0.165 74.1);            /* #f59e0b */
  --warning-foreground: oklch(0.205 0.042 265.8);/* #0f172a */

  /* Info */
  --info: oklch(0.588 0.158 241.1);              /* #2563eb */
  --info-foreground: oklch(0.985 0.002 106.4);   /* #fafaf9 */

  /* Border & Input & Ring */
  --border: oklch(0.922 0.004 286.3);            /* #e4e4e7 */
  --input: oklch(0.922 0.004 286.3);             /* #e4e4e7 */
  --ring: oklch(0.556 0.016 286.0);              /* #71717a */

  /* Sidebar */
  --sidebar: oklch(0.985 0.002 106.4);           /* #fafaf9 */
  --sidebar-foreground: oklch(0.145 0.017 285.5);/* #09090b */
  --sidebar-border: oklch(0.922 0.004 286.3);    /* #e4e4e7 */
  --sidebar-ring: oklch(0.556 0.016 286.0);      /* #71717a */
  --sidebar-accent: oklch(0.965 0.001 286.4);    /* #f4f4f5 */
  --sidebar-accent-foreground: oklch(0.205 0.042 265.8); /* #0f172a */
  --sidebar-primary: oklch(0.205 0.042 265.8);   /* #0f172a */
  --sidebar-primary-foreground: oklch(0.985 0.002 106.4);/* #fafaf9 */

  /* Chart Colors */
  --chart-1: oklch(0.646 0.222 41.1);            /* #e76e50 */
  --chart-2: oklch(0.6 0.118 184.7);             /* #2a9d90 */
  --chart-3: oklch(0.398 0.07 227.4);            /* #264653 */
  --chart-4: oklch(0.828 0.128 84.8);            /* #e9c46a */
  --chart-5: oklch(0.769 0.188 70.1);            /* #f4a261 */
}
```

#### CSS Variables — Dark Mode (`.dark`)

```css
.dark {
  /* Background */
  --background: oklch(0.145 0.017 285.5);        /* #09090b */
  --background-foreground: oklch(0.985 0.002 106.4); /* #fafaf9 */

  /* Card */
  --card: oklch(0.205 0.015 286.1);              /* #18181b */
  --card-foreground: oklch(0.985 0.002 106.4);   /* #fafaf9 */

  /* Popover */
  --popover: oklch(0.205 0.015 286.1);           /* #18181b */
  --popover-foreground: oklch(0.985 0.002 106.4);/* #fafaf9 */

  /* Primary */
  --primary: oklch(0.985 0.002 106.4);           /* #fafaf9 */
  --primary-foreground: oklch(0.205 0.042 265.8);/* #0f172a */

  /* Secondary */
  --secondary: oklch(0.274 0.014 286.1);         /* #27272a */
  --secondary-foreground: oklch(0.985 0.002 106.4); /* #fafaf9 */

  /* Muted */
  --muted: oklch(0.274 0.014 286.1);             /* #27272a */
  --muted-foreground: oklch(0.708 0.01 286.1);   /* #a1a1aa */

  /* Accent */
  --accent: oklch(0.274 0.014 286.1);            /* #27272a */
  --accent-foreground: oklch(0.985 0.002 106.4); /* #fafaf9 */

  /* Destructive */
  --destructive: oklch(0.704 0.191 22.2);        /* #ef4444 */
  --destructive-foreground: oklch(0.985 0.002 106.4); /* #fafaf9 */

  /* Success */
  --success: oklch(0.696 0.17 149.6);            /* #22c55e */
  --success-foreground: oklch(0.145 0.017 285.5);/* #09090b */

  /* Warning */
  --warning: oklch(0.828 0.128 84.8);            /* #eab308 */
  --warning-foreground: oklch(0.145 0.017 285.5);/* #09090b */

  /* Info */
  --info: oklch(0.688 0.158 241.1);              /* #3b82f6 */
  --info-foreground: oklch(0.985 0.002 106.4);   /* #fafaf9 */

  /* Border & Input & Ring */
  --border: oklch(0.274 0.014 286.1);            /* #27272a */
  --input: oklch(0.274 0.014 286.1);             /* #27272a */
  --ring: oklch(0.556 0.016 286.0);              /* #71717a */

  /* Sidebar */
  --sidebar: oklch(0.205 0.015 286.1);           /* #18181b */
  --sidebar-foreground: oklch(0.985 0.002 106.4);/* #fafaf9 */
  --sidebar-border: oklch(0.274 0.014 286.1);    /* #27272a */
  --sidebar-ring: oklch(0.556 0.016 286.0);      /* #71717a */
  --sidebar-accent: oklch(0.274 0.014 286.1);    /* #27272a */
  --sidebar-accent-foreground: oklch(0.985 0.002 106.4); /* #fafaf9 */
  --sidebar-primary: oklch(0.985 0.002 106.4);   /* #fafaf9 */
  --sidebar-primary-foreground: oklch(0.205 0.042 265.8);/* #0f172a */

  /* Chart Colors */
  --chart-1: oklch(0.488 0.243 264.1);           /* #2563eb */
  --chart-2: oklch(0.696 0.17 149.6);            /* #22c55e */
  --chart-3: oklch(0.769 0.188 70.1);            /* #f4a261 */
  --chart-4: oklch(0.704 0.191 22.2);            /* #ef4444 */
  --chart-5: oklch(0.768 0.153 316.2);           /* #d946ef */
}
```

#### Radius Token

```css
:root {
  --radius: 0.625rem; /* 10px — base radius */
}
```

Derived radius values used in utility classes:
- `rounded-none` → 0
- `rounded-sm` → `calc(var(--radius) - 4px)` → 6px
- `rounded-md` → `calc(var(--radius) - 2px)` → 8px
- `rounded-lg` → `var(--radius)` → 10px
- `rounded-xl` → `calc(var(--radius) + 4px)` → 14px
- `rounded-2xl` → `calc(var(--radius) + 8px)` → 18px
- `rounded-full` → 9999px

### 2b. Typography

#### Font Families

```css
:root {
  --font-sans: "Inter", ui-sans-serif, system-ui, -apple-system, sans-serif;
  --font-mono: "JetBrains Mono", ui-monospace, "Cascadia Code", monospace;
}
```

#### Font Size Scale

| Token | Size | Line Height | Usage |
|-------|------|-------------|-------|
| `text-xs` | 0.75rem (12px) | 1rem (16px) | Caption, helper text |
| `text-sm` | 0.875rem (14px) | 1.25rem (20px) | Small labels, metadata |
| `text-base` | 1rem (16px) | 1.5rem (24px) | Body text |
| `text-lg` | 1.125rem (18px) | 1.75rem (28px) | Lead text |
| `text-xl` | 1.25rem (20px) | 1.75rem (28px) | Section title |
| `text-2xl` | 1.5rem (24px) | 2rem (32px) | Card title |
| `text-3xl` | 1.875rem (30px) | 2.25rem (36px) | Page title |
| `text-4xl` | 2.25rem (36px) | 2.5rem (40px) | Hero title |

#### Font Weights

| Token | Weight | Usage |
|-------|--------|-------|
| `font-light` | 300 | Decorative |
| `font-normal` | 400 | Body text |
| `font-medium` | 500 | Labels, emphasis |
| `font-semibold` | 600 | Headings, buttons |
| `font-bold` | 700 | Strong emphasis |

#### Letter Spacing

| Token | Value | Usage |
|-------|-------|-------|
| `tracking-tighter` | -0.05em | Large headings |
| `tracking-tight` | -0.025em | Headings |
| `tracking-normal` | 0em | Body |
| `tracking-wide` | 0.025em | Small caps, labels |
| `tracking-wider` | 0.05em | Overline text |

### 2c. Spacing Scale

Base unit: 4px (0.25rem). Scale follows the Tailwind standard.

| Token | Value (rem) | Value (px) |
|-------|-------------|------------|
| `0` | 0 | 0 |
| `0.5` | 0.125rem | 2px |
| `1` | 0.25rem | 4px |
| `1.5` | 0.375rem | 6px |
| `2` | 0.5rem | 8px |
| `2.5` | 0.625rem | 10px |
| `3` | 0.75rem | 12px |
| `4` | 1rem | 16px |
| `5` | 1.25rem | 20px |
| `6` | 1.5rem | 24px |
| `8` | 2rem | 32px |
| `10` | 2.5rem | 40px |
| `12` | 3rem | 48px |
| `16` | 4rem | 64px |
| `20` | 5rem | 80px |
| `24` | 6rem | 96px |

### 2d. Border Radius

See section [Radius Token](#radius-token) above.

### 2e. Shadows

```css
:root {
  --shadow-none: none;
  --shadow-sm: 0 1px 2px 0 oklch(0 0 0 / 0.05);
  --shadow-md: 0 4px 6px -1px oklch(0 0 0 / 0.1), 0 2px 4px -2px oklch(0 0 0 / 0.1);
  --shadow-lg: 0 10px 15px -3px oklch(0 0 0 / 0.1), 0 4px 6px -4px oklch(0 0 0 / 0.1);
  --shadow-xl: 0 20px 25px -5px oklch(0 0 0 / 0.1), 0 8px 10px -6px oklch(0 0 0 / 0.1);
  --shadow-2xl: 0 25px 50px -12px oklch(0 0 0 / 0.25);
}
```

### 2f. Z-Index Scale

| Token | Value | Usage |
|-------|-------|-------|
| `--z-dropdown` | 50 | Dropdown menus |
| `--z-sticky` | 100 | Sticky headers |
| `--z-fixed` | 200 | Fixed elements |
| `--z-modal-backdrop` | 300 | Modal backdrop/overlay |
| `--z-modal` | 400 | Modal/Dialog content |
| `--z-popover` | 500 | Popover |
| `--z-tooltip` | 600 | Tooltip (highest) |
| `--z-toast` | 700 | Toast notification |

### 2g. Animation/Transition Tokens

#### Duration

| Token | Value | Usage |
|-------|-------|-------|
| `--duration-fastest` | 50ms | Micro-interactions |
| `--duration-fast` | 100ms | Hover states |
| `--duration-normal` | 200ms | Default transitions |
| `--duration-slow` | 300ms | Complex animations |
| `--duration-slower` | 500ms | Page transitions |

#### Easing

| Token | Value | Usage |
|-------|-------|-------|
| `--ease-default` | cubic-bezier(0.4, 0, 0.2, 1) | General purpose |
| `--ease-in` | cubic-bezier(0.4, 0, 1, 1) | Exit animations |
| `--ease-out` | cubic-bezier(0, 0, 0.2, 1) | Enter animations |
| `--ease-in-out` | cubic-bezier(0.4, 0, 0.2, 1) | Symmetric |
| `--ease-bounce` | cubic-bezier(0.34, 1.56, 0.64, 1) | Playful bounce |

#### Keyframe Animations

```css
@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

@keyframes fadeOut {
  from { opacity: 1; }
  to { opacity: 0; }
}

@keyframes slideUpIn {
  from { opacity: 0; transform: translateY(8px); }
  to { opacity: 1; transform: translateY(0); }
}

@keyframes slideDownIn {
  from { opacity: 0; transform: translateY(-8px); }
  to { opacity: 1; transform: translateY(0); }
}

@keyframes slideLeftIn {
  from { opacity: 0; transform: translateX(8px); }
  to { opacity: 1; transform: translateX(0); }
}

@keyframes slideRightIn {
  from { opacity: 0; transform: translateX(-8px); }
  to { opacity: 1; transform: translateX(0); }
}

@keyframes scaleIn {
  from { opacity: 0; transform: scale(0.95); }
  to { opacity: 1; transform: scale(1); }
}

@keyframes scaleOut {
  from { opacity: 1; transform: scale(1); }
  to { opacity: 0; transform: scale(0.95); }
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

@keyframes pulse {
  50% { opacity: 0.5; }
}

@keyframes accordionDown {
  from { height: 0; opacity: 0; }
  to { height: var(--content-height); opacity: 1; }
}

@keyframes accordionUp {
  from { height: var(--content-height); opacity: 1; }
  to { height: 0; opacity: 0; }
}

@keyframes sheetSlideInRight {
  from { transform: translateX(100%); }
  to { transform: translateX(0); }
}

@keyframes sheetSlideInLeft {
  from { transform: translateX(-100%); }
  to { transform: translateX(0); }
}

@keyframes sheetSlideInTop {
  from { transform: translateY(-100%); }
  to { transform: translateY(0); }
}

@keyframes sheetSlideInBottom {
  from { transform: translateY(100%); }
  to { transform: translateY(0); }
}

@keyframes toastSlideIn {
  from { transform: translateX(calc(100% + 1rem)); }
  to { transform: translateX(0); }
}

@keyframes toastSwipeOut {
  from { transform: translateX(var(--toast-swipe-end-x)); }
  to { transform: translateX(calc(100% + 1rem)); }
}
```

---

---

