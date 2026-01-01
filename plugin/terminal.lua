local map = vim.keymap.set
local term = {
  buf = nil,
  win = nil,
}
map({ "n", "t" }, "<F2>", function()
  if term.win and vim.api.nvim_win_is_valid(term.win) then
    vim.api.nvim_win_close(term.win, true)
    term.win = nil
    return
  end

  if term.buf and vim.api.nvim_buf_is_valid(term.buf) then
    vim.cmd.vnew()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 20)
    vim.api.nvim_win_set_buf(0, term.buf)
    term.win = vim.api.nvim_get_current_win()
    vim.cmd.startinsert()
    return
  end

  vim.cmd.vnew()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 20)
  vim.cmd.term()
  term.win = vim.api.nvim_get_current_win()
  term.buf = vim.api.nvim_get_current_buf()
  vim.cmd.startinsert()
end)
map("t", "<esc><esc>", "<c-\\><c-n>")
