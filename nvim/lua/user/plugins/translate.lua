local M = {
  "uga-rosa/translate.nvim",
  dependencies = {
    "tpope/vim-dotenv",
  },
}

function M.config()
  local envfile = "~/.dotfiles/.env"
  if vim.fn.filereadable(vim.fn.expand(envfile)) == 0 then
    return
  end

  vim.cmd.Dotenv(envfile)

  require("user.utils.globals").set("", {
    deepl_api_auth_key = vim.env.DEEPL_API_KEY,
  })

  require("translate").setup {
    default = {
      command = "deepl_free",
    },
  }

  -- require("user.utils.register").keymaps {
  --   mode = "x",
  --   prefix = "<Leader>",
  --   {
  --     T = {
  --       name = "Translate",
  --       e = { "<Cmd>Translate -output=replace en<CR>", "To english" },
  --       d = { "<Cmd>Translate -output=replace de<CR>", "To german" },
  --     },
  --   },
  -- }
end

return M
