dofile(vim.g.base46_cache .. "telescope")

return {
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ",
    entry_prefix = " ",
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      width = 0.87,
      height = 0.80,
    },
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },

  pickers = {
    find_files = {
      find_command = {
        "fd",
        "--type", "f",
        "--hidden",
        "--no-ignore",
        "--exclude", ".git",
        "--exclude", "node_modules",
        "--exclude", "dist",
        "--exclude", "build",
        "--exclude", ".next",
        "--exclude", ".turbo",
        "--exclude", "coverage",
        "--exclude", "plugins",
      },
    },
  },

  extensions_list = { "themes", "terms" },
  extensions = {},
}
