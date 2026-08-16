return {
  "stevearc/conform.nvim",
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
}
