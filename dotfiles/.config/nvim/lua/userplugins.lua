-- Plugins management and config

-- bootstrap packer
-- straight from https://github.com/wbthomason/packer.nvim#bootstrapping
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.vim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	-- packer itself
	use 'wbthomason/packer.nvim'

	-- fzf file finder
	-- use { 'junegunn/fzf', commit = '71fad63'}
	use { 'junegunn/fzf', run = "call fzf#install()", commit = 'fc69308057cf8486d2753efd76682fd613471da6' }
	use 'junegunn/fzf.vim'

	-- tmux integration/navigation
	use 'christoomey/vim-tmux-navigator'

	-- file tree view
	use { 'preservim/nerdtree', branch = 'master' }

	-- multi-line cursor similar to vscode/sublime-text
	use { 'mg979/vim-visual-multi', branch = 'master' }

	-- surround functionality for parentheses, brackets, quotes, etc
	use { 'tpope/vim-surround', branch = 'master' }

	-- editorconfig
	use 'editorconfig/editorconfig-vim'

	-- git diff lines
	use 'airblade/vim-gitgutter'

	-- tag viewer
	use 'preservim/tagbar'
	vim.g.tagbar_type_typescript = {
		ctagstype = 'typescript',
		kinds = {
			'c:class',
			'n:namespace',
			'f:function',
			'G:generator',
			'v:variable',
			'm:method',
			'p:property',
			'i:interface',
			'g:enum',
			't:type',
			'a:alias',
		},
		sro = '.',
		kind2scope = {
			c = 'class',
			n = 'namespace',
			i = 'interface',
			f = 'function',
			G = 'generator',
			m = 'method',
			p = 'property',
		},
	}

	-- mass comment lines
	use 'tpope/vim-commentary'

	-- html and tags autocomplete
	use 'mattn/emmet-vim'
	vim.g.user_emmet_settings = {
		javascript = {
			extends = 'jsx'
		},
		typescript = {
			extends = 'tsx'
		},
	}

	-- make % match xml tags
	use 'tmhedberg/matchit'

	-- latex plugin
	use 'lervag/vimtex'
	vim.g.tex_flavor = 'latex'
	vim.g.vimtex_view_method = 'zathura'
	vim.g.vimtex_quickfix_mode = 0

	-- snippet generator for generating code
	use 'SirVer/ultisnips'
	use 'honza/vim-snippets'
	use 'quangnguyen30192/cmp-nvim-ultisnips' -- for compat with cmp
	vim.g.UltiSnipsExpandTrigger = "<tab>"
	vim.g.UltiSnipsJumpForwardTrigger = "<C-j>"
	vim.g.UltiSnipsJumpBackwardTrigger = "<C-k>"

	-- status bar
	use 'itchyny/lightline.vim'
	vim.g.lightline = { colorscheme = 'moonfly' }

	-- undo tree
	use 'simnalamburt/vim-mundo'

	-- color scheme theme
	use 'arzg/vim-colors-xcode'
	use 'NLKNguyen/papercolor-theme'
	use 'bluz71/vim-moonfly-colors'

	-- Goyo for distraction-free writing
	use 'junegunn/goyo.vim'

	-- markdown syntax plugin
	use 'godlygeek/tabular'
	use 'preservim/vim-markdown'
	vim.g.vim_markdown_math = 1
	vim.g.vim_markdown_folding_disabled = 1
	vim.g.vim_markdown_fenced_languages = { 'css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby',
	'sass', 'xml', 'html', 'py=python', 'python', 'diff' }

	-- nvim lsp installer
	use 'williamboman/mason.nvim'

	-- nvim lsp config
	use 'williamboman/mason-lspconfig.nvim'
	use 'neovim/nvim-lspconfig'

	-- nvim dap
	use 'mfussenegger/nvim-dap'

	-- nvim linter & formatter
	-- use 'jose-elias-alvarez/null-ls.nvim'
	use 'nvimtools/none-ls.nvim'

	-- nvim autocomplete
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'

	-- tags generator
	use 'ludovicchabant/vim-gutentags'
	-- set tags folder to a tmp one
	vim.g.gutentags_cache_dir = '/tmp/vimtags'

	-- nvim lsp list of diagnostics
	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup {
				-- possible config
			}
		end
	}

	-- repeat for dot repeats to work
	use 'tpope/vim-repeat'

	-- leap for jumping in the file
	use 'ggandor/leap.nvim'
	require('leap').add_default_mappings()

	-- utilities for nvim plugins
	use "nvim-lua/plenary.nvim"

	-- treesitter for better syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
    }
	require'nvim-treesitter.configs'.setup {
	  -- A list of parser names, or "all" (the four listed parsers should always be installed)
	  ensure_installed = { "c", "lua", "vim", "help", "hcl", "terraform" },

	  highlight = {
		enable = true,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	  },

	  context_commentstring= {
		enable = true,
	  },
	}
	-- conditional mass comment based on treesitter config
	use "JoosepAlviste/nvim-ts-context-commentstring"

	-- toggle diagnostics
	use "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim"
	require('toggle_lsp_diagnostics').init()

	-- markdown preview
	use({
		"iamcco/markdown-preview.nvim",
		run = function() vim.fn["mkdp#util#install"]() end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
		require('lsp')
	end
end)
