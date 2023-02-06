local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "folke/lua-dev.nvim",
    "MrcJkb/haskell-tools.nvim",
    "williamboman/mason.nvim",
    "SmiteshP/nvim-navic",
  },
  event = "BufEnter",
}

function M.config()
  require("neodev").setup {}

  require("nvim-navic").setup {
    highlight = true,
  }

  local function on_attach(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil

    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
    end

    require("user.plugins.lsp.keymaps").setup(client, bufnr)
    require("user.plugins.lsp.formatting").setup(client, bufnr)
    require("user.plugins.lsp.highlighting").setup(client, bufnr)
    require("user.plugins.lsp.codelens").setup(client, bufnr)
  end

  for server, opts in pairs(require "user.plugins.lsp.servers") do
    if opts then
      opts = vim.tbl_deep_extend("force", {}, {
        on_attach = on_attach,
        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
      }, type(opts) == "boolean" and {} or opts)
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
  end

  require("user.plugins.lsp.handlers").setup()
  require("user.plugins.lsp.diagnostic").setup()

  -- set border of LspInfo window
  require("lspconfig.ui.windows").default_options.border = "single"
end

return M
