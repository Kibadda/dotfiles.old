if not vim.g.loaded_startify then
  return
end

vim.g.startify_session_persistence = true

vim.g.startify_custom_header = vim.fn["startify#pad"] {
  "",
  "██╗  ██╗██╗██████╗  █████╗ ██████╗ ██████╗  █████╗",
  "██║ ██╔╝██║██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔══██╗",
  "█████╔╝ ██║██████╔╝███████║██║  ██║██║  ██║███████║",
  "██╔═██╗ ██║██╔══██╗██╔══██║██║  ██║██║  ██║██╔══██║",
  "██║  ██╗██║██████╔╝██║  ██║██████╔╝██████╔╝██║  ██║",
  "╚═╝  ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚═╝  ╚═╝",
  "",
}