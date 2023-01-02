-- Color scheme and theme config
-- see for colors: https://www.ditig.com/256-colors-cheat-sheet

-- color of the vertical column in script files
vim.cmd([[
	highlight ColorColumn ctermbg=242
]])

-- enable true colors (unknown if needed for neovim)
vim.cmd([[
	set termguicolors
	if exists('+termguicolors')
	  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	  set termguicolors
	endif
]])

-- color scheme
vim.cmd([[
	silent! colorscheme moonfly
]])
