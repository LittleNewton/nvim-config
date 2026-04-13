-- local current_signature = function()
-- 	if not pcall(require, 'lsp_signature') then return end
-- 	local sig = require("lsp_signature").status_line(50)
-- 	return sig.label .. "🐼" .. sig.hint
-- end

return {
	-- "theniceboy/eleline.vim",
	-- branch = "no-scrollbar",
	"nvim-lualine/lualine.nvim",
	-- You can optionally lazy-load heirline on UiEnter
	-- to make sure all required plugins and colorschemes are loaded before setup
	-- event = "UiEnter",
	config = function()
		require('lualine').setup {
			options = {
				icons_enabled = true,
				theme = 'auto',
				component_separators = { left = '', right = '' },
				section_separators = { left = '', right = '' },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				}
			},
			sections = {
				lualine_a = { 'filename' },
				lualine_b = { 'branch', 'diff', 'diagnostics' },
				lualine_c = {
					{
						function() return require("noice").api.status.mode.get() end,
						cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
					},
				},
				lualine_x = {
					{
						function() return require("noice").api.status.search.get() end,
						cond = function() return package.loaded["noice"] and require("noice").api.status.search.has() end,
					},
				},
				lualine_y = { 'filesize', 'fileformat', 'filetype' },
				lualine_z = { 'location' }
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { 'filename' },
				lualine_x = { 'location' },
				lualine_y = {},
				lualine_z = {}
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {}
		}
	end
}
