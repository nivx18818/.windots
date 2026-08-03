return {
  "rcarriga/nvim-notify",
  opts = {
    stages = "fade_in_slide_out",
    timeout = 3000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
    background_colour = "#00000000",
    render = "compact",
    top_down = false,
  }
}
