local function current_theme_spec()
	local theme_path = vim.fn.expand("~/.config/omarchy/current/theme/neovim.lua")
	local loaded, spec = pcall(dofile, theme_path)

	if loaded and type(spec) == "table" then
		return spec
	end

	return {}
end

local function normalize_theme_spec(spec)
	local normalized = {}

	for _, plugin in ipairs(spec) do
		if plugin[1] == "LazyVim/LazyVim" then
			local colorscheme = plugin.opts and plugin.opts.colorscheme

			if colorscheme then
				table.insert(normalized, {
					name = "omarchy-theme-" .. colorscheme,
					dir = vim.fn.stdpath("config"),
					lazy = false,
					priority = 1000,
					config = function()
						vim.cmd.colorscheme(colorscheme)
					end,
				})
			end
		else
			plugin.lazy = plugin.lazy == nil and false or plugin.lazy
			table.insert(normalized, plugin)
		end
	end

	return normalized
end

return normalize_theme_spec(current_theme_spec())
