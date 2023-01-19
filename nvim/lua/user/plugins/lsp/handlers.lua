local M = {}

local function definition()
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

function M.setup()
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
    title = " Documentation ",
  })

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

  vim.lsp.buf.definition = definition

  -- local old = vim.lsp.codelens.on_codelens
  -- vim.lsp.codelens.on_codelens = function(err, result, ctx, ...)
  --   local lenses = vim.lsp.codelens.get(ctx.bufnr)
  --   if #lenses > 0 then
  --     for _, lens in ipairs(vim.lsp.codelens.get(ctx.bufnr)) do
  --       for _, j in ipairs(result) do
  --         if lens.data.id ==
  --       end
  --       table.insert(result, lens)
  --     end
  --   end

  --   old(err, result, ctx, ...)
  -- end
end

return M
