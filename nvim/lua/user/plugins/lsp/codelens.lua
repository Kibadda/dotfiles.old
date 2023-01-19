local M = {}

function M.setup(client, bufnr)
  if client.server_capabilities.codeLensProvider then
    if vim.endswith(vim.fn.fnamemodify(vim.fn.expand "%", ":h"), "user/plugins") then
      vim.lsp.commands["kibadda-plugin-open"] = function(command)
        vim.pretty_print(command)
      end

      local lenses = {
        {
          range = {
            start = {
              line = 0,
              character = 1,
            },
            ["end"] = {
              line = vim.fn.line "$",
              character = 1,
            },
          },
          command = {
            title = "Open Plugin",
            command = "kibadda-plugin-open",
            arguments = {},
          },
          data = {
            id = 1000,
            uri = vim.uri_from_bufnr(bufnr),
          },
        },
      }

      vim.lsp.codelens.save(lenses, bufnr, client.id)

      vim.lsp.codelens.display(lenses, bufnr, client.id)
    end

    -- vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
    --   group = vim.api.nvim_create_augroup("CodeLensUpdater", { clear = true }),
    --   buffer = bufnr,
    --   callback = vim.lsp.codelens.refresh,
    -- })
  end
end

return M
