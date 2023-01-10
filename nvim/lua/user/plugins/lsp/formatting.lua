local M = {}

vim.g.LspAutoFormat = vim.g.LspAutoFormat or 0

function M.toggle()
  vim.g.LspAutoFormat = vim.g.LspAutoFormat == 0 and 1 or 0
  vim.notify(vim.g.LspAutoFormat == 1 and "Turned on" or "Turned off", vim.log.levels.INFO, { title = "Auto Format" })
end

function M.format()
  if vim.g.LspAutoFormat == 1 then
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    else
      vim.lsp.buf.formatting_sync()
    end
  end
end

function M.setup(client, bufnr)
  local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
  local lsp = require "user.plugins.lsp"

  local enable = false
  if lsp.has_formatter(ft) then
    enable = true
  else
    enable = not (client.name == "null-ls")
  end

  client.server_capabilities.documentFormattingProvider = enable
  if client.server_capabilities.documentFormattingProvider then
    local LspFormatting = vim.api.nvim_create_augroup("LspFormatting", { clear = false })
    vim.api.nvim_clear_autocmds {
      group = LspFormatting,
      buffer = bufnr,
    }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = LspFormatting,
      buffer = bufnr,
      callback = require("user.plugins.lsp.formatting").format,
    })
  end

  require("user.utils.register").keymaps {
    n = {
      ["<Leader>"] = {
        l = {
          name = "Lsp",
          t = { M.toggle, "Toggle Auto Format" },
        },
      },
    },
  }
end

return M
