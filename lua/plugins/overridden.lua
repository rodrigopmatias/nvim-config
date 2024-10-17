return {
  {
    "L3MON4D3/LuaSnip",
    opts = function(plugin, opts)
      -- include the default astronvim config that calls the setup call
      require "astronvim.plugins.configs.luasnip"(plugin, opts)
      -- load snippets paths
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = { vim.fn.stdpath "config" .. "/snippets" },
      }
    end,
  },
  {
    "catppuccin/nvim",
    opts = function(_, opts) opts.no_italic = true end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    opts = function(_, opts) opts.name = { ".venv", "venv" } end,
  },
  {
    "nvim-neotest/neotest-python",
    opts = function(_, opts)
      opts.dap = { justMyCode = false }
      opts.args = { "--no-cov" }
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.window = vim.tbl_extend("force", opts.window, {
        width = 45,
      })
    end,
  },
}
