if true or not pcall(require, "lint") then
  return
end

require("lint").linters_by_ft = {
  php = { "phpcs" },
}

require("lint.linters.phpcs").args = {
  "-q",
  "--standard=~/.config/nvim/ruleset.xml",
  "--report=json",
  "-",
}

local group = vim.api.nvim_create_augroup("LinterGroup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = group,
  pattern = "*.php",
  callback = function()
    require("lint").try_lint()
  end,
})
