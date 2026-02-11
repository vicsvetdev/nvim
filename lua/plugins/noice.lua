return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
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
    config = function()
      require("notify").setup({
        top_down = false,
        render = "wrapped-compact",
        max_width = function()
          return math.floor(vim.o.columns * 0.4)
        end,
        max_height = function()
          return math.floor(vim.o.lines * 0.4)
        end,
      })

      require("noice").setup({
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
        },
        lsp = {
          progress = {
            enabled = false,
          },
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          signature = {
            enabled = false,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = true,
        },
      })
    end,
  },
}
