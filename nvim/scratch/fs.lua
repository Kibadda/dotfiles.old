-- for k, v in vim.fs.dir "~/.cache/laravel-docs" do
--   vim.pretty_print { k, v }
-- end

vim.pretty_print(vim.fs.find(function()
  return string.match("artisan.md", ".md$") ~= nil
end, {
  path = "~/.cache/laravel-docs",
  type = "file",
  limit = math.huge,
}))
