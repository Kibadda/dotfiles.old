local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "folke/lua-dev.nvim",
    "MrcJkb/haskell-tools.nvim",
    "williamboman/mason.nvim",
  },
  event = "BufEnter"
}

function M.config()
  require("neodev").setup {}

  local function on_attach(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil

    require("user.plugins.lsp.keymaps").setup(client, bufnr)
    require("user.plugins.lsp.formatting").setup(client, bufnr)
    require("user.plugins.lsp.highlighting").setup(client, bufnr)
  end

  local servers = {
    intelephense = {
      settings = {
        intelephense = {
          -- stylua: ignore
          stubs = {
            "apache", "apcu", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype", "curl",
            "date", "dba", "dom", "enchant", "exif", "FFI", "fileinfo", "filter", "fpm", "ftp",
            "gd", "gettext", "gmp", "hash", "iconv", "imap", "intl", "json", "ldap", "libxml",
            "mbstring", "meta", "mysqli", "oci8", "odbc", "openssl", "pcntl", "pcre", "PDO",
            "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql", "Phar", "posix", "pspell",
            "readline", "Reflection", "session", "shmop", "SimpleXML", "snmp", "soap", "sockets",
            "sodium", "SPL", "sqlite3", "standard", "superglobals", "sysvmsg", "sysvsem",
            "sysvshm", "tidy", "tokenizer", "xml", "xmlreader", "xmlrpc", "xmlwriter", "xsl",
            "Zend OPcache", "zip", "zlib", "wordpress", "phpunit",
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
    sumneko_lua = {
      settings = {
        Lua = {
          format = {
            enable = false,
          },
          workspace = {
            checkThirdParty = false,
          },
        },
      },
    },
    cssls = {},
    vimls = {},
    tsserver = {},
    html = {},
    vls = {},
    bashls = {},
  }

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  local options = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  for server, opts in pairs(servers) do
    opts = vim.tbl_deep_extend("force", {}, options, opts or {})
    if server == "hls" then
      require("haskell-tools").setup {
        hls = {
          on_attach = on_attach,
        },
      }
    else
      require("lspconfig")[server].setup(opts)
    end
  end

  require("user.plugins.lsp.handlers").setup()
  require("user.plugins.lsp.diagnostic").setup()

  -- set border of LspInfo window
  require("lspconfig.ui.windows").default_options.border = "single"
end

function M.has_formatter(ft)
  local sources = require "null-ls.sources"
  local available = sources.get_available(ft, "NULL_LS_FORMATTING")
  return #available > 0
end

return M
