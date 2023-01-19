local M = {}

local LspCodeLens = vim.api.nvim_create_augroup("LspCodeLens", { clear = false })

function M.setup(client, bufnr)
  if client.server_capabilities.codeLensProvider then
    vim.api.nvim_clear_autocmds {
      group = LspCodeLens,
      buffer = bufnr,
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      group = LspCodeLens,
      buffer = bufnr,
      callback = vim.lsp.codelens.refresh,
    })
  end
end

return M
