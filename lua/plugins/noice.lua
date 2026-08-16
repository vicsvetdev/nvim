return {
  "folke/noice.nvim",
  keys = {
    {
      "<leader>nh",
      function()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].filetype == "noice" then
            vim.api.nvim_win_close(win, true)
            return
          end
        end
        vim.cmd("Noice history")
      end,
      desc = "Noice history",
    },
  },
  opts = {
    messages = {
      view = "mini",
      view_error = "mini",
      view_warn = "mini",
    },
    notify = {
      view = "mini",
    },
    presets = {
      command_palette = false,
    },
    views = {
      cmdline_popup = {
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
      hover = {
        border = {
          style = "single",
        },
      },
      mini = {
        border = {
          style = "single",
          padding = { 0, 1 },
        },
        position = {
          row = -2,
          col = "100%",
        },
        win_options = {
          winblend = 0,
        },
      },
    },
    lsp = {
      progress = {
        enabled = false,
      },
      signature = {
        enabled = false,
      },
    },
  },
}
