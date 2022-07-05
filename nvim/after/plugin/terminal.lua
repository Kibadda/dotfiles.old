function OpenTerminal(opts)
  opts = opts or {}
  opts = vim.tbl_extend("keep", opts, {
    no_split = true,
    vertical = true,
    height = 12,
    program = nil,
    current_file = false,
  })

  local file
  if opts.current_file then
    file = vim.fn.expand "%"
  else
    file = nil
  end

  if not opts.no_split then
    if opts.vertical then
      vim.cmd [[
        vnew
        wincmd L
        set winfixwidth
      ]]
    else
      vim.cmd [[
        new
        wincmd J
        set winfixheight
      ]]
      vim.api.nvim_win_set_height(0, opts.height)
    end
  end

  if opts.program == nil then
    vim.cmd [[term]]
  elseif vim.fn.executable(opts.program) == 1 then
    if file ~= nil then
      vim.cmd(string.format("term %s %s", opts.program, file))
    else
      vim.cmd(string.format("term %s", opts.program))
    end
  else
    vim.notify(string.format("[TermApp] %s is not an executable", opts.program))
  end
end

vim.keymap.set("n", "<Leader>tr", "<CMD>lua OpenTerminal()<CR>")
vim.keymap.set("n", "<Leader>gg", "<CMD>lua OpenTerminal({program = 'lazygit'})<CR>")
vim.keymap.set("n", "<Leader>rr", "<CMD>lua OpenTerminal({program = 'ranger' })<CR>")
vim.keymap.set("n", "<Leader>rc", "<CMD>lua OpenTerminal({program = 'ranger', current_file = true})<CR>")
