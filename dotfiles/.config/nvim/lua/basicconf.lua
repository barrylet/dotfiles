-- Basic configuration, mostly vim options

-- undo file for undo and redo after vim closes
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/.config/nvim/.undo//')

vim.opt.shell = '/bin/bash'

-- skip python host check due to slow start
-- see https://github.com/neovim/neovim/issues/2437
-- vim.g.python_host_skip_check = 1
-- vim.g.python3_host_skip_check = 1

-- set python version
-- vim.g.python3_host_prog = vim.fn.system("which -a python3 | head -n1")

-- display relative line numbers and current line number
vim.opt.rnu = true
vim.opt.nu = true

-- make :vnew command split a new buffer to the right instead of left
vim.opt.splitright = true

-- set updatetime for git diff and other stuff, maybe
vim.opt.updatetime = 700

-- set tab size to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- ignore certain files and folders while using vimgrep
vim.opt.wildignore:append({
	'venv/**',
	'.venv/**',
	'node_modules/**',
	'*.pdf',
	'*.pyc',
	'*onnx',
})

-- language and spelling settings
vim.opt.spell = true
vim.opt.spelllang = 'es,en'

-- disable folding when opening a file
vim.opt.foldenable = false

-- remove redundant -- INSERT -- indicator
vim.opt.showmode = false

-- sync system clipboard with vim clipboard
-- vim.opt.clipboard:append({'unnamedplus'})
