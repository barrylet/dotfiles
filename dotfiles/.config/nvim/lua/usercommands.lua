-- Custom commands

vim.api.nvim_create_user_command(
	'Format',
	function(input)
		vim.lsp.buf.format()
	end,
	{desc = 'Format open file'}
)

vim.api.nvim_create_user_command(
	'CodeAction',
	function(input)
		vim.lsp.buf.code_action()
	end,
	{desc = 'Code action'}
)

vim.api.nvim_create_user_command(
	'LineCol',
	function(input)
		vim.opt.tw = tonumber(input.args)
		vim.opt.colorcolumn = input.args
	end,
	{nargs = 1, desc = 'Set auto line break on N characters'}
)

vim.api.nvim_create_user_command(
	'ModeWrite',
	function(input)
		vim.cmd([[colorscheme xcodelight | set linebreak | Goyo 90]])
	end,
	{desc = 'Hide distractions with Goyo and set white theme'}
)

vim.api.nvim_create_user_command(
	'ModeCode',
	function(input)
		vim.cmd([[colorscheme moonfly | set linebreak! | Goyo!]])
	end,
	{desc = 'Hide distractions with Goyo and set white theme'}
)

vim.api.nvim_create_user_command(
	'TrimWhitespace',
	function(_input)
		vim.cmd([[
			let f_save = winsaveview()
			keeppatterns %s/\s\+$//e
			call winrestview(f_save)
		]])
	end,
	{desc = 'Trims extra whitespace from the document'}
)

vim.api.nvim_create_user_command(
	'IndentTabs',
	function()
		vim.opt.autoindent = true
		vim.opt.expandtab = false
		vim.opt.tabstop = 4
		vim.opt.shiftwidth = 4
		vim.opt.softtabstop = 4
		vim.cmd([[
			%retab!
		]])
	end,
	{desc = 'Reformat and reconfigure to indent using tabs'}
)

vim.api.nvim_create_user_command(
	'IndentSpaces',
	function(input)
		vim.opt.tabstop = tonumber(input.args)
		vim.opt.shiftwidth = tonumber(input.args)
		vim.opt.softtabstop = tonumber(input.args)
		vim.opt.expandtab = true
		vim.cmd([[retab]])
	end,
	{nargs = 1, desc = 'Reformat and reconfigure to indent using N spaces'}
)

vim.cmd([[
	autocmd FileType sql setlocal commentstring=--\ %s
]])
