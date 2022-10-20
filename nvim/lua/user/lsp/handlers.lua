local M = {}

---change border style of hover handler
function M.hoverBorderStyle()
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  })
end

---lsp messages send to buffer
function M.showMessage()
  vim.lsp.handlers["window/showMessage"] = require "user.lsp.show_message"
end

---update publish diagnostics settings
function M.publishDiagnostics()
  vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.handlers["textDocument/publishDiagnostics"], {
      signs = {
        severity_limit = "Error",
      },
      underline = {
        severity_limit = "Warning",
      },
      virtual_text = true,
    })
end

---filter out framework results if at least one other result is found
function M.definition()
  local params = vim.lsp.util.make_position_params(0, "utf-8")
  vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, ...)
    if #result > 1 then
      local new_result = vim.tbl_filter(function(v)
        return string.match(v.targetUri, "framework") == nil
      end, result)

      if #new_result > 0 then
        result = new_result
      end
    end

    vim.lsp.handlers["textDocument/definition"](err, result, ...)
  end)
end

---rename and open qflist with all renamed positions
function M.rename()
  local params = vim.lsp.util.make_position_params(0, "utf-8")
  vim.ui.input({ prompt = "New Name (with QF): ", default = vim.fn.expand "<cword>" }, function(new_name)
    if not new_name then
      return
    end
    params.newName = new_name
    vim.lsp.buf_request(0, "textDocument/rename", params, function(err, result, ...)
      vim.lsp.handlers["textDocument/rename"](err, result, ...)

      local entries = {}
      if result.changes then
        for uri, edits in pairs(result.changes) do
          local bufnr = vim.uri_to_bufnr(uri)

          for _, edit in ipairs(edits) do
            local start_line = edit.range.start.line + 1
            local line = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, start_line, false)[1]

            table.insert(entries, {
              bufnr = bufnr,
              lnum = start_line,
              col = edit.range.start.character + 1,
              text = line,
            })
          end
        end
      end

      vim.fn.setqflist(entries, "r")
      vim.cmd.copen()
    end)
  end)
end

---add progress notifications to lsp
function M.progessNotifcation()
  local notify = require "user.notify"

  vim.lsp.handlers["$/progress"] = function(_, result, ctx)
    if not GetGlobal("lsp", "progress_notifications") then
      return
    end

    local client_id = ctx.client_id

    local val = result.value

    if not val.kind then
      return
    end

    local notif_data = notify.get_notif_data(client_id, result.token)

    if val.kind == "begin" then
      local message = notify.format_message(val.message, val.percentage)

      notif_data.notification = vim.notify(message, "info", {
        title = notify.format_title(val.title, vim.lsp.get_client_by_id(client_id).name),
        icon = notify.spinner_frames[1],
        timeout = false,
        hide_from_history = false,
      })

      notif_data.spinner = 1
      notify.update_spinner(client_id, result.token)
    elseif val.kind == "report" and notif_data then
      notif_data.notification = vim.notify(notify.format_message(val.message, val.percentage), "info", {
        replace = notif_data.notification,
        hide_from_history = false,
      })
    elseif val.kind == "end" and notif_data then
      notif_data.notification = vim.notify(val.message and notify.format_message(val.message) or "Complete", "info", {
        icon = "",
        replace = notif_data.notification,
        timeout = 3000,
      })

      notif_data.spinner = nil
    end
  end
end

return M
