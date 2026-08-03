require("nivx.core.options.common")

if vim.g.vscode then
  require("nivx.core.options.vscode")
else
  require("nivx.core.options.nvim")
end
