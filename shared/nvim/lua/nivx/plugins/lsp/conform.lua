return { -- Autoformat
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  lazy = true,
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({{ async = true, lsp_format = "fallback" }})
      end,
      mode = { "n", "v" },
      desc = "Format",
    },
  },
  opts = {
    default_format_opts = {
      timeout_ms = 3000,
      async = false,
      quite = false,
      lsp_format = "fallback",
      try_node_executable = true,
    },
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettier", "prettierd", stop_after_first = true },
    },
    formatters = {
      injected = { options = { ignore_errors = true } },
    },
    -- notify_on_error = false,
    format_on_save = false,
    -- format_on_save = function(bufnr)
    --   local disable_filetypes = {}
    --   if disable_filetypes[vim.bo[bufnr].filetype] then
    --     return nil
    --   else
    --     return {
    --       timeout_ms = 500,
    --       lsp_format = "fallback",
    --     }
    --   end
    -- end,
    mason_install = true,
  },
}
