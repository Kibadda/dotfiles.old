if not plugins_ok { "lspconfig", "mason", "mason-lspconfig" } then
  return
end

require("mason").setup {
  ui = {
    border = "single",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
}
require("mason-lspconfig").setup {
  ensure_installed = {
    "sumneko_lua",
    "intelephense",
    "cssls",
    "vimls",
    "html",
    "tsserver",
    "hls",
    "vls",
    "bashls",
  },
}

if plugins_ok { "mason-null-ls", "null-ls" } then
  local null_ls = require "null-ls"
  require("mason-null-ls").setup {
    ensure_installed = {
      "stylua",
      "beautysh",
    },
    automatic_installation = true,
  }
  require("mason-null-ls").setup_handlers {
    stylua = function()
      null_ls.register(null_ls.builtins.formatting.stylua)
    end,
    beautysh = function()
      null_ls.register(null_ls.builtins.formatting.beautysh.with {
        extra_args = function(params)
          return params.options
            and params.options.tabSize
            and {
              "-i",
              params.options.tabSize,
            }
        end,
      })
    end,
  }
  null_ls.setup {}
end

require("user.utils.register").keymaps {
  mode = "n",
  prefix = "<Leader>",
  {
    l = {
      name = "Lsp",
      M = { "<Cmd>Mason<CR>", "Mason" },
      L = { "<Cmd>LspInfo<CR>", "LspInfo" },
      t = { require("user.auto_format").toggle, "Toggle Auto Format" },
    },
  },
}

local handlers = require "user.lsp.handlers"
handlers.publishDiagnostics()
handlers.hoverBorderStyle()
handlers.showMessage()

if plugins_ok "neodev" then
  require("neodev").setup {}
end

require("user.lsp.servers").setup()

if plugins_ok "haskell-tools" then
  require("haskell-tools").setup {
    hls = {
      on_attach = require("user.lsp").get_on_attach(),
    },
  }
end

-- set border of LspInfo window
require("lspconfig.ui.windows").default_options.border = "single"
