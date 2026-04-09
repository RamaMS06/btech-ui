# General Rules

- This is a monorepo managed by pnpm workspaces + Turborepo
- Node >= 20, pnpm >= 9
- TypeScript strict mode everywhere (web packages)
- Use named exports, never default exports (except Vue SFCs)
- File naming: kebab-case for files, PascalCase for components
- Prefer `const` over `let`, never use `var`
- Maximum file length: 300 lines. Extract if longer.
- Imports from workspace packages use `@btech/` prefix
- Token values are NEVER hardcoded in components; always reference CSS custom properties or token constants
- All public APIs must have JSDoc/TSDoc comments
