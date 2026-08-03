return {
  "nvim-mini/mini.ai",
  vscode = true,
  version = "*",
  config = function()
    local mini_ai = require('mini.ai')
    local spec_pair = mini_ai.gen_spec.pair

    mini_ai.setup({
      n_lines = 500,
      mappings = {
        around_last = 'aN',
        inside_last = 'iN',
      },
      custom_textobjects = {
        ['*'] = spec_pair('*', '*', { type = 'greedy' }),
        ['_'] = spec_pair('_', '_', { type = 'greedy' }),
        r = spec_pair('[', ']', { type = 'balanced' }),
        g = function()
          return { from = { line = 1, col = 1 }, to = { line = vim.fn.line("$"), col = 1 } }
        end,
        l = function()
          local line = vim.api.nvim_win_get_cursor(0)[1]

          local first = vim.fn.match(vim.fn.getline(line), "\\S") + 1
          local last = vim.fn.matchend(vim.fn.getline(line), "\\S.*")

          if first == 0 then return nil end -- empty line

          return {
            from = { line = line, col = first },
            to   = { line = line, col = last },
          }
        end,
      }
    })
  end
}
