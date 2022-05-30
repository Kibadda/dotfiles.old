local utils = require "user.utils"
local state = {
  target_terminal = nil,
  target_command = "",
}

local M = {}

-- toggle target_terminal
M.toggle_target = function(open)
  if state.target_terminal == nil then
    vim.notify("[terminal] target not set", "warn", { render = "minimal" })

    return
  end

  local target_winid = vim.fn.bufwinid(state.target_terminal.buf_nr)

  if target_winid ~= -1 and #vim.api.nvim_list_wins() ~= 1 then
    -- hide target
    if not open then
      if not pcall(vim.api.nvim_win_close, target_winid, false) then
        vim.notify("[terminal] target exited, resetting state", "debug", { render = "minimal" })
        state.target_terminal = nil

        return
      end
    end
  else
    local split_dir = "v"
    if utils.is_htruncated(utils.truncation_limit_s_terminal) then
      split_dir = ""
    end

    -- open in split
    if not pcall(vim.cmd, split_dir .. "split #" .. state.target_terminal.buf_nr) then
      vim.notify("[terminal] target exited, resetting state", "debug", { render = "minimal" })
      state.target_terminal = nil

      return
    end
  end
end

-- send payload to target_terminal
M.send_to_target = function(payload, repeat_last)
  if state.target_terminal ~= nil then
    if vim.fn.bufname(state.target_terminal.buf_nr) ~= "" then
      if repeat_last then
        if pcall(vim.cmd, "call chansend(" .. state.target_terminal.job_id .. ', "\x1b\x5b\x41\\<cr>")') then
          M.toggle_target(true)

          return
        end
      else
        if pcall(vim.api.nvim_chan_send, state.target_terminal.job_id, payload .. "\n") then
          M.toggle_target(true)

          return
        end
      end

      vim.notify("[terminal] target exited, resetting state", "debug", { render = "minimal" })
      state.target_terminal = nil

      return
    else
      vim.notify("[terminal] target does not exist, resetting state", "debug", { render = "minimal" })
      state.target_terminal = nil
    end
  else
    vim.notify("[terminal] target not set", "warn", { render = "minimal" })
  end
end

-- set target_terminal to this one
M.set_target_terminal = function()
  if vim.b.terminal_job_id ~= nil then
    state.target_terminal = {
      job_id = vim.b.terminal_job_id,
      buf_nr = vim.api.nvim_win_get_buf(0),
    }

    vim.notify(
      string.format(
        "target_terminal set to: { job_id: %s, buf_nr: %s }",
        state.target_terminal.job_id,
        state.target_terminal.buf_nr
      ),
      "info",
      { render = "minimal" }
    )
  else
    vim.notify("[terminal] target not set", "warn", { render = "minimal" })
  end
end

-- setup target_command
M.set_target_command = function()
  state.target_command = vim.fn.input("[terminal] target_command: ", "")
end

-- query the current state, utility
M.query_state = function()
  print(vim.inspect(state))
end

-- set target_terminal/target_command
M.set_target = function()
  if vim.b.terminal_job_id ~= nil then
    M.set_target_terminal()
  else
    M.set_target_command()
  end
end

-- run target_command
M.run_target_command = function()
  if state.target_command ~= "" then
    M.send_to_target(state.target_command, false)
  else
    vim.notify("[terminal] target not set", "warn", { render = "minimal" })
  end
end

-- run previous command in target_terminal
M.run_previous_command = function()
  M.send_to_target(nil, true)
end

-- launch a terminal with the command in a split
M.launch_terminal = function(command, background, callback)
  vim.cmd("vsp term://" .. vim.o.shell)
  local bufnr = vim.api.nvim_get_current_buf()

  vim.defer_fn(function()
    if pcall(vim.api.nvim_chan_send, vim.b.terminal_job_id, command .. "\n") then
      vim.notify(command, "info", { title = "[terminal] launched command" })
    end

    if callback then
      callback()
    end

    if background then
      vim.cmd [[ :q ]]
    else
      vim.cmd [[ wincmd p ]]
    end
  end, 250)

  return bufnr
end

return M
