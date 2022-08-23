if not pcall(require, "mason") then
  return
end

require("mason").setup {}
require("mason-lspconfig").setup {
  ensure_installed = {
    "sumneko_lua",
    "intelephense",
    "cssls",
    "vimls",
  },
}

RegisterKeymaps("n", "<Leader>", {
  M = { "<Cmd>Mason<CR>", "Mason" },
  l = {
    name = "Lsp",
    t = { "<Cmd>ToggleAutoFormat<CR>", "Toggle Auto Format" },
  },
})

if not vim.fn.exists "g:lsp_auto_format" then
  vim.g.lsp_auto_format = 0
end

local custom_attach = function(client)
  RegisterKeymaps("n", "", {
    K = { vim.lsp.buf.hover, "Hover" },
    ["gd"] = { vim.lsp.buf.definition, "Definition" },
    ["gr"] = { "<Cmd>Telescope lsp_references<CR>", "References" },
  }, { buffer = 0 })

  RegisterKeymaps("n", "<Leader>", {
    l = {
      name = "Lsp",
      c = { vim.lsp.buf.code_action, "Code Action" },
      f = { vim.lsp.buf.format, "Format" },
      j = { vim.diagnostic.goto_next, "Next Diagnostic" },
      k = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
      d = { "<Cmd>Telescope diagnostics bufnr=0<CR>", "Show Buffer Diagnostics" },
      w = { "<Cmd>Telescope diagnostics<CR>", "Show Diagnostics" },
      r = { vim.lsp.buf.rename, "Rename" },
      i = { "<Cmd>LspInfo<CR>", "Lsp Info" },
    },
  }, { buffer = 0 })

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  if client.server_capabilities.documentHighlightProvider then
    vim.cmd [[
      augroup LspDocumentHighlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
    pattern = "*",
    callback = function()
      if vim.g.lsp_auto_format == 1 then
        vim.lsp.buf.format()
      end
    end,
  })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local lspconfig = require "lspconfig"

local servers = {
  intelephense = true,
  cssls = true,
  vimls = true,
  tsserver = true,
}

local setup_server = function(server, config)
  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {
    on_attach = custom_attach,
    capabilities = capabilities,
  }, config)

  lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
  setup_server(server, config)
end

local luadev = require("lua-dev").setup {
  lspconfig = {
    on_attach = custom_attach,
    capabilities = capabilities,
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
}

lspconfig.sumneko_lua.setup(luadev)

require("null-ls").setup {
  sources = {
    require("null-ls").builtins.formatting.stylua,
  },
}
