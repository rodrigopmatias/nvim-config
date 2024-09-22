return {
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
