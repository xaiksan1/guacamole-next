# Visual Testing Guidelines

## Overview

We use Chromatic for visual testing and review of components. This ensures consistency and catches unintended visual changes.

## Workflow

1. Create/update component
2. Write/update Storybook stories
3. Run local Storybook tests
4. Push changes to trigger Chromatic build
5. Review changes in Chromatic
6. Approve or request changes

## Best Practices

1. Create stories for all visual states
2. Include responsive design tests
3. Test different themes
4. Document visual requirements

## Commands

```bash
# Run Storybook locally
npm run storybook

# Build Storybook
npm run build-storybook

# Run Chromatic
npm run chromatic
```

## Review Process

1. Review visual changes in Chromatic
2. Check responsive behavior
3. Verify component states
4. Ensure accessibility
5. Approve or request changes

