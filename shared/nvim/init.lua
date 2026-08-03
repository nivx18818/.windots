_G.Utils = require("nivx.core.utils")

-- This is the bootstrap code for lazy.nvim (the plugin manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end

vim.opt.rtp:prepend(lazypath)

-- Load core settings before plugins
require("nivx.core.options")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  group = vim.api.nvim_create_augroup("CoreConfig", { clear = true }),
  callback = function()
    require("nivx.core.keymaps")
    require("nivx.core.autocmds")
  end,
})

require("lazy").setup("nivx.plugins", {
  defaults = {
    cond = function(plugin)
      if vim.g.vscode then
        return plugin.vscode == true -- only load plugins explicitly marked for vscode
      end
      return true
    end,
  },
  ui = {
    change_detection = {
      enabled = false,
      notify = false,
    },
  },
})
