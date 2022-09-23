local M = {}

---custom attach
function M.get_on_attach()
  return function(client)
    local handlers = require "user.lsp.handlers"
    handlers.hoverBorderStyle()

    RegisterKeymaps {
      mode = "n",
      prefix = "",
      buffer = 0,
      {
        K = { vim.lsp.buf.hover, "Hover" },
        ["<C-S-k>"] = { vim.diagnostic.open_float, "Diagnostic" },
        gd = { handlers.definition, "Definition" },
        gr = { "<Cmd>Telescope lsp_references theme=ivy<CR>", "References" },
      },
    }

    RegisterKeymaps {
      mode = "n",
      prefix = "<Leader>",
      buffer = 0,
      {
        l = {
          c = { vim.lsp.buf.code_action, "Code Action" },
          f = { vim.lsp.buf.format, "Format" },
          j = { vim.diagnostic.goto_next, "Next Diagnostic" },
          k = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
          d = { "<Cmd>Telescope diagnostics bufnr=0 theme=ivy<CR>", "Show Buffer Diagnostics" },
          w = { "<Cmd>Telescope diagnostics theme=ivy<CR>", "Show Diagnostics" },
          r = { vim.lsp.buf.rename, "Rename" },
          R = { "<Cmd>LspRestart<CR>", "Restart" },
          t = { "<Cmd>ToggleAutoFormat<CR>", "Toggle Auto Format" },
        },
      },
    }

    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    if client.server_capabilities.documentHighlightProvider then
      local LspDocumentHighlight = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })
      vim.api.nvim_clear_autocmds {
        group = LspDocumentHighlight,
        buffer = 0,
      }
      vim.api.nvim_create_autocmd("CursorHold", {
        group = LspDocumentHighlight,
        buffer = 0,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        group = LspDocumentHighlight,
        buffer = 0,
        callback = vim.lsp.buf.clear_references,
      })
    end

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
      pattern = "*",
      callback = function()
        if GetGlobal("lsp", "auto_format") and client.server_capabilities.documentFormattingProvider then
          vim.lsp.buf.format()
        end
      end,
    })
  end
end

---get capabilities
---@return table
function M.get_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  if PluginsOk "cmp_nvim_lsp" then
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
  end

  return capabilities
end

return M
