return {
  "vyfor/cord.nvim",
  build = ":Cord update",
  opts = {
    variables = {
      foldername = function()
        local file = vim.fn.expand("%:p")
        return file ~= "" and vim.fn.fnamemodify(file, ":h:t") or ""
      end,
    },
    text = {
      default = nil,
      workspace = "📂 Workspace: ${workspace}",
      viewing = "👀 Viewing ${filename}",
      editing = "🔧 Editing ${foldername}/${filename}",
      file_browser = "🗃️ Browsing files: ${name}",
      plugin_manager = "🔌 Managing plugins: ${name}",
      lsp = "🧠 Configuring LSP: ${name}",
      docs = "📖 Reading ${name}",
      vcs = "🪶 Committing changes: ${name}",
      notes = "📝 Taking notes: ${name}",
      debug = "🐞 Debugging: ${name}",
      test = "🧪 Testing: ${name}",
      diagnostics = "🛠️ Fixing problem: ${name}",
      games = "🎴 Playing ${name}",
      terminal = "⌨️ Running command: ${name}",
      dashboard = "⛩️ Home",
    },
  }
}
