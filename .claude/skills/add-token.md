# Skill: Add Token

## Trigger
User says "add token", "new token", or "add design token"

## Steps

1. **Determine layer**: primitive, semantic, or component
2. **Determine category**: color, spacing, typography, radius, shadow, z-index, motion, opacity
3. **Add** to appropriate JSON file in `tokens/src/<layer>/`
   - No layer prefix in key names (e.g., `color.blue.600` not `primitive.color.blue.600`)
   - For semantic color tokens: include `$extensions.dark.$value` for dark mode
4. **Validate references**:
   - If semantic: verify referenced primitives exist in `tokens/src/primitive/`
   - If component: verify referenced semantics exist in `tokens/src/semantic/`
   - Never skip layers
5. **Run** `pnpm build:tokens`
6. **Verify** outputs in `tokens/generated/` directory
7. Flutter picks up changes automatically via `btech_tokens` path dependency
