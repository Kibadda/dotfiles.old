-- local keymap = require 'lib.utils'.keymap

-- keymap('n', '<Leader>tnn', ':TestNearest<CR>', { silent = false })
-- keymap('n', '<Leader>tff', ':TestFile<CR>', { silent = false })
-- keymap('n', '<Leader>tss', ':TestSuite<CR>', { silent = false })
-- keymap('n', '<Leader>tll', ':TestLast<CR>', { silent = false })
-- keymap('n', '<Leader>tvv', ':TestVisit<CR>', { silent = false })

-- keymap('n', '<Leader>tnb', ':TestNearest --browse<CR>', { silent = false })
-- keymap('n', '<Leader>tfb', ':TestFile --browse<CR>', { silent = false })
-- keymap('n', '<Leader>tlb', ':TestLast --browse<CR>', { silent = false })

-- keymap('n', '<Leader>tfc', ':TestFile  --coverage<CR>', { silent = false })
-- keymap('n', '<Leader>tsc', ':TestSuite  --coverage<CR>', { silent = false })
-- keymap('n', '<Leader>tlc', ':TestLast  --coverage<CR>', { silent = false })

-- vim.cmd([[
--   let test#php#phpunit#executable = 'XDEBUG_MODE=coverage vendor/bin/pest'
--   let test#php#pest#executable = 'XDEBUG_MODE=coverage vendor/bin/pest'
--   let test#php#dusk#executable = 'XDEBUG_MODE=coverage php artisan pest:dusk'

--   function! FloatermStrategy(cmd)
--     execute 'FloatermKill scratch'
--     execute 'FloatermNew! --autoclose=2 --name=scratch '.a:cmd.' |less -X'
--   endfunction
--   let g:test#custom_strategies = {'floaterm': function('FloatermStrategy')}
--   let g:test#strategy = 'floaterm'
-- ]])
