# Vue External Example

This is a prototype showing how an **external Vue project** (separate repo) consumes Btech design tokens via git dependency.

## How It Works

### 1. Install from GitHub

```json
// package.json
{
  "dependencies": {
    "btech-ui": "github:RamaMS06/btech-ui"
  }
}
```

```bash
npm install
```

### 2. Import tokens CSS

```ts
// main.ts — one line, all tokens available
import 'btech-ui/tokens/generated/web/tokens.css'
```

### 3. Use CSS custom properties

```css
.my-button {
  background: var(--primary);
  color: var(--primary-foreground);
  border: 1px solid var(--border);
  border-radius: var(--radius);
}
```

### 4. Dark mode

```ts
// Toggle dark mode — all tokens switch automatically
document.documentElement.classList.toggle('dark')
```

## Available CSS Variables

| Category | Variables |
|----------|----------|
| Surface | `--background`, `--card`, `--popover` |
| Brand | `--primary`, `--secondary`, `--accent` |
| Feedback | `--destructive`, `--success`, `--warning`, `--info` |
| Form | `--border`, `--input`, `--ring` |
| Layout | `--radius`, `--shadow-md`, `--z-modal` |
| Motion | `--duration-normal`, `--ease-default` |
| Typography | `--font-sans`, `--font-mono` |

Each role has a `*-foreground` pair (e.g., `--primary` + `--primary-foreground`).

## Run

```bash
npm install
npm run dev
```
