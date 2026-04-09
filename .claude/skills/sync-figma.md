# Skill: Sync Figma Tokens

## Trigger
User says "sync figma", "pull from figma", or "update tokens from figma"

## Steps

1. **Use Figma MCP** `get_variable_defs` to pull variables from the Figma file
2. **Map** Figma variable collections to token layers:
   - "Primitives" collection -> `primitive/*.json`
   - "Semantic" collection -> `semantic/*.json`
   - "Components" collection -> `component/*.json`
3. **Transform** Figma variable format to DTCG JSON format
4. **Write** updated JSON files
5. **Run** `pnpm build:tokens`
6. **Verify** diffs in `tokens/generated/` and commit
7. Flutter picks up changes automatically via `btech_tokens` path dependency
