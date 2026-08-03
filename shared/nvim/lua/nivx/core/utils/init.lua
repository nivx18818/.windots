local M = {}

function M.get_git_root()
  return vim.fs.root(0, { ".git" }) or vim.loop.cwd()
end

return M
