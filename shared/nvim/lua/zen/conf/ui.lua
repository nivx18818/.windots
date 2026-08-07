-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

local stl_utils = require("nvchad.stl.utils")

local sep_icons = stl_utils.separators
local sep_style = "default"
local separators = (type(sep_style) == "table" and sep_style) or sep_icons[sep_style]
local sep_l = separators["left"]
local sep_r = separators["right"]

M.base46 = {
  theme = "vesper",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.nvdash = { load_on_startup = true }

M.ui = {
  tabufline = {
    enabled = false,
  },

  statusline = {
    -- order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
    modules = {
      file = function()
        local stbufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)

        local x = stl_utils.file()
        local modified = vim.bo[stbufnr].modified and " [+]" or ""
        local readonly = (not vim.bo[stbufnr].modifiable or vim.bo[stbufnr].readonly) and " [RO]" or ""
        local name = " " .. x[2] .. modified .. readonly .. (sep_style == "default" and " " or "")

        return "%#St_file# " .. x[1] .. name .. "%#St_file_sep#" .. sep_r
      end,
      cursor = "%#St_pos_sep#" .. sep_l .. "%#St_pos_icon# %#St_pos_text# %p.%v "
    },
  },
}

return M
