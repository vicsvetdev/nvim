-- Deltas only. Deliberately not carried over from the old config:
--   keymap.preset = "default" -- LazyVim uses "enter"; changing it would
--                                alter Enter/Tab acceptance behaviour
--   version = "1.*"           -- fights LazyVim's pinned version
--   sources.default           -- identical to LazyVim's, which also declares
--                                opts_extend so extras can append to it
-- The <Tab> entry lives in lua/plugins/tabout.lua, next to what it's for.
return {
  "saghen/blink.cmp",
  opts = {
    appearance = {
      nerd_font_variant = "mono",
    },
    completion = {
      menu = {
        auto_show = true,
        border = "rounded",
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind", gap = 1 },
          },
        },
      },
      documentation = {
        auto_show = true,
        window = { border = "rounded" },
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = {
      enabled = true,
      window = { border = "rounded" },
    },
  },
}
