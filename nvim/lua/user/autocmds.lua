local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd("TextYankPost", {
  group = augroup("HighlightYank", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {
      higroup = "Search",
      timeout = 200,
    }
  end,
})

autocmd("TermClose", {
  group = augroup("CloseBufferAfterTermClose", { clear = true }),
  pattern = "*",
  callback = function()
    if vim.bo.filetype ~= "TelescopePrompt" then
      vim.cmd.bd { bang = true }
    end
  end,
})

autocmd("BufEnter", {
  group = augroup("EnterInsertInTerm", { clear = true }),
  pattern = "term://*",
  callback = function()
    vim.cmd.startinsert()
  end,
})

autocmd("TermOpen", {
  group = augroup("TermFileType", { clear = true }),
  pattern = "*",
  callback = function()
    require("user.utils.options").set {
      filetype = "term",
    }
  end,
})

autocmd("BufWritePre", {
  group = augroup("AutoCreateDir", { clear = true }),
  callback = function(event)
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    local backup = vim.fn.fnamemodify(file, ":p:~:h")
    backup = backup:gsub("[/\\]", "%%")
    vim.go.backupext = backup
  end,
})

autocmd("User", {
  group = augroup("RemoveWinbarOnFileBufType", { clear = true }),
  pattern = "HeirlineInitWinbar",
  callback = function(args)
    if
      vim.tbl_contains({ "prompt", "nofile", "help", "quickfix", "startify", "starter" }, vim.bo[args.buf].buftype)
      or vim.tbl_contains({ "gitcommit", "fugitive", "startify", "starter" }, vim.bo[args.buf].filetype)
    then
      vim.opt_local.winbar = nil
    end
  end,
})

autocmd("BufEnter", {
  group = augroup("PluginFileKeymap", { clear = true }),
  pattern = "*/lua/user/plugins/{*.lua,*/init.lua}",
  callback = function(args)
    require("user.utils.register").keymaps {
      [{ mode = "n", buffer = args.buf }] = {
        g = {
          P = { require("user.utils.plugin").open, "Open Plugin" },
        },
      },
    }
  end,
})
