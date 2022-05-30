local has_lsp, lspconfig = pcall(require, "lspconfig")
if not has_lsp then
  return
end

local lspconfig_util = require "lspconfig.util"

local ok, nvim_status = pcall(require, "lsp-status")
if not ok then
  nvim_status = nil
end

local telescope_mapper = require "kibadda.telescope.mappings"
local handlers = require "kibadda.lsp.handlers"

local ts_util = require "nvim-lsp-ts-utils"

local status = require "kibadda.lsp.status"
print("STATUS", status)
if status then
  status.activate()
end

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local filetype_attach = setmetatable({}, {
  __index = function()
    return function() end
  end,
})

local custom_attach = function(client)
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")

  if nvim_status then
    nvim_status.on_attach(client)
  end

  vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { buffer = 0 })

  vim.keymap.set("n", "<LEADER>cr", handlers.rename, { buffer = 0 })
  -- vim.keymap.set("n", "<LEADER>cr", vim.lsp.buf.rename, { buffer = 0 })
  vim.keymap.set("n", "<LEADER>ca", vim.lsp.buf.code_action, { buffer = 0 })

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
  vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })

  vim.keymap.set("n", "gI", handlers.implementation, { buffer = 0 })
  -- vim.keymap.set("n", "<LEADER>lr", "<CMD>lua R('kibadda.lsp.codelens').run()<CR>", { buffer = 0 })
  -- vim.keymap.set("n", "<LEADER>rr", "LspRestart", { buffer = 0 })

  telescope_mapper("gr", "lsp_references", nil, true)
  telescope_mapper("gI", "lsp_implementations", nil, true)
  telescope_mapper("<LEADER>wd", "lsp_document_symbols", { ignore_filename = true }, true)
  telescope_mapper("<LEADER>ww", "lsp_dynamic_workspace_symbols", { ignore_filename = true }, true)

  if filetype ~= "lua" then
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
  end

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  if client.server_capabilities.documentHighlightProvider then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end

  if client.server_capabilities.codeLensProvider then
    vim.cmd [[
      augroup lsp_document_codelens
        au! * <buffer>
        autocmd BufEnter ++once <buffer> lua require"vim.lsp.codelens".refresh()
        autocmd BufWritePost,CursorHold <buffer> lua require"vim.lsp.codelens".refresh()
      augroup END
    ]]
  end

  filetype_attach[filetype](client)
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
if nvim_status then
  updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, nvim_status.capabilities)
end
updated_capabilities.textDocument.codelens = { dynamicRegistation = false }
updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)

updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

local servers = {
  html = true,
  eslint = true,

  vimls = {
    cmd = { "/home/michael/.nvm/versions/node/v16.14.2/bin/vim-language-server", "--stdio" },
  },

  tsserver = {
    init_options = ts_util.init_options,
    cmd = { "/home/michael/.nvm/versions/node/v16.14.2/bin/typescript-language-server", "--stdio" },
    filetypes = {
      "javascript",
    },
    on_attach = function(client)
      custom_attach(client)
      ts_util.setup { auto_inlay_hints = false }
      ts_util.setup_client(client)
    end,
  },

  intelephense = {
    cmd = { "/home/michael/.nvm/versions/node/v16.14.2/bin/intelephense", "--stdio" },
    settings = {
      intelephense = {
        stubs = {
          "apache",
          "apcu",
          "bcmath",
          "bz2",
          "calendar",
          "com_dotnet",
          "Core",
          "ctype",
          "curl",
          "date",
          "dba",
          "dom",
          "enchant",
          "exif",
          "FFI",
          "fileinfo",
          "filter",
          "fpm",
          "ftp",
          "gd",
          "gettext",
          "gmp",
          "hash",
          "iconv",
          "imap",
          "intl",
          "json",
          "ldap",
          "libxml",
          "mbstring",
          "meta",
          "mysqli",
          "oci8",
          "odbc",
          "openssl",
          "pcntl",
          "pcre",
          "PDO",
          "pdo_ibm",
          "pdo_mysql",
          "pdo_pgsql",
          "pdo_sqlite",
          "pgsql",
          "Phar",
          "posix",
          "pspell",
          "readline",
          "Reflection",
          "session",
          "shmop",
          "SimpleXML",
          "snmp",
          "soap",
          "sockets",
          "sodium",
          "SPL",
          "sqlite3",
          "standard",
          "superglobals",
          "sysvmsg",
          "sysvsem",
          "sysvshm",
          "tidy",
          "tokenizer",
          "xml",
          "xmlreader",
          "xmlrpc",
          "xmlwriter",
          "xsl",
          "Zend OPcache",
          "zip",
          "zlib",
          "wordpress",
          "phpunit",
        },
        format = {
          braces = "k&r",
          insertSpaces = true,
          tabSize = 4,
        },
        diagnostics = {
          enable = true,
        },
        phpdoc = {
          textFormat = "text",
          functionTemplate = {
            summary = "$1",
            tags = {
              "@param ${1:$SYMBOL_TYPE} $SYMBOL_NAME",
              "@return ${1:$SYMBOL_TYPE}",
              "@throws ${1:$SYMBOL_TYPE}",
            },
          },
        },
      },
    },
  },
}

local setup_server = function(server, config)
  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
    flags = {
      debounce_text_changes = nil,
    },
  }, config)

  lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
  setup_server(server, config)
end

_ = require("nlua.lsp.nvim").setup(lspconfig, {
  on_init = custom_init,
  on_attach = custom_attach,
  capabilities = updated_capabilities,

  root_dir = function(fname)
    if string.find(vim.fn.fnamemodify(fname, ":p"), ".dotfiles/nvim/") then
      return vim.fn.expand "~/.dotfiles/nvim/"
    end

    return lspconfig_util.find_git_ancestor(fname) or lspconfig_util.path.dirname(fname)
  end,

  globals = {
    "Color",
    "c",
    "Group",
    "g",
    "s",

    "RELOAD",
  },

  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
      },
    },
  },
})

if pcall(require, "sg.lsp") then
  require("sg.lsp").setup {
    on_init = custom_init,
    on_attach = custom_attach,
  }
end

return {
  on_init = custom_init,
  on_attach = custom_attach,
  capabilities = updated_capabilities,
}
