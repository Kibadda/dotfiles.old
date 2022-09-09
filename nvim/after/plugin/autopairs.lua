if not PluginsOk "nvim-autopairs" then
  return
end

require("nvim-autopairs").setup {}

local Rule = require "nvim-autopairs.rule"
local cond = require "nvim-autopairs.conds"

require("nvim-autopairs").add_rules {
  -- add spaces inside brackets
  Rule(" ", " "):with_pair(function(opts)
    local pair = opts.line:sub(opts.col - 1, opts.col)
    return vim.tbl_contains({ "()", "[]", "{}" }, pair)
  end),
  Rule("( ", " )")
    :with_pair(function()
      return false
    end)
    :with_move(function(opts)
      return opts.prev_char:match ".%)" ~= nil
    end)
    :use_key ")",
  Rule("{ ", " }")
    :with_pair(function()
      return false
    end)
    :with_move(function(opts)
      return opts.prev_char:match ".%}" ~= nil
    end)
    :use_key "}",
  Rule("[ ", " ]")
    :with_pair(function()
      return false
    end)
    :with_move(function(opts)
      return opts.prev_char:match ".%]" ~= nil
    end)
    :use_key "]",
  -- add spaces around "="
  Rule("=", "", { "-html", "-smarty" })
    :with_pair(cond.not_inside_quote())
    :with_pair(function(opts)
      local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
      if last_char:match "[%w%=%s]" then
        return true
      end
      return false
    end)
    :replace_endpair(function(opts)
      local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
      local next_char = opts.line:sub(opts.col, opts.col)
      next_char = next_char == " " and "" or " "
      if prev_2char:match "%w$" then
        return "<bs> =" .. next_char
      end
      if prev_2char:match "%=$" then
        return next_char
      end
      if prev_2char:match "=" then
        return "<bs><bs>=" .. next_char
      end
      return ""
    end)
    :set_end_pair_length(0)
    :with_move(cond.none())
    :with_del(cond.none()),
  Rule("then$", "end", "lua"):use_regex(true):end_wise(cond.is_end_line()),
  Rule("do$", "end", "lua"):use_regex(true):end_wise(cond.is_end_line()),
  Rule("function[^%(]*%([^%)]*%)$", "end", "lua"):use_regex(true):end_wise(function(opts)
    return cond.is_end_line() or string.match(opts.next_char, "%s*[%)%]%}].*")
  end),
}
