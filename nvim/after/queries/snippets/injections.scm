(comment) @comment

(eval
  !language
  command: (string) @vim)

((eval
  language: (string) @language
  command: (string) @lua)
  (#any-of? @language "lua" "l"))
