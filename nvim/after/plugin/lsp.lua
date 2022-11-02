if not PluginsOk { "lspconfig", "mason", "mason-lspconfig" } then
  return
end

require("mason").setup {
  ui = {
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

if PluginsOk { "mason-null-ls", "null-ls" } then
  local null_ls = require "null-ls"
  require("mason-null-ls").setup {
    ensure_installed = {
      "stylua",
    },
    automatic_installation = true,
  }
  require("mason-null-ls").setup_handlers {
    stylua = function()
      null_ls.register(null_ls.builtins.formatting.stylua)
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

require("user.lsp.handlers").publishDiagnostics()

if PluginsOk "neodev" then
  require("neodev").setup {}
end

require("user.lsp.servers").setup()

require("haskell-tools").setup {
  hls = {
    on_attach = require("user.lsp").get_on_attach(),
  },
}
