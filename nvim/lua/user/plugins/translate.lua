local M = {
  "uga-rosa/translate.nvim",
  dependencies = {
    "tpope/vim-dotenv",
  },
  cmd = "Translate",
}

function M.init()
  require("user.utils.register").keymaps {
    x = {
      ["<Leader>"] = {
        T = {
          name = "Translate",
          e = { ":Translate -output=replace en<CR>", "To english" },
          d = { ":Translate -output=replace de<CR>", "To german" },
        },
      },
    },
  }
end

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
end

return M
