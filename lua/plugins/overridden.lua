return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.window = vim.tbl_extend("force", opts.window, {
        width = 45,
      })
    end,
  },
}
