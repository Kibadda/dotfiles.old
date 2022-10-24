if true or not PluginsOk "markdown-docs" then
  return
end

import("markdown-docs").setup {
  docs = {
    {
      name = "laravel-docs",
      git_url = "https://github.com/laravel/docs.git",
      url = "https://laravel.com/docs/9.x",
      branch = "9.x",
    },
  },
}
