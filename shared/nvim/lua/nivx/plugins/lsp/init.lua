return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      "saghen/blink.cmp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
        vim.bo[bufnr].swapfile = false
      end
      local servers = {
        -- Core for TypeScript/JavaScript
        "tsserver",
        "eslint",

        -- Web frontend essentials
        "html",
        "cssls",
        "tailwindcss",

        -- General purpose / config files
        "jsonls",
        "yamlls",
        "marksman", -- For your README.md and other markdown files

        -- For Neovim config development
        "lua_ls",
      }

      mason_lspconfig.setup({
        ensure_installed = servers,
      })

      for _, server_name in ipairs(servers) do
        lspconfig[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
          },
        },
      })
    end,
    keys = {
      { "gD", vim.lsp.buf.declaration, desc = "Go to Declaration" },
      { "gd", vim.lsp.buf.definition, desc = "Go to Definition" },
      { "K", vim.lsp.buf.hover, desc = "Hover Diagnostics" },
      { "gi", vim.lsp.buf.implementation, desc = "Go to Implementation" },
      { "gy", vim.lsp.buf.type_definition, desc = "Go to Type Definition" },
      { "gr", vim.lsp.buf.references, desc = "Show References" },
      { "<C-k>", vim.lsp.buf.signature_help, desc = "Signature Help" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
      { "<leader>rn", vim.lsp.buf.rename, desc = "Rename Symbol" },
      {
        "<leader>cf",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Format Code",
      },
      { "<leader>dn", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
      { "<leader>dp", vim.diagnostic.goto_prev, desc = "Previous Diagnostic" },
      { "<leader>dl", "<cmd>Telescope diagnostics<cr>", desc = "Show Document Diagnostics" },
    },
  },
}
