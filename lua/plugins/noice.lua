return {
  "folke/noice.nvim",
  opts = {
    presets = {
      -- LazyVim turns this on, which pins the cmdline to row 3 and the
      -- completion menu to row 6. Off, noice's defaults apply: the cmdline
      -- sits at 50% and the popupmenu uses position="auto", so it follows
      -- the cmdline instead of being stranded at the top of the screen.
      command_palette = false,
    },
    views = {
      cmdline_popup = {
        -- Same as noice's default; stated explicitly so the intent survives
        -- any future change to that default.
        position = {
          row = "50%",
          col = "50%",
        },
        border = {
          style = "rounded",
          padding = { 1, 2 },
        },
        win_options = {
          winhighlight = {
            Normal = "Normal",
            FloatBorder = "NoiceCmdlinePopupBorder",
          },
        },
      },
    },
  },
}
