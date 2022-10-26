local server_list = {
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
  cssls = true,
  vimls = true,
  tsserver = true,
  -- hls = true,
  html = true,
  vls = true,
  bashls = true,
}

local function setup_server(options)
  local lspconfig = require "lspconfig"
  local config = options.config

  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {
    on_attach = options.custom_attach,
    capabilities = options.capabilities,
  }, config)

  lspconfig[options.server].setup(config)
end

local M = {}

---setup all configured servers
function M.setup()
  local lsp = require "user.lsp"
  local attach = lsp.get_on_attach()
  local capabilities = lsp.get_capabilities()

  for server, config in pairs(server_list) do
    setup_server {
      server = server,
      config = config,
      custom_attach = attach,
      capabilities = capabilities,
    }
  end
end

return M
