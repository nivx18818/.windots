return {
  "kylechui/nvim-surround",
  vscode = true,
  version = "*",
  event = "VeryLazy",
  opts = {
    aliases = {
      ["a"] = ">",
      ["b"] = ")",
      ["B"] = "}",
      ["r"] = "]",
      ["q"] = { '"', "'", "`" },
      ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
    },
  },
  keys = {
    {
      "gs",
      "<Plug>(nvim-surround-normal)",
      mode = "n",
      desc = "Add a surrounding pair around a motion (normal mode)",
    },
    {
      "gss",
      "<Plug>(nvim-surround-normal-cur)",
      mode = "n",
      desc = "Add a surrounding pair around the current line (normal mode)",
    },
    {
      "gS",
      "<Plug>(nvim-surround-normal-line)",
      mode = "n",
      desc = "Add a surrounding pair around a motion, on new lines (normal mode)",
    },
    {
      "gSS",
      "<Plug>(nvim-surround-normal-cur-line)",
      mode = "n",
      desc = "Add a surrounding pair around the current line, on new lines (normal mode)",
    },
    {
      "gs",
      "<Plug>(nvim-surround-visual)",
      mode = "x",
      desc = "Add a surrounding pair around a visual selection",
    },
  },
}
