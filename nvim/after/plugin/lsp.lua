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

RegisterKeymaps {
  mode = "n",
  prefix = "<Leader>",
  {
    l = {
      name = "Lsp",
      M = { "<Cmd>Mason<CR>", "Mason" },
      L = { "<Cmd>LspInfo<CR>", "LspInfo" },
      t = { "<Cmd>ToggleAutoFormat<CR>", "Toggle Auto Format" },
      p = { "<Cmd>ToggleProgressNotifications<CR>", "Toggle Progress Notifications" },
    },
  },
}

if not vim.fn.exists "g:lsp_auto_format" then
  SetGlobal("lsp", {
    auto_format = false,
  })
end

if not vim.fn.exists "g:lsp_progress_notifications" then
  SetGlobal("lsp", {
    progress_notifications = false,
  })
end

local handlers = require "user.lsp.handlers"
handlers.hoverBorderStyle()
handlers.showMessage()
handlers.publishDiagnostics()

if PluginsOk "neodev" then
  require("neodev").setup {}
end

if PluginsOk "lsp_signature" then
  require("lsp_signature").setup {
    handler_opts = {
      border = "single",
    },
    floating_window = false,
    hint_enable = false,
    toggle_key = "<M-x>",
  }
end

require("user.lsp.servers").setup()
