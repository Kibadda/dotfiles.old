local dir = vim.loop.cwd()

local function tmux_exec(cmd)
  vim.fn.system(("tmux send-keys -t %s %s"):format(vim.env.TMUX_PANE, cmd))
end

tmux_exec "'C-z'"
vim.defer_fn(function()
  tmux_exec(("'cd %s' 'Enter' 'fg' 'Enter'"):format(dir))
end, 50)
