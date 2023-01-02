-- Custom commands

vim.api.nvim_create_user_command(
	'Format',
	function(input)
		vim.lsp.buf.format()
	end,
	{desc = 'Format open file'}
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
