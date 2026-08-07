dofile(vim.g.base46_cache .. "git")

return {
  -- signs = {
  --   add = { text = "+" },
  --   change = { text = "~" },
  --   delete = { text = "_" },
  --   topdelete = { text = "‾" },
  --   changedelete = { text = "~" },
  --   untracked = { text = "+" },
  -- },
  -- signs_staged = {
  --   add = { text = "+" },
  --   change = { text = "~" },
  --   delete = { text = "_" },
  --   topdelete = { text = "‾" },
  --   changedelete = { text = "~" },
  -- },
  signs = {
    delete = { text = "_" },
    changedelete = { text = "~" },
  },
}
