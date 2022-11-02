local M = {}

---change border style of hover handler
-- function M.hoverBorderStyle()
--   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
--     border = "single",
--   })
-- end

---lsp messages send to buffer
-- function M.showMessage()
--   vim.lsp.handlers["window/showMessage"] = require "user.lsp.show_message"
-- end

---update publish diagnostics settings
function M.publishDiagnostics()
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
end

---filter out framework results if at least one other result is found
function M.definition()
  local params = vim.lsp.util.make_position_params(0, "utf-8")
  vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, ...)
    if #result > 1 then
      local new_result = vim.tbl_filter(function(v)
        return string.match(v.targetUri, "framework") == nil
      end, result)

      if #new_result > 0 then
        result = new_result
      end
    end

    vim.lsp.handlers["textDocument/definition"](err, result, ...)
  end)
end

---rename and open qflist with all renamed positions
function M.rename()
  local params = vim.lsp.util.make_position_params(0, "utf-8")
  vim.ui.input({ prompt = "New Name (with QF): ", default = vim.fn.expand "<cword>" }, function(new_name)
    if not new_name then
      return
    end
    params.newName = new_name
    vim.lsp.buf_request(0, "textDocument/rename", params, function(err, result, ...)
      vim.lsp.handlers["textDocument/rename"](err, result, ...)

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
      vim.cmd.copen()
    end)
  end)
end

return M
