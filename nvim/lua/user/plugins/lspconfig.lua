local buf_option = vim.api.nvim_buf_set_option
local buf_keymap = require 'lib.utils'.buf_keymap

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
  require 'lsp-format'.on_attach(client)
  buf_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  buf_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  buf_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  buf_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  buf_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  -- buf_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  buf_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  buf_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  -- buf_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  buf_keymap(bufnr, 'n', 'gr', ':Telescope lsp_references<CR>')

  -- buf_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  -- buf_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>')
  -- buf_keymap(bufnr, 'n', '<leader>ca', ':Telescope lsp_code_actions<CR>')
  -- buf_keymap(bufnr, 'v', '<leader>ca', ':Telescope lsp_range_code_actions<CR>')
  buf_keymap(bufnr, 'n', '<leader>ca', ':CodeActionMenu<CR>')
  buf_keymap(bufnr, 'v', '<leader>ca', ':CodeActionMenu<CR>')

  buf_keymap(bufnr, 'n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
  buf_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
  buf_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
  -- buf_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
  -- buf_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])
  -- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  -- vim.cmd [[ autocmd BufWritePre * lua vim.lsp.buf.formatting_sync() ]]
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
      format = {
        braces = 'k&r',
        -- insertSpaces = true,
        -- tabSize = 4,
      }
    }
  }
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
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = { 'vim' },
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
vim.notify = function(msg, log_level, _)
  if msg:match 'exit code' then
    return
  end
  if log_level == vim.log.levels.ERROR then
    vim.api.nvim_err_writeln(msg)
  else
    vim.api.nvim_echo({ { msg } }, true, {})
  end
end
