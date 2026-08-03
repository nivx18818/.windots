require("nivx.core.keymaps.common")

if vim.g.vscode then
  require("nivx.core.keymaps.vscode")
else
  require("nivx.core.keymaps.nvim")
end
