return {
  {
    -- Debug Framework
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
    },
    config = function() require("config.nvim-dap") end,
    event = "VeryLazy",
  },
  {
    -- UI for debugging
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function() require("config.nvim-dap-ui") end,
  },
  { "nvim-neotest/nvim-nio" },
  --{
  --"Issafalcon/neotest-dotnet",
  --},
  {
    "nsidorenco/neotest-vstest",
  },
  {
    "nvim-neotest/neotest",
    requires = {
      {
        "nsidorenco/neotest-vstest",
        --"Issafalcon/neotest-dotnet",
      },
    },
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      --"Issafalcon/neotest-dotnet",
      "nsidorenco/neotest-vstest",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-vstest")({}),
        },
      })
    end,
  },
}
