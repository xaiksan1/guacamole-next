# Summary of Changes

## Submodules Added
- Hyprland
- hyprlang
- hyprcursor
- hyprutils
- wlroots
- hyprgraphics
- aquamarine

## Key Commands Used
```bash
# Add submodules
git submodule add [repository-url] [local-path]

# Initialize and update submodules
git submodule update --init --recursive

# Update specific submodule to latest
git submodule update --remote [submodule-name]

## Changes Made
- Added .gitignore rule for Meson build artifacts: **/.meson-subproject-wrap-hash.txt
- Removed unrelated shadowverse-client directory
- Updated all submodules to their latest versions
```
