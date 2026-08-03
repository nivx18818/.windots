return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
      highlight = "IblIndent",
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
      highlight = "IblScope",
      include = {
        node_type = {
          ["*"] = { "function", "method", "class", "for", "while", "if", "else", "switch", "try", "catch", "block", "table_constructor", "object", "array", "element", "tag", "jsx_element", "jsx_fragment", "dictionary", "list", "arguments", "parameters", }
        }
      }
    },
    exclude = {
      filetypes = { "help", "alpha", "dashboard", "neo-tree", "lazy", "mason", "notify", "toggleterm", "Trouble" },
      buftypes = { "terminal", "nofile" },
    },
  },
  config = function(_, opts)
    local hooks = require("ibl.hooks")
    local p = require("poimandres.palette")

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "IblIndent", { fg = p.background1 })
    end)

    require("ibl").setup(opts)
  end,
}
