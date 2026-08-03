require("nivx.core.autocmds.common")

if vim.g.vscode then
  require("nivx.core.autocmds.vscode")
else
  require("nivx.core.autocmds.nvim")
end
