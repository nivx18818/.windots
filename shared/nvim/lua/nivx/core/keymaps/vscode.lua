local map = vim.keymap.set
local vscode = require("vscode")
local vscode_neovim = require("vscode-neovim")

-- Tell VSCode Neovim to treat `r` as operator-pending mode
map({ "n", "x" }, "r", function()
  vscode_neovim.call("setContext", {
    args = { "neovim.fullMode", "no" },
  })

  vim.schedule(function()
    vscode_neovim.call("setContext", {
      args = { "neovim.fullMode", vim.fn.mode(1) },
    })
  end)

  return "r"
end, { expr = true })

-- Better up and down
-- Fix folds were automatically opening when navigating with j, k
map("n", "j", function()
  if vim.v.count == 0 then
    vscode.action("cursorDown")
  else
    return "j"
  end
end, { expr = true })

map("n", "k", function()
  if vim.v.count == 0 then
    vscode.action("cursorUp")
  else
    return "k"
  end
end, { expr = true })

-- Clear search highlight on escape
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Go to references via VS Code command
map("n", "gr", function() vim.fn.VSCodeNotify("editor.action.goToReferences") end, { silent = true })

-- Helper for fold-related mappings
-- Allow repeating with `.`
local function fold(lhs, vscode_cmd, desc)
  map("n", lhs, function()
    local op = vscode.to_op(function(ctx)
      vscode.action(vscode_cmd, { range = ctx.range })
    end)
    return op() .. "_"
  end, { expr = true, desc = desc })
end

fold("zc", "editor.fold", "Close fold")
fold("zo", "editor.unfold", "Open fold")
fold("za", "editor.toggleFold", "Toggle fold")

fold("zC", "editor.foldRecursively", "Close recursively")
fold("zO", "editor.unfoldRecursively", "Open recursively")

fold("zm", "editor.foldAll", "Close all")
fold("zr", "editor.unfoldAll", "Open all")

fold("zb", "editor.foldAllBlockComments", "Close all block comments")
fold("zg", "editor.foldAllMarkerRegions", "Close all regions")
fold("zG", "editor.unfoldAllMarkerRegions", "Open all regions")
