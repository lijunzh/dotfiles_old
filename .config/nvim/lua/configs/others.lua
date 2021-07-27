local M = {}

M.colorizer = function()
    local present, colorizer = pcall(require, "colorizer")
    if present then
        colorizer.setup()
        vim.cmd("ColorizerReloadAllBuffers")
    end
end

M.lspkind = function()
	local present, lspkind = pcall(require, "lspkind")
	if present then
		lspkind.init()
	end
end

M.neoscroll = function()
	pcall(
		function()
			require("neoscroll").setup()
		end
	)
end

M.blankline = function()
	vim.g.indentLine_enabled = 1
	vim.g.indent_blankline_char = "▏"

	vim.g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard"}
	vim.g.indent_blankline_buftype_exclude = {"terminal"}

	vim.g.indent_blankline_show_trailing_blankline_indent = false
	vim.g.indent_blankline_show_first_indent_level = false
end

return M
