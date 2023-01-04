local M = {}

function M.setup(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    local LspDocumentHighlight = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })
    vim.api.nvim_clear_autocmds {
      group = LspDocumentHighlight,
      buffer = bufnr,
    }
    vim.api.nvim_create_autocmd("CursorHold", {
      group = LspDocumentHighlight,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = LspDocumentHighlight,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

return M
