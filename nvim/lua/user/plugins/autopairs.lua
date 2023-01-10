local M = {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
}

function M.config()
  require("nvim-autopairs").setup {}

  local Rule = require "nvim-autopairs.rule"
  local cond = require "nvim-autopairs.conds"

  require("nvim-autopairs").add_rules {
    -- add spaces inside brackets
    Rule(" ", " ", { "-markdown", "-norg" }):with_pair(function(opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({ "()", "[]", "{}" }, pair)
    end),
    Rule("( ", " )", "-markdown")
      :with_pair(function()
        return false
      end)
      :with_move(function(opts)
        return opts.prev_char:match ".%)" ~= nil
      end)
      :use_key ")",
    Rule("{ ", " }", "-markdown")
      :with_pair(function()
        return false
      end)
      :with_move(function(opts)
        return opts.prev_char:match ".%}" ~= nil
      end)
      :use_key "}",
    Rule("[ ", " ]", "-markdown")
      :with_pair(function()
        return false
      end)
      :with_move(function(opts)
        return opts.prev_char:match ".%]" ~= nil
      end)
      :use_key "]",
    Rule("then$", "end", "lua"):use_regex(true):end_wise(cond.is_end_line()),
    Rule("do$", "end", "lua"):use_regex(true):end_wise(cond.is_end_line()),
    Rule("function[^%(]*%([^%)]*%)$", "end", "lua"):use_regex(true):end_wise(function(opts)
      return cond.is_end_line() or string.match(opts.next_char, "%s*[%)%]%}].*")
    end),
  }
end

return M
