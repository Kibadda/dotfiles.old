vim.g.dashboard_custom_header = {
  '',
  "  _  ___ _               _     _       ",
  " | |/ (_) |__   __ _  __| | __| | __ _ ",
  " | ' /| | '_ \\ / _` |/ _` |/ _` |/ _` |",
  " | . \\| | |_) | (_| | (_| | (_| | (_| |",
  " |_|\\_\\_|_.__/ \\__,_|\\__,_|\\__,_|\\__,_|",
  "                                       ",
  "",
}

vim.g.dashboard_custom_section = {
  a = { description = { '  New file                       ' }, command = 'enew' },
  b = { description = { '  Find file                 SPC f' }, command = 'Telescope find_files' },
  c = { description = { '  Recent files              SPC h' }, command = 'Telescope oldfiles' },
  d = { description = { '  Find Word                 SPC r' }, command = 'Telescope live_grep' },
  e = { description = { '  Find Session              SPC S' }, command = 'Telescope session-lens search_session' },
}

vim.g.dashboard_custom_footer = {
  '',
}
