# Git Rules (always apply)

- Branch naming: feat/, fix/, chore/, docs/ prefix
- Commit messages: conventional commits (feat:, fix:, chore:, docs:, refactor:)
- PR scope: one logical change per PR
- Changesets required for any user-facing change
- tokens/generated/ is committed to git (auto-generated but tracked)
- Run `pnpm build && pnpm test` before pushing
