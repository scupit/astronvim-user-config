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
    "rcarriga/nvim-notify",
    -- Fixes the annoying "Highlight group 'NotifyBackground' has no background highlight..." error.
    -- opts is written as a function because this is overriding some of the default AstroNvim plugin config.
    -- https://docs.astronvim.com/configuration/customizing_plugins#configure-astronvim-plugins
    opts = function(_, opts) opts.background_colour = "#000000" end,
  },
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  }
}

-- -- You can also add or configure plugins by creating files in this `plugins/` folder
-- -- Here are some examples:
--
-- ---@type LazySpec
-- return {
--
--   -- == Examples of Adding Plugins ==
--
--   "andweeb/presence.nvim",
--   {
--     "ray-x/lsp_signature.nvim",
--     event = "BufRead",
--     config = function() require("lsp_signature").setup() end,
--   },
--
--   -- == Examples of Overriding Plugins ==
--
--   -- customize alpha options
--   {
--     "goolord/alpha-nvim",
--     opts = function(_, opts)
--       -- customize the dashboard header
--       opts.section.header.val = {
--         " █████  ███████ ████████ ██████   ██████",
--         "██   ██ ██         ██    ██   ██ ██    ██",
--         "███████ ███████    ██    ██████  ██    ██",
--         "██   ██      ██    ██    ██   ██ ██    ██",
--         "██   ██ ███████    ██    ██   ██  ██████",
--         " ",
--         "    ███    ██ ██    ██ ██ ███    ███",
--         "    ████   ██ ██    ██ ██ ████  ████",
--         "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
--         "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
--         "    ██   ████   ████   ██ ██      ██",
--       }
--       return opts
--     end,
--   },
--
--   -- You can disable default plugins as follows:
--   { "max397574/better-escape.nvim", enabled = false },
--
--   -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
--   {
--     "L3MON4D3/LuaSnip",
--     config = function(plugin, opts)
--       require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
--       -- add more custom luasnip configuration such as filetype extend or custom snippets
--       local luasnip = require "luasnip"
--       luasnip.filetype_extend("javascript", { "javascriptreact" })
--     end,
--   },
--
--   {
--     "windwp/nvim-autopairs",
--     config = function(plugin, opts)
--       require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
--       -- add more custom autopairs configuration such as custom rules
--       local npairs = require "nvim-autopairs"
--       local Rule = require "nvim-autopairs.rule"
--       local cond = require "nvim-autopairs.conds"
--       npairs.add_rules(
--         {
--           Rule("$", "$", { "tex", "latex" })
--             -- don't add a pair if the next character is %
--             :with_pair(cond.not_after_regex "%%")
--             -- don't add a pair if  the previous character is xxx
--             :with_pair(
--               cond.not_before_regex("xxx", 3)
--             )
--             -- don't move right when repeat character
--             :with_move(cond.none())
--             -- don't delete if the next character is xx
--             :with_del(cond.not_after_regex "xx")
--             -- disable adding a newline when you press <cr>
--             :with_cr(cond.none()),
--         },
--         -- disable for .vim files, but it work for another filetypes
--         Rule("a", "a", "-vim")
--       )
--     end,
--   },
-- }
