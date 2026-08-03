local map = vim.keymap.set

-- Better yank entire buffer
map("n", "yig", "<cmd>%y<cr>", { desc = "Yank inner global (persist cursor position)" })

-- Better mark navigation
map({ "n", "x", "o" }, "gm", function()
  return "`" .. vim.fn.getcharstr()
end, { desc = "Goto mark (exact)", expr = true, silent = true })

map({ "n", "x", "o" }, "gM", function()
  return "'" .. vim.fn.getcharstr()
end, { desc = "Goto mark (line start)", expr = true, silent = true })

-- Delete mark
map("n", "dm", function()
  local char = vim.fn.getcharstr()
  vim.cmd("delmarks " .. char)
end, { desc = "Delete mark", silent = true })

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { desc = "Next Search Result", expr = true })
map("x", "n", "'Nn'[v:searchforward]", { desc = "Next Search Result", expr = true })
map("o", "n", "'Nn'[v:searchforward]", { desc = "Next Search Result", expr = true })
map("n", "N", "'nN'[v:searchforward].'zv'", { desc = "Prev Search Result", expr = true })
map("x", "N", "'nN'[v:searchforward]", { desc = "Prev Search Result", expr = true })
map("o", "N", "'nN'[v:searchforward]", { desc = "Prev Search Result", expr = true })

-- NORMAL MODE: keep cursor in place after search
map("n", "*", "*N", { silent = true }) -- highlight word under cursor, stay on it
map("n", "#", "#N", { silent = true }) -- same for backwards search

-- VISUAL MODE: search for selection and reselect
map("v", "*", '"vy/<C-r>v<CR>gv', { silent = true }) -- search forward for visual selection, reselect it
map("v", "#", '"vy?<C-r>v<CR>gv', { silent = true }) -- search backward for visual selection, reselect it

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Bypass comment continuation
local function open_line_no_comment(cmd)
  return function()
    local fo = vim.opt.formatoptions:get()

    -- temporarily disable comment continuation
    vim.opt.formatoptions:remove("o")

    -- simulate real keypress (o or O)
    local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
    vim.api.nvim_feedkeys(keys, "n", false)

    -- restore after execution
    vim.schedule(function()
      vim.opt.formatoptions = fo
    end)
  end
end

map("n", "go", open_line_no_comment("o"))
map("n", "gO", open_line_no_comment("O"))
