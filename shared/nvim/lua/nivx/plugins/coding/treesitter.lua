return {
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    vscode = true,
    build = ":TSUpdate",
    main = "nvim-treesitter.configs", -- Sets main module to use for opts
    opts = {
      install_dir = vim.fn.stdpath("data") .. "/site",

      autopairs = {
        enable = true,
      },

      rainbow = {
        enable = false,
        extended_mode = false,
        max_file_lines = nil,
      },

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },

      indent = { enable = true, disable = { "ruby" } },

      context_commentstring = {
        enable = true,
        enable_autocmd = false,
        config = {
          typescript = { __default = "// %s", __multiline = "/* %s */" },
          css = "/* %s */",
          scss = { __default = "// %s", __multiline = "/* %s */" },
          php = { __default = "// %s", __multiline = "/* %s */" },
          html = "<!-- %s -->",
          svelte = "<!-- %s -->",
          vue = "<!-- %s -->",
          handlebars = "{{! %s }}",
          glimmer = "{{! %s }}",
          graphql = "# %s",
          lua = { __default = "-- %s", __multiline = "--[[ %s ]]" },
          vim = '" %s',
          tsx = {
            __default = "// %s",
            __multiline = "/* %s */",
            jsx_element = "{/* %s */}",
            jsx_fragment = "{/* %s */}",
            jsx_attribute = { __default = "// %s", __multiline = "/* %s */" },
            comment = { __default = "// %s", __multiline = "/* %s */" },
            call_expression = { __default = "// %s", __multiline = "/* %s */" },
            statement_block = { __default = "// %s", __multiline = "/* %s */" },
            spread_element = { __default = "// %s", __multiline = "/* %s */" },
          },
          javascript = {
            __default = "// %s",
            __multiline = "/* %s */",
            jsx_element = "{/* %s */}",
            jsx_fragment = "{/* %s */}",
            jsx_attribute = { __default = "// %s", __multiline = "/* %s */" },
            comment = { __default = "// %s", __multiline = "/* %s */" },
            call_expression = { __default = "// %s", __multiline = "/* %s */" },
            statement_block = { __default = "// %s", __multiline = "/* %s */" },
            spread_element = { __default = "// %s", __multiline = "/* %s */" },
          },
        },
      },

      autotag = {
        enable = true,
      },
    },
    config = function(_, opts)
      local function get_compiler()
        if vim.fn.executable("gcc") == 1 then
          return "gcc"
        end
        if vim.fn.executable("clang") == 1 then
          return "clang"
        end
        if vim.fn.executable("cl") == 1 then
          return "cl"
        end
        return nil
      end

      local parsers = {
        "bash",
        "c",
        "diff",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "python",
        "json",
        "jsdoc",
        "tsx",
      }

      local treesitter = require("nvim-treesitter")

      treesitter.setup(opts)

      local compiler = get_compiler()

      if compiler then
        vim.env.CC = compiler
        treesitter.install(parsers)
      end

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    vscode = true,
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      select = {
        lookahead = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter-textobjects").setup(opts)

      local map = vim.keymap.set
      local textobjects_select = require("nvim-treesitter-textobjects.select")

      map({ "x", "o" }, "af", function()
        textobjects_select.select_textobject("@function.outer", "textobjects")
      end)
      map({ "x", "o" }, "if", function()
        textobjects_select.select_textobject("@function.inner", "textobjects")
      end)
      map({ "x", "o" }, "ac", function()
        textobjects_select.select_textobject("@class.outer", "textobjects")
      end)
      map({ "x", "o" }, "ic", function()
        textobjects_select.select_textobject("@class.inner", "textobjects")
      end)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = false,
  },
}
