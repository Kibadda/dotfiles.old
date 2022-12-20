local M = {}

---custom attach
function M.get_on_attach()
  return function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil

    require("user.utils.register").keymaps {
      mode = "n",
      prefix = "",
      buffer = bufnr,
      {
        K = { vim.lsp.buf.hover, "Hover" },
        -- ["<C-S-k>"] = { vim.diagnostic.open_float, "Diagnostic" },
        gd = { require("user.lsp.handlers").definition, "Definition" },
        gr = { "<Cmd>Telescope lsp_references<CR>", "References" },
      },
    }

    require("user.utils.register").keymaps {
      mode = "n",
      prefix = "<Leader>",
      buffer = bufnr,
      {
        l = {
          c = { vim.lsp.buf.code_action, "Code Action" },
          f = { vim.lsp.buf.format, "Format" },
          j = { vim.diagnostic.goto_next, "Next Diagnostic" },
          k = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
          r = { vim.lsp.buf.rename, "Rename" },
          l = { vim.lsp.codelens.run, "Codelens" },
          d = { "<Cmd>Telescope diagnostics bufnr=0<CR>", "Show Buffer Diagnostics" },
          w = { "<Cmd>Telescope diagnostics<CR>", "Show Diagnostics" },
          R = { "<Cmd>LspRestart<CR>", "Restart" },
          D = { "<Cmd>Telescope lsp_document_symbols<CR>", "Symbols" },
        },
      },
    }

    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    if client.server_capabilities.documentHighlightProvider then
      local LspDocumentHighlight = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })
      vim.api.nvim_clear_autocmds {
        group = LspDocumentHighlight,
        buffer = bufnr,
      }
      vim.api.nvim_create_autocmd("CursorHold", {
        group = LspDocumentHighlight,
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        group = LspDocumentHighlight,
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })
    end

    local LspFormatting = vim.api.nvim_create_augroup("LspFormatting", { clear = false })
    vim.api.nvim_clear_autocmds {
      group = LspFormatting,
      buffer = bufnr,
    }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = LspFormatting,
      buffer = bufnr,
      callback = function()
        if require("user.auto_format").is_on() then -- and client.server_capabilities.documentFormattingProvider then
          vim.lsp.buf.format()
        end
      end,
    })
  end
end

---get capabilities
function M.get_capabilities()
  local capabilities
  if plugins_ok "cmp_nvim_lsp" then
    capabilities = require("cmp_nvim_lsp").default_capabilities()
  else
    capabilities = vim.lsp.protocol.make_client_capabilities()
  end

  return capabilities
end

return M
