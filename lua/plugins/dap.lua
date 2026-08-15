-- The dap.core / test.core / lang.dotnet extras supply the plugins, the
-- netcoredbg adapter and the C# launch config. This file carries over what was
-- personal to the old lua/config/nvim-dap.lua and nvim-dap-ui.lua: the F-key
-- bindings, the breakpoint signs and the single-panel dap-ui layout.
--
-- Not carried over, because dap.core already does it:
--   * the dapui auto open/close listeners on initialized/terminated/exited
--   * <leader>dl (Run Last) and <leader>dr (Toggle REPL, was repl.open)
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
    -- dap.core defines its signs from LazyVim.config.icons.dap, so overriding
    -- the icons is what sticks; a bare sign_define here would be overwritten
    -- when dap loads.
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
      render = {
        max_type_length = 60,
        max_value_lines = 200,
      },
      -- Only one layout: just the "scopes" (variables) list at the bottom
      layouts = {
        {
          elements = {
            { id = "scopes", size = 1.0 },
          },
          size = 15,
          position = "bottom",
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
