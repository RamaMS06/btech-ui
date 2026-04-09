# React Component Rules (applies to: ui/react/)

- React 18+ with TypeScript
- All components use React.forwardRef and set displayName
- Props interfaces extend relevant HTML attributes
- CSS custom properties from @btech/tokens, not inline styles
- Component folder: Name/Name.tsx + index.ts
- Every component needs: .tsx, .stories.tsx, .test.tsx, .figma.tsx, index.ts
- Export component AND its props type from index.ts
- Import shared types from @btech/shared
