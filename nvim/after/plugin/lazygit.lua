-- local function openLazygit()
--   local buf = vim.api.nvim_create_buf(false, true)
--   vim.api.nvim_open_win(buf, true, {
--     relative = "editor",
--     width = vim.fn.float2nr(vim.fn.round(0.7 * vim.o.columns)),
--     height = vim.fn.float2nr(vim.fn.round(0.7 * vim.o.lines)),
--     col = vim.fn.float2nr(vim.fn.round(0.15 * vim.o.columns)),
--     row = vim.fn.float2nr(vim.fn.round(0.15 * vim.o.lines)),
--     style = "minimal",
--   })

--   vim.fn.termopen "lazygit"
-- end

-- vim.api.nvim_create_user_command("Lazygit", openLazygit, {
--   bang = false,
--   nargs = 0,
--   desc = "Open lazygit",
-- })
