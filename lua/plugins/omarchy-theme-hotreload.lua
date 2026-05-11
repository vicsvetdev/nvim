local theme_timer

local function current_theme_spec()
	local theme_path = vim.fn.expand("~/.config/omarchy/current/theme/neovim.lua")
	local loaded, spec = pcall(dofile, theme_path)

	if loaded and type(spec) == "table" then
		return spec
	end

	return {}
end

local function theme_colorscheme(spec)
	for _, plugin in ipairs(spec) do
		if plugin[1] == "LazyVim/LazyVim" and plugin.opts and plugin.opts.colorscheme then
			return plugin.opts.colorscheme
		end
	end
end

local function theme_plugin(spec)
	for _, plugin in ipairs(spec) do
		if plugin[1] and plugin[1] ~= "LazyVim/LazyVim" then
			return plugin.name or plugin[1]:match("([^/]+)$") or plugin[1]
		end
	end
end

local function unload_plugin_modules(plugin_name)
	if not plugin_name then
		return
	end

	local plugin = require("lazy.core.config").plugins[plugin_name]
	if not plugin then
		return
	end

	local plugin_dir = plugin.dir .. "/lua"
	require("lazy.core.util").walkmods(plugin_dir, function(modname)
		package.loaded[modname] = nil
		package.preload[modname] = nil
	end)
end

local function apply_theme()
	package.loaded["plugins.theme"] = nil

	local spec = current_theme_spec()
	local colorscheme = theme_colorscheme(spec)

	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") == 1 then
		vim.cmd("syntax reset")
	end
	vim.o.background = "dark"

	unload_plugin_modules(theme_plugin(spec))

	if colorscheme then
		require("lazy.core.loader").colorscheme(colorscheme)
		pcall(vim.cmd.colorscheme, colorscheme)
		return
	end

	for _, plugin in ipairs(spec) do
		if type(plugin.config) == "function" then
			pcall(plugin.config)
			return
		end
	end
end

local function reload_theme()
	vim.schedule(function()
		apply_theme()

		local transparency_file = vim.fn.stdpath("config") .. "/plugin/after/transparency.lua"
		if vim.fn.filereadable(transparency_file) == 1 then
			vim.cmd.source(transparency_file)
		end

		vim.api.nvim_exec_autocmds("ColorScheme", { modeline = false })
		vim.cmd("redraw!")
	end)
end

local function watch_theme_changes()
	if theme_timer then
		return
	end

	local uv = vim.uv or vim.loop
	local theme_file = vim.fn.expand("~/.config/omarchy/current/theme.name")
	local timer = uv.new_timer()
	local last_mtime

	local function mtime()
		local stat = uv.fs_stat(theme_file)
		return stat and (stat.mtime.sec .. "." .. stat.mtime.nsec)
	end

	theme_timer = timer
	last_mtime = mtime()
	timer:start(1000, 1000, function()
		local next_mtime = mtime()
		if next_mtime and last_mtime and next_mtime ~= last_mtime then
			last_mtime = next_mtime
			reload_theme()
		else
			last_mtime = next_mtime or last_mtime
		end
	end)

	vim.api.nvim_create_autocmd("VimLeavePre", {
		callback = function()
			if theme_timer then
				theme_timer:stop()
				theme_timer:close()
				theme_timer = nil
			end
		end,
	})
end

return {
	{
		name = "omarchy-theme-hotreload",
		dir = vim.fn.stdpath("config"),
		lazy = false,
		priority = 1000,
		config = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyReload",
				callback = reload_theme,
			})

			watch_theme_changes()
		end,
	},
}
