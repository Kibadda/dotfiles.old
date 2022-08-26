local override = require "kibadda.lsp.override"

vim.lsp.handlers["textDocument/definition"] = function(_, result)
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

function M.implementation()
  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request(0, "textDocument/implementation", params, function(err, result, ctx, config)
    vim.lsp.handlers["textDocument/implementation"](err, result, ctx, config)
    vim.cmd [[normal! zz]]
  end)
end

function M.rename()
  local params = vim.lsp.util.make_position_params()
  local new_name = vim.fn.input "New Name: "

  params.newName = new_name

  vim.lsp.buf_request(0, "textDocument/rename", params, function(err, result, ctx, config)
    if false then
      P(result)
    end
    vim.lsp.handlers["textDocument/rename"](err, result, ctx, config)

    local entries = {}
    if result.changes then
      for uri, edits in pairs(result.changes) do
        local bufnr = vim.uri_to_bufnr(uri)

        for _, edit in ipairs(edits) do
          local start_line = edit.range.start.line + 1
          local line = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, start_line, false)[1]

          table.insert(entries, {
            bufnr = bufnr,
            lnum = start_line,
            col = edit.range.start.character + 1,
            text = line,
          })
        end
      end
    end

    vim.fn.setqflist(entries, "r")
  end)
end

-- vim.lsp.codelens.display = require("gl.codelens").display

return M
