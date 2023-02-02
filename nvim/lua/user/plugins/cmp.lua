local M = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    -- "L3MON4D3/LuaSnip",
    -- "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind.nvim",
    "dcampos/cmp-snippy",
    "dcampos/nvim-snippy",
  },
  event = "InsertEnter",
}

function M.config()
  local cmp = require "cmp"
  -- local luasnip = require "luasnip"
  local lspkind = require "lspkind"
  local snippy = require "snippy.main"

  local function has_words_before()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
  end

  local window_options = {
    border = "single",
    scrolloff = 1,
    col_offset = -3,
  }

  cmp.setup {
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local kind = lspkind.cmp_format { mode = "symbol_text", maxwidth = 50 }(entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = strings[1] or ""
        kind.menu = "(" .. (strings[2] or "") .. ")"
        return kind
      end,
    },
    window = {
      completion = cmp.config.window.bordered(window_options),
      documentation = cmp.config.window.bordered(window_options),
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "path" },
      -- { name = "luasnip" },
      { name = "nvim_lua" },
      { name = "buffer" },
      { name = "snippy" },
    },
    mapping = cmp.mapping.preset.insert {
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif snippy.can_expand_or_advance() then
          snippy.expand_or_advance()
        -- elseif luasnip.expand_or_locally_jumpable() then
        --   luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif snippy.can_jump(-1) then
          snippy.previous()
        -- elseif luasnip.jumpable(-1) then
        --   luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-l>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          if snippy.can_expand_or_advance() then
            snippy.expand_or_advance()
          -- if luasnip.expand_or_locally_jumpable() then
          --   luasnip.expand_or_jump()
          else
            fallback()
          end
        else
          cmp.complete()
        end
      end),
      ["<C-h>"] = cmp.mapping(function(fallback)
        if cmp.visible() and snippy.can_jump(-1) then
          snippy.previous()
        -- if cmp.visible() and luasnip.jumpable(-1) then
        --   luasnip.jump(-1)
        else
          fallback()
        end
      end),
      ["<C-e>"] = cmp.mapping.abort(),
    },
  }
end

return M
