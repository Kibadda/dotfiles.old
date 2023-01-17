local M = {}

function M.setup()
  vim.diagnostic.config {
    severity_sort = true,
    float = {
      border = "single",
    },
  }
end

return M
