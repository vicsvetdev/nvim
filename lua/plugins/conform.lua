return {
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "jq" },
      },
      formatters = {
        stylua = {
          prepend_args = {
            "--column-width",
            "9999",
            "--collapse-simple-statement",
            "Always",
          },
        },
        jq = {
          args = { "." },
        },
      },
    },
    config = function(_, opts)
      local conform = require("conform")
      conform.setup(opts)
      vim.keymap.set("n", "<leader>cc", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, { desc = "Format code" })
    end,
  },
}
