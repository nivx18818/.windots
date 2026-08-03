return {
  {
    "datsfilipe/vesper.nvim",
    priority = 1000,
    opts = {
      italics = {
        comments = true,
        keywords = false,
        functions = false,
        strings = false,
        variables = false,
      }
    },
    config = function(_, opts)
      require('vesper').setup(opts)
      vim.cmd.colorscheme("vesper")
    end
  },
  {
    "olivercederborg/poimandres.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local p = require("poimandres.palette")

      require('poimandres').setup({
        disable_background = false,
        disable_float_background = true,
        disable_italics = false,
        bold_vert_split = true,
        dim_nc_background = false,
        highlight_groups = {
          WinSeparator = { fg = p.background1 },
          FloatBorder = { bg = p.none, fg = p.background1 },

          -- LSP highlights
          LspReferenceText = { link = "Visual" },
          LspReferenceRead = { link = "Visual" },
          LspReferenceWrite = { link = "Visual" },

          -- Neo-tree base
          NeoTreeNormal = { bg = p.background2, fg = p.text },
          NeoTreeNormalNC = { bg = p.background2, fg = p.text },
          NeoTreeCursorLine = { bg = p.background1 },
          NeoTreeIndentMarker = { fg = p.background1 },

          -- Directory / root
          NeoTreeDirectoryName = { fg = p.blueGray2 },
          NeoTreeDirectoryIcon = { fg = p.blueGray1 },
          NeoTreeRootName = { fg = p.blueGray2, bold = true },
          NeoTreeSymbolicLinkTarget = { fg = p.blue2 },

          -- Files
          NeoTreeFileIcon = { fg = p.blueGray1 },
          NeoTreeFileName = { fg = p.blueGray2 },
          NeoTreeFileNameOpened = { fg = p.blueGray2 },
          NeoTreeMessage = { fg = p.blueGray2 },

          -- Git integration
          NeoTreeGitAdded = { link = "NeoTreeFileName" },
          NeoTreeGitDeleted = { fg = p.pink3 },
          NeoTreeGitModified = { fg = p.blue2 },
          NeoTreeGitUntracked = { fg = p.teal1 },
          NeoTreeGitIgnored = { fg = p.blueGray3 },
          NeoTreeGitStaged = { fg = p.teal3 },
          NeoTreeGitUnstaged = { link = "NeoTreeFileName" },

          -- Diagnostics
          NeoTreeError = { fg = p.pink3 },
          NeoTreeWarning = { fg = p.yellow },
          NeoTreeInfo = { fg = p.blue1 },
          NeoTreeHint = { fg = p.teal2 },
        }
      })
    end,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
  },
}
