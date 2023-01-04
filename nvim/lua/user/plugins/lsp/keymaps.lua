local M = {}

function M.setup(client, bufnr)
  require("user.utils.register").keymaps {
    mode = "n",
    prefix = "",
    buffer = bufnr,
    {
      K = { vim.lsp.buf.hover, "Hover" },
      gd = { vim.lsp.buf.definition, "Definition" },
      gr = { "<Cmd>Telescope lsp_references<CR>", "References" },
    },
  }

  require("user.utils.register").keymaps {
    mode = "n",
    prefix = "<Leader>",
    buffer = bufnr,
    {
      l = {
        c = { vim.lsp.buf.code_action, "Code Action" },
        f = { vim.lsp.buf.format, "Format" },
        j = { vim.diagnostic.goto_next, "Next Diagnostic" },
        k = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
        r = { vim.lsp.buf.rename, "Rename" },
        l = { vim.lsp.codelens.run, "Codelens" },
        d = { "<Cmd>Telescope diagnostics bufnr=0<CR>", "Show Buffer Diagnostics" },
        w = { "<Cmd>Telescope diagnostics<CR>", "Show Diagnostics" },
        R = { "<Cmd>LspRestart<CR>", "Restart" },
        D = { "<Cmd>Telescope lsp_document_symbols<CR>", "Symbols" },
      },
    },
  }
end

return M
