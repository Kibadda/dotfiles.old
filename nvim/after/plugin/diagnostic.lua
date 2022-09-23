vim.diagnostic.config {
  severity_sort = true,
}

local ns = vim.api.nvim_create_namespace "my_namespace"
local orig_signs_handler = vim.diagnostic.handlers.signs

vim.diagnostic.handlers.signs = {
  show = function(_, bufnr, _, opts)
    local diagnostics = vim.diagnostic.get(bufnr)

    local max_severity_per_line = {}
    for _, d in pairs(diagnostics) do
      local m = max_severity_per_line[d.lnum]
      if not m or d.severity < m.severity then
        max_severity_per_line[d.lnum] = d
      end
    end

    local filterd_diagnostics = vim.tbl_values(max_severity_per_line)
    orig_signs_handler.show(ns, bufnr, filterd_diagnostics, opts)
  end,
  hide = function(_, bufnr)
    orig_signs_handler.hide(ns, bufnr)
  end,
}

-- vim.cmd.sign "define DiagnosticSignError text=🔥 texthl=DiagnosticSignError linehl= numhl="
-- vim.cmd.sign "define DiagnosticSignWarn text=🚨 texthl=DiagnosticSignWarn linehl= numhl="
-- vim.cmd.sign "define DiagnosticSignInfo text=ℹ️ texthl=DiagnosticSignInfo linehl= numhl="
-- vim.cmd.sign "define DiagnosticSignHint text=🚧 texthl=DiagnosticSignHint linehl= numhl="
