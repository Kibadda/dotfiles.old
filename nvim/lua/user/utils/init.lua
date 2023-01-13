local M = {}

function M.detach_from_tmux()
  os.execute "tmux detach"
end

function M.save_and_source()
  vim.cmd.w()

  if vim.bo.filetype == "lua" then
    vim.cmd.luafile "%"
  elseif vim.bo.filetype == "vim" then
    vim.cmd.source "%"
  end
end

function M.open_in_github()
  local Job = require "plenary.job"
  local job1 = Job:new {
    command = "git",
    args = {
      "remote",
    },
    cwd = vim.fn.getcwd(),
  }
  job1:sync()
  local remote = job1:result()[1]
  local job2 = Job:new {
    command = "git",
    args = {
      "config",
      "--get",
      ("remote.%s.url"):format(remote),
    },
    cwd = vim.fn.getcwd(),
  }
  job2:sync()
  local remote_url = job2:result()[1]
  remote_url = string.gsub(remote_url, "%.git", "")
  remote_url = string.gsub(remote_url, ":", "/")
  remote_url = string.gsub(remote_url, "git@", "https://")
  os.execute(("xdg-open %s"):format(remote_url))
end

---for wrapped lines: gj/gk, for large jumps: add to jump list
---@param direction string
function M.jump_direction(direction)
  return function()
    local count = vim.v.count

    if count == 0 then
      vim.cmd.normal { ("g%s"):format(direction), bang = true }
      return
    end

    if count > 5 then
      vim.cmd.normal { "m'", bang = true }
    end

    vim.cmd.normal { ("%d%s"):format(count, direction), bang = true }
  end
end

---set options depending if cwd is cortex
---@param value_if_work any
---@param default any
function M.set_cwd_options(value_if_work, default)
  local ts = default
  if string.find(vim.fn.getcwd(), "^/media/") then
    ts = value_if_work
  end

  require("user.utils.options").set {
    tabstop = ts,
    shiftwidth = ts,
    formatoptions = require("user.utils.globals").get("", "formatoptions"),
  }
end

function M.open_terminal(opts)
  opts = vim.tbl_extend("keep", opts or {}, {
    position = "right",
    size = 60,
  })

  vim.cmd(
    ("%s%s%ssplit"):format(
      (opts.position == "top" or opts.position == "left") and "topleft " or "",
      opts.size or "",
      (opts.position == "left" or opts.position == "right") and "v" or ""
    )
  )

  local winid = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_win(winid)
  vim.api.nvim_win_set_buf(winid, buf)
  vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w><C-h>", { buffer = buf })
  vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w><C-j>", { buffer = buf })
  vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w><C-k>", { buffer = buf })
  vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w><C-l>", { buffer = buf })
  vim.fn.termopen(vim.env.SHELL)
end

function M.open_url()
  os.execute("xdg-open " .. vim.fn.expand "<cWORD>")
end

function M.new_scratch()
  vim.ui.input({
    prompt = "Filename: ",
  }, function(input)
    if input and input ~= "" then
      vim.cmd(("e %s/%s.lua"):format(vim.fn.stdpath "config" .. "/scratch", input))
    end
  end)
end

return M
