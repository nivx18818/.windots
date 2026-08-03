local opt = vim.opt

vim.g.mapleader = " "

vim.schedule(function()
  -- don’t use system clipboard if in SSH session (OSC52 handles it)
  opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
end)

opt.ignorecase = true  -- ignore case in search
opt.smartcase = true   -- override ignorecase if search has capitals

opt.timeoutlen = 300   -- shorter key-sequence timeout
opt.updatetime = 200   -- faster cursor-hold and diagnostics
