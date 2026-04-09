# Skill: Release

## Trigger
User says "release", "publish", or "cut a release"

## Steps

1. **Check** pending changesets: `pnpm changeset status`
2. **Version** packages: `pnpm changeset version`
3. **Build** all packages: `pnpm build`
4. **Test** all packages: `pnpm test`
5. **Commit** version bumps and changelog updates
6. **Publish** to npm: `pnpm changeset publish` (or let CI handle)
7. **Flutter**: update version in `pubspec.yaml` manually, run `flutter pub publish --dry-run`
