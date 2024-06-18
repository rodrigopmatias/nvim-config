return {
  load_launch_json = function()
    if vim.fn.filereadable ".vscode/launch.json" == 1 then
      local data = {}
      for line in io.open(".vscode/launch.json", "r"):lines() do
        if not vim.startswith(vim.trim(line), "//") then table.insert(data, line) end
      end
      local launch = vim.json.decode(table.concat(data, "\n"))
      require("dap").configurations.python = launch["configurations"]

      vim.notify("launch loaded with success!!!", vim.log.levels.INFO)
    else
      vim.notify("launch file not present", vim.log.levels.WARN)
    end
  end,
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@type AstroLSPOpts
    opts = {
      ---@diagnostic disable: missing-fields
      config = {
        pyright = {
          before_init = function(_, c) c.settings.python.pythonPath = vim.fn.exepath "python" end,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "python", "toml" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "pyright" })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "black", "isort" })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "python" })
      if not opts.handlers then opts.handlers = {} end
      opts.handlers.python = function() end -- make sure python doesn't get set up by mason-nvim-dap, it's being set up by nvim-dap-python
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, { "pyright", "black", "isort", "debugpy" })
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>lv"] = { "<Cmd>VenvSelect<CR>", desc = "Select VirtualEnv" },
              ["<Leader>lV"] = { "<Cmd>VenvSelectCached<CR>", desc = "Select last VirtualEnv" },
            },
          },
        },
      },
    },
    lazy = false,
    branch = "regexp",
    opts = {
      name = { "venv", ".venv", ".env" },
    },
    cmd = { "VenvSelect", "VenvSelectCached" },
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = {
      "mfussenegger/nvim-dap",
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>dj"] = {
                "<Cmd>lua require('plugins/python').load_launch_json()<CR>",
                desc = "Load launch JSON file",
              },
            },
          },
        },
      },
    },
    ft = "python", -- NOTE: ft: lazy-load on filetype
    config = function(_, opts)
      local path = require("mason-registry").get_package("debugpy"):get_install_path()
      if vim.fn.has "win32" == 1 then
        path = path .. "/venv/Scripts/python"
      else
        path = path .. "/venv/bin/python"
      end
      require("dap-python").setup(path, opts)
      require("dap-python").test_runner = "pytest"
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "nvim-neotest/neotest-python" },
    opts = function(_, opts)
      if not opts.adapters then opts.adapters = {} end
      table.insert(opts.adapters, require "neotest-python"(require("astrocore").plugin_opts "neotest-python"))
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        python = { "isort", "black" },
      },
    },
  },
}
