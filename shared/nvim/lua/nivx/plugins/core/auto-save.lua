return {
  "okuuva/auto-save.nvim",
  version = "*",
  cmd = "ASToggle",
  event = { "InsertLeave", "TextChanged" },
  opts = {
    debounceDelay = 1000,
  },
  condition = function(buf)
    return vim.bo[buf].filetype ~= "gitcommit" and vim.bo[buf].modifiable
  end,
}
