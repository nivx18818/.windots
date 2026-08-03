return {
  "folke/flash.nvim",
  vscode = true,
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {},
  config = function(_, opts)
    require("flash").setup(opts);

    vim.api.nvim_set_hl(0, "FlashCursor", { reverse = true })

    if not vim.g.vscode then
      return
    end

    local vscode = require('vscode')
    local current_theme = vscode.get_config("workbench.colorTheme")

    if current_theme == "poimandres" then
      vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = "#767c9d" })
      vim.api.nvim_set_hl(0, "FlashCurrent", { bg = "#ffffff", fg = "#1b1e28" })
      vim.api.nvim_set_hl(0, "FlashLabel", { bg = "#5de4c7", fg = "#ffffff", bold = true })
      vim.api.nvim_set_hl(0, "FlashMatch", { bg = "#272c3b", fg = "#ffffff" })
    elseif current_theme == "Vesper" then
      vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = "#707070" })
      vim.api.nvim_set_hl(0, "FlashCurrent", { bg = "#ffffff", fg = "#101010" })
      vim.api.nvim_set_hl(0, "FlashLabel", { bg = "#ffc799", fg = "#101010", bold = true })
      vim.api.nvim_set_hl(0, "FlashMatch", { bg = "#323232", fg = "#ffffff" })
    end
  end,
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "<C-t>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
