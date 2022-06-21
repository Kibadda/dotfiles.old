local utils = require "lib.utils"

if utils.get_git_root() ~= 0 then
  vim.api.nvim_create_user_command("OpenInGithub", function(_)
    local remotes = utils.get_git_remotes()

    if #remotes > 1 then
      vim.ui.select(remotes, { prompt = "remote> " }, function(remote)
        utils.open_repo_on_github(remote)
      end)
    else
      utils.open_repo_on_github(remotes[1])
    end
  end, {
    bang = true,
    nargs = 0,
    desc = "Open chosen remote on Github, in the Browser",
  })
end
