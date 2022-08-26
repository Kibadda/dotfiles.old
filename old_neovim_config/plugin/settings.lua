vim.g.loaded_matchparen = 1

local opt = vim.opt

opt.pumblend = 17
opt.wildmode = "longest:full"
opt.wildoptions = "pum"

opt.showmode = false
opt.showcmd = true
opt.cmdheight = 1
opt.incsearch = true
opt.showmatch = true
opt.relativenumber = true
opt.number = true
opt.ignorecase = true
opt.smartcase = true
opt.hidden = true
opt.equalalways = false
opt.splitright = true
opt.splitbelow = true
opt.updatetime = 1000
opt.hlsearch = true
opt.scrolloff = 10
opt.cursorline = true
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
  vim.api.nvim_create_autocmd(event, {
    group = group,
    pattern = pattern,
    callback = function()
      vim.opt_local.cursorline = value
    end,
  })
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")

opt.autoindent = true
opt.cindent = true
opt.wrap = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.breakindent = true
opt.showbreak = string.rep(" ", 3)
opt.linebreak = true

opt.foldenable = false
-- opt.foldmethod = "marker"
-- opt.foldlevel = 0

opt.modelines = 1

opt.belloff = "all"

opt.clipboard = "unnamedplus"

opt.inccommand = "split"
opt.swapfile = false
opt.undofile = true
opt.shada = { "!", "'1000", "<50", "s10", "h" }

opt.mouse = "n"

opt.formatoptions = opt.formatoptions - "a" - "t" + "c" + "q" - "o" + "r" + "n" + "j" - "2"

opt.joinspaces = false

opt.fillchars = { eob = "~" }

opt.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" }

opt.laststatus = 3

opt.signcolumn = "yes"

-- opt.winbar = "%=%m %f"
