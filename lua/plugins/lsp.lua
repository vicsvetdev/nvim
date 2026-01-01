return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason.nvim",
        config = true,
        opts = {
          ensure_installed = {
            "prettierd",
            "stylua",
          },
        },
      },
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
          "mason-org/mason.nvim",
          "neovim/nvim-lspconfig",
        },
        opts = {
          ensure_installed = {
            "lua_ls",
            "ts_ls",
          },
          automatic_installation = true,
        },
      },
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      {
        "seblyng/roslyn.nvim",
        ---@module 'roslyn.config'
        ---@type RoslynNvimConfig
        opts = {},
      },
    },
  },
}
