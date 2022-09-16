local M = {}

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

return M
