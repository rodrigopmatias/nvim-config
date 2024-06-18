-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:
---@type LazySpec

return {
  {
    "loctvl842/monokai-pro.nvim",
    name = "monokai",
    config = function()
      require("monokai-pro").setup {
        -- filter = "ristretto",
        -- filter = "pro",
        -- filter = "octagon",
        filter = "machine",
        -- filter = "spectrum",
        -- filter = "classic",
        devicons = true,
        styles = {
          comment = { italic = false },
          keyword = { italic = false }, -- any other keyword
          type = { italic = false }, -- (preferred) int, long, char, etc
          storageclass = { italic = false }, -- static, register, volatile, etc
          structure = { italic = false }, -- struct, union, enum, etc
          parameter = { italic = false }, -- parameter pass in function
          annotation = { italic = false },
          tag_attribute = { italic = false }, -- attribute of tag in reactjs
        },
      }
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato",
      -- flavour = "mocha",
      -- flavour = "frappe",
      -- flavour = "latte",
      no_italic = true,
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dap = true,
        dap_ui = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = true,
        markdown = true,
        mason = true,
        native_lsp = true,
        neotree = true,
        notify = true,
        semantic_tokens = true,
        symbols_outline = true,
        telescope = true,
        treesitter = true,
        ts_rainbow = false,
        ufo = true,
        which_key = true,
        window_picker = true,
      },
    },
  },
  {
    "leoluz/nvim-dap-go",
    config = function()
      require("dap-go").setup {
        delve = {
          path = "/home/rodrigo/go/bin/dlv",
        },
      }
    end,
  },
  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "d8888b.  .d8b.  d888888b  .o88b.  .d88b.  d8888b.  .d8b.  ",
        "88  `8D d8' `8b   `88'   d8P  Y8 .8P  Y8. 88  `8D d8' `8b ",
        "88oodD' 88ooo88    88    8P      88    88 88   88 88ooo88 ",
        "88~~~   88~~~88    88    8b      88    88 88   88 88~~~88 ",
        "88      88   88   .88.   Y8b  d8 `8b  d8' 88  .8D 88   88 ",
        "88      YP   YP Y888888P  `Y88P'  `Y88P'  Y8888D' YP   YP ",
        "----------------------------------------------------------",
        "------------------- twitch.tv/paicode --------------------",
        "----------------------------------------------------------",
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
}
