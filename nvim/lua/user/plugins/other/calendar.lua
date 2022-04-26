local keymap = require 'lib.utils'.keymap

vim.g.calendar_google_calendar = 1
vim.g.calendar_google_tasks = 1
vim.g.calendar_locale = 'Germany'
vim.g.calendar_first_day = 'monday'
vim.g.calendar_view = 'week'
vim.g.calendar_date_endian = 'little'
vim.g.calendar_date_separator = '.'
vim.g.calendar_week_number = 1

vim.cmd [[ autocmd FileType calendar :IndentBlanklineDisable ]]
keymap('n', '<leader>C', ':Calendar<CR>')

require('user.external.calendar-credentials')
