-- <sky-config>
---@type LazySpec
return {
  {
    "mrjones2014/smart-splits.nvim",
    opts = {
      ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
      ignored_buftypes = { "nofile" },
      -- Usually this is supposed to be auto-detected, but the auto-detection wasn't working for me.
      -- Explicitly setting this to "tmux" fixes the issue where <C-(hjkl)> wasn't navigating from nvim
      -- splits into tmux splits.
      multiplexer_integration = "tmux",
    },
  },
  {
    "Mofiqul/vscode.nvim",
    config = function()
      vim.o.background = "dark"
      require("vscode").setup {
        transparent = true,
      }
    end,
  },
  {
    "sainnhe/gruvbox-material",
    config = function()
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_dim_inactive_windows = 1
      vim.g.gruvbox_material_better_performance = 0
      vim.g.gruvbox_material_ui_contrast = "high"
      vim.o.background = "dark"
    end,
  },
  {
    -- SKY CONFIG: Fixes the annoying "Highlight group 'NotifyBackground' has no background highlight..." error
    -- when using transparent themes. opts is written as a function because this overrides default AstroNvim plugin config.
    -- https://docs.astronvim.com/configuration/customizing_plugins#configure-astronvim-plugins
    "rcarriga/nvim-notify",
    opts = function(_, opts) opts.background_colour = "#000000" end,
  },
  {
    "kylechui/nvim-surround",
    version = "^4.0.0",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
}
-- </sky-config>
