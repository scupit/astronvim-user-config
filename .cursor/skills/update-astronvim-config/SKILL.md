---
name: update-astronvim-config
description: >-
  Update the AstroNvim user configuration to the latest upstream template while
  preserving personal changes. Use when the user asks to update, sync, or
  upgrade their AstroNvim config, neovim config, or nvim config against the
  template, or mentions astronvim-user-config and template together.
---

# Update AstroNvim Config

This skill updates an AstroNvim user configuration to match the latest upstream
template while preserving all personal customizations.

## Key concepts

- **User config**: The user's AstroNvim configuration directory (a git repo).
- **Template**: The official [AstroNvim/template](https://github.com/AstroNvim/template) repo (cloned separately).
- **`-- <sky-config>` delimiters**: Pairs of `-- <sky-config>` and `-- </sky-config>` comments in Lua files that mark every personal change. Files without delimiters are unmodified from the template.
- **README "Tracking Personal Changes" section**: Contains the last synced template commit hash.

## Locating the repos

Ask the user for the paths to both directories if not obvious from context. Typical layout:

```
some-parent/
├── astronvim-user-config/   # user's config
└── template/                # latest AstroNvim/template clone
```

## Update workflow

### 1. Read the README and extract the last synced commit

Open the user config's `README.md` and find the **"Tracking Personal Changes"** section. Extract the last synced template commit hash.

### 2. Extract personal changes

Search all `.lua` files in the user config for `-- <sky-config>` delimiters. For each delimited block, record:
- The file path
- The Lua table path the block sits inside (e.g., `opts.options.opt`, `opts.mappings.n`, `opts.formatting.format_on_save`). This is used in step 6 to find the correct insertion point in the new template.
- The exact content between the delimiters

Files where the **entire content** is wrapped in delimiters (like `user.lua`) are fully custom; everything else in those files is template boilerplate that should be replaced.

### 3. Ensure the template is up to date

Ask the user to pull the latest template, or run `git pull` in the template directory if permitted. Note the new HEAD commit hash.

### 4. Check what changed in the template

Run `git log --oneline <last-synced-commit>..HEAD` in the template repo to see what upstream changes occurred. This helps anticipate structural changes that might affect where personal changes need to be re-inserted.

### 5. Update files without personal changes

Iterate over the **template** files (not the user config). For each template file that has no corresponding `-- <sky-config>` delimiters in the user config, copy it from the template into the user config, overwriting the old version. This also handles new files that exist in the template but not yet in the user config.

Leave any user-config-only files (files that exist in the user config but not in the template) untouched -- these are user additions.

Only process tracked config files (`.lua`, `.json`, `.toml`, `.yml`, `.md`). Skip `.git/`, `lazy-lock.json` (auto-generated), and any other non-config artifacts.

### 6. Update files with personal changes

For each file that **does** have `-- <sky-config>` delimiters:

1. Start from the **new template version** of that file.
2. Remove the `if true then return {} end` guard line if present (removing the guard activates the files).
3. Re-insert each `-- <sky-config>` block at the correct location, replacing the corresponding template default.

**How to find the correct insertion point:** Match the Lua table path recorded in step 2 against the new template. For example, a `relativenumber` override goes in `opts.options.opt`, custom keymaps go in `opts.mappings.n`, etc.

**If the template made minor syntax/key changes** (e.g., a key was renamed, a value format changed, but the same setting still exists at the same table path), silently adapt the personal change to use the new syntax. Note that newer templates may change how the configuration has to be structured. In that case, please use the new configuration structure when adding back the user-updated delimited sections. This is rare -- it'll likely only happen for *major* version upgrades.

**If the template removed or fundamentally reorganized a section** such that the table path no longer exists and there is no clear equivalent, do NOT guess. Flag it to the user and ask how they want to handle it.

### 7. Handle `user.lua` specially

`user.lua` is typically **entirely custom** (the whole file is wrapped in `<sky-config>` delimiters). The template version of this file contains only example plugins. When updating:
- Keep the user's entire `user.lua` content as-is.
- Do NOT copy or merge the template's example content.

### 8. Verify

Diff every updated file against the template to confirm that the **only** differences are the delimited personal changes. Run from the parent directory that contains both repos (adapt paths to match the actual directory layout):

```shell
git diff --no-index template/<file> astronvim-user-config/<file>
```

Every hunk in the diff should correspond to a `-- <sky-config>` block (plus the removed guard lines on activated files).

### 9. Update the README

In the user config's `README.md`, update the "Last synced with template commit" line to the new template HEAD commit hash and message.

### 10. Present a summary

Tell the user:
- Which files were copied unchanged from the template
- Which files had personal changes re-applied
- Any new template files that were added
- Any structural changes that required special handling
- The new synced commit hash

## Edge cases

- **New template files**: Copy them into the user config. Mention them in the summary.
- **Deleted template files**: Flag to the user; do not auto-delete.
- **Template restructured a config section**: If a `<sky-config>` block's Lua table path no longer exists and there is no clear equivalent in the new template, ask the user how to adapt it rather than guessing. If the same setting exists under a renamed or reorganized key, silently adapt.
- **User added new personal changes since last sync**: If there are modifications outside the `<sky-config>` delimiters that don't match the old template, ask the user whether these are intentional new customizations. If so, wrap them in new delimiters.

## After the update

Remind the user to:
1. Open Neovim and run `:Lazy update` to update plugins.
2. Verify everything works as expected.
3. Commit the changes to their config repo.
