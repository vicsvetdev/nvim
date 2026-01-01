local group = vim.api.nvim_create_augroup("OoO", {})
local diagnostics_enabled = true
local diagnostic_float_winid = nil

local function au(typ, pattern, cmdOrFn)
  if type(cmdOrFn) == "function" then
    vim.api.nvim_create_autocmd(typ, { pattern = pattern, callback = cmdOrFn, group = group })
  else
    vim.api.nvim_create_autocmd(typ, { pattern = pattern, command = cmdOrFn, group = group })
  end
end

local function show_diagnostics()
  if not diagnostics_enabled then return end

  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local line = cursor_pos[1] - 1
  local col = cursor_pos[2]
  local diagnostics = vim.diagnostic.get(0, { lnum = line })
  if #diagnostics == 0 then return end

  local severity = nil
  for _, diag in ipairs(diagnostics) do
    if col >= diag.col and col <= diag.end_col then
      severity = diag.severity
      break
    end
  end

  if not severity and #diagnostics > 0 then
    local closest = diagnostics[1]
    local min_distance = math.abs(col - diagnostics[1].col)
    for _, diag in ipairs(diagnostics) do
      local distance = math.abs(col - diag.col)
      if distance < min_distance then
        min_distance = distance
        closest = diag
      end
    end
    severity = closest.severity
  end

  if not severity then return end

  local severity_headers = {
    [vim.diagnostic.severity.ERROR] = { " Error ", "DiagnosticError" },
    [vim.diagnostic.severity.WARN] = { " Warning ", "DiagnosticWarn" },
    [vim.diagnostic.severity.INFO] = { " Info ", "DiagnosticInfo" },
    [vim.diagnostic.severity.HINT] = { " Hint ", "DiagnosticHint" },
  }

  local opts = {
    focusable = false,
    scope = "cursor",
    close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
    border = "rounded",
    max_width = 80,
    source = "always",
    header = severity_headers[severity],
  }

  local _, winid = vim.diagnostic.open_float(nil, opts)
  diagnostic_float_winid = winid
end

au({ "CursorHold", "InsertLeave" }, nil, show_diagnostics)
au("InsertEnter", nil, function() vim.diagnostic.enable(false) end)
au("InsertLeave", nil, function() vim.diagnostic.enable(true) end)

function ToggleDiagnosticFloat()
  if diagnostics_enabled then
    diagnostics_enabled = false
    if diagnostic_float_winid and vim.api.nvim_win_is_valid(diagnostic_float_winid) then
      vim.api.nvim_win_close(diagnostic_float_winid, true)
      diagnostic_float_winid = nil
    end
    print("Diagnostic floats disabled")
  else
    diagnostics_enabled = true
    show_diagnostics()
    print("Diagnostic floats enabled")
  end
end

vim.keymap.set("n", "H", ToggleDiagnosticFloat, { desc = "Toggle diagnostic float" })
