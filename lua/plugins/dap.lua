return {
  {
    "mfussenegger/nvim-dap",
    -- stylua: ignore
    keys = {
      { "<F7>", function() require("dap").step_into() end, desc = "Step Into" },
      { "<F8>", function() require("dap").step_over() end, desc = "Step Over" },
      { "<F9>", function() require("dap").continue() end, desc = "Run/Continue" },
      { "<F10>", function() require("dap").disconnect() end, desc = "Disconnect" },
      { "<S-F6>", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      icons = {
        dap = {
          Breakpoint = "🔴",
          Stopped = { "🟢", "DiagnosticWarn", "DapStoppedLine" },
          BreakpointRejected = "🔵",
        },
      },
    },
  },

  {
    "rcarriga/nvim-dap-ui",
    opts = {
      expand_lines = true,
      controls = { enabled = false }, -- no extra play/step buttons
      floating = { border = "rounded" },
      -- Set dapui window
      render = {
        max_type_length = 60,
        max_value_lines = 200,
      },
      -- Only one layout: just the "scopes" (variables) list at the bottom
      layouts = {
        {
          elements = {
            { id = "scopes", size = 1.0 }, -- 100% of this panel is scopes
          },
          size = 15, -- height in lines (adjust to taste)
          position = "bottom", -- "left", "right", "top", "bottom"
        },
      },
    },
  },

  {
    "nvim-neotest/neotest",
    -- stylua: ignore
    keys = {
      { "<F3>", function() require("neotest").output_panel.toggle() end, desc = "Toggle tests output" },
      { "<F4>", function() require("neotest").summary.toggle() end, desc = "Toggle tests panel" },
      { "<F5>", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<F6>", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
    },
  },
}
