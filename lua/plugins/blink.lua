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
