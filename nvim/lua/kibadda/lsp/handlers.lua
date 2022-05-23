local override = require "kibadda.lsp.override"

vim.lsp.handlers["textDocument/definition"] = function (_, result)
  if not result or vim.tbl_isempty(result) then
    print "[LSP] Could not find definition"
    return
  end

  if vim.tbl_islist(result) then
    vim.lsp.util.jump_to_location(result[1], "utf-8")
  else
    vim.lsp.util.jump_to_location(result, "utf-8")
  end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.handlers["textDocument/publishDiagnostics"], {
    signs = {
      severity_limit = "Error",
    },
    underline = {
      severity_limit = "Warning",
    },
    virtual_text = true,
  })

vim.lsp.handlers["window/showMessage"] = require "kibadda.lsp.show_message"

local M = {}

function M.implementation ()
  local params = vim.lsp.utils.make_position_params()

  vim.lsp.buf_request(0, "textDocument/implementation", params, function (err, result, ctx, config)
    vim.lsp.handlers["textDocument/implementation"](err, result, ctx, config)
    vim.cmd [[normal! zz]]
  end)
end

-- vim.lsp.codelens.display = require("gl.codelens").display

return M
