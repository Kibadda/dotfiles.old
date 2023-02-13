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
        t = {
          name = "Translate",
          e = { ":Translate -output=replace en<CR>", "To english" },
          d = { ":Translate -output=replace de<CR>", "To german" },
        },
      },
    },
  }
end

function M.config()
  require("user.utils.globals").set("", {
    deepl_api_auth_key = vim.env.DEEPL_API_AUTH_KEY,
  })

  require("translate").setup {
    default = {
      command = "deepl_free",
    },
  }
end

return M
