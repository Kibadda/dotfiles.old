vim.diagnostic.config {
  virtual_text = false,
  severity_sort = true,
  float = {
    source = true,
    focus = false,
    format = function(diagnostic)
      if diagnostic.user_data ~= nil and diagnostic.user_data.lsp.code ~= nil then
        return string.format("%s: %s", diagnostic.user_data.lsp.code, diagnostic.message)
      end
      return diagnostic.message
    end,
  }
}

local on_attach = function(client, bufnr)
  -- require 'lsp-format'.on_attach(client)

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr })
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { buffer = bufnr })
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr })
  vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>', { buffer = bufnr })

  vim.keymap.set('n', '<leader>ca', ':CodeActionMenu<CR>', { buffer = bufnr })
  vim.keymap.set('v', '<leader>ca', ':CodeActionMenu<CR>', { buffer = bufnr })

  vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { buffer = bufnr })
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = bufnr })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = bufnr })
end

-- nvim-cmp supports additional completion capabilities
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require'lspconfig'.intelephense.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { '/home/michael/.nvm/versions/node/v16.14.2/bin/intelephense', '--stdio' },
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    intelephense = {
      stubs = {
        'apache', 'bcmath', 'bz2', 'calendar', 'com_dotnet', 'Core', 'ctype', 'curl', 'date',
        'dba', 'dom', 'enchant', 'exif', 'FFI', 'fileinfo', 'filter', 'fpm', 'ftp', 'gd', 'gettext',
        'gmp', 'hash', 'iconv', 'imap', 'intl', 'json', 'ldap', 'libxml', 'mbstring', 'meta', 'mysqli',
        'oci8', 'odbc', 'openssl', 'pcntl', 'pcre', 'PDO', 'pdo_ibm', 'pdo_mysql', 'pdo_pgsql', 'pdo_sqlite', 'pgsql',
        'Phar', 'posix', 'pspell', 'readline', 'Reflection', 'session', 'shmop', 'SimpleXML', 'snmp', 'soap',
        'sockets', 'sodium', 'SPL', 'sqlite3', 'standard', 'superglobals', 'sysvmsg', 'sysvsem', 'sysvshm', 'tidy',
        'tokenizer', 'xml', 'xmlreader', 'xmlrpc', 'xmlwriter', 'xsl', 'Zend OPcache', 'zip', 'zlib',
        'wordpress', 'phpunit',
      },
      format = {
        braces = 'k&r',
        insertSpaces = true,
        tabSize = 4,
      },
      diagnostics = {
        enable = true,
      },
    },
  },
}

require'lspconfig'.tsserver.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { '/home/michael/.nvm/versions/node/v16.14.2/bin/typescript-language-server', '--stdio' },
  flags = {
    debounce_text_changes = 150,
  },
}

require'lspconfig'.eslint.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { '/home/michael/.nvm/versions/node/v16.14.2/bin/vscode-eslint-language-server', '--stdio' },
  flags = {
    debounce_text_changes = 150,
  },
  handlers = {
    ['window/showMessageRequest'] = function(_, result, _) return result end,
  },
}

require'lspconfig'.html.setup{
  capabilities = capabilities,
  cmd = { '/home/michael/.nvm/versions/node/v16.14.2/bin/vscode-html-language-server', '--stdio' },
  flags = {
    debounce_text_changes = 150,
  },
  filetypes = { 'html', 'php', 'smarty' },
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
require'lspconfig'.sumneko_lua.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  cmd = { '/usr/bin/lua-language-server', '-E', '/usr/lib/lua-language-server/main.lua' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      -- library = vim.api.nvim_get_runtime_file('', true),
    },
    telemetry = {
      enable = false,
    },
  },
}

-- require'lspconfig'.efm.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   flags = {
--     debounce_text_changes = 150,
--   },
--   init_options = {
--     documentFormatting = true,
--   },
--   settings = {
--     rootMarkers = {'.git/'},
--     languages = {
--       markdown = {
--         {lintCommand = 'markdownlint', lintStdin = true},
--       },
--     }
--   }
-- }

vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

-- suppress error messages from lang servers
-- vim.notify = function(msg, log_level, _)
--   if msg:match 'exit code' then
--     return
--   end
--   if log_level == vim.log.levels.ERROR then
--     vim.api.nvim_err_writeln(msg)
--   else
--     vim.api.nvim_echo({ { msg } }, true, {})
--   end
-- end
