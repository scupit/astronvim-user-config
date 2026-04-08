# AstroNvim Template

**NOTE:** This is for AstroNvim v6+

A template for getting started with [AstroNvim](https://github.com/AstroNvim/AstroNvim)

## 🛠️ Installation

#### Make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

#### Create a new user repository from this template

Press the "Use this template" button above to create a new repository to store your user configuration.

You can also just clone this repository directly if you do not want to track your user configuration in GitHub.

#### Clone the repository

```shell
git clone https://github.com/<your_user>/<your_repository> ~/.config/nvim
```

#### Start Neovim

```shell
nvim
```

## Tracking Personal Changes

**Last synced with template commit:** `49a7161` (`fix: Replaced deprecated vim.lsp methods (#40)`) from [AstroNvim/template](https://github.com/AstroNvim/template)

Personal configuration changes are marked with `-- <sky-config>` / `-- </sky-config>` delimiters in the Lua files. When updating to a newer template version, look for these delimiters to identify the exact lines that differ from the upstream template and need to be preserved. Files without any delimiters are unmodified from the template.