
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Dec 17
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	      for Haiku:  ~/config/settings/vim/vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim


" if has("vms")
"   set nobackup		" do not keep a backup file, use versions instead
" else
"   set backup		" keep a backup file (restore to previous version)
"   if has('persistent_undo')
"     set undodir=~/.vim/undo
"     set undofile	" keep an undo file (undo changes after closing)
"   endif
" endif

set undofile
set undodir=~/.vim/undo


if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" line numbers
set number rnu

" no compatible mode
set nocp

" set hybrid numbers
" to disable: set nornu
" to toggle: set rnu!
set nu rnu

" for enabling mouse dragging while in tmux
set ttymouse=xterm2
set mouse=a

let g:powerline_pycmd="py3"

" always show powerline-vim, and add save indicator [+] next to the name if
" modified without saving
:set laststatus=2
:set statusline=[%n]\ %<%f%h%m

" allow ctrl and shift + arrow keys to work with Konsole. see:
" https://superuser.com/questions/532431/control-left-and-control-right-not-working-in-vim-within-a-screen-session
map  <Esc>[1;5A <C-Up>
map  <Esc>[1;5B <C-Down>
map  <Esc>[1;5D <C-Left>
map  <Esc>[1;5C <C-Right>
cmap <Esc>[1;5A <C-Up>
cmap <Esc>[1;5B <C-Down>
cmap <Esc>[1;5D <C-Left>
cmap <Esc>[1;5C <C-Right>

map  <Esc>[1;2D <S-Left>
map  <Esc>[1;2C <S-Right>
cmap <Esc>[1;2D <S-Left>
cmap <Esc>[1;2C <S-Right>

" tagbar toggle
nmap <F8> :TagbarToggle<CR>
" NERDTree toggle
nmap <F9> :NERDTreeToggle<CR>
nmap <F10> :NERDTreeFind<CR>

" coc mappings
" if has('nvim')
"   inoremap <silent><expr> <c-space> coc#refresh()
" else
"   inoremap <silent><expr> <c-@> coc#refresh()
" endif

" "" Use `[g` and `]g` to navigate diagnostics
" "" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)

" "" GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)

" "" Use K to show documentation in preview window.
" nnoremap <silent> K :call ShowDocumentation()<CR>

" function! ShowDocumentation()
"   if CocAction('hasProvider', 'hover')
"     call CocActionAsync('doHover')
"   else
"     call feedkeys('K', 'in')
"   endif
" endfunction

" "" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)


" "" Remap keys for applying codeAction to the current buffer.
" nmap <leader>ac  <Plug>(coc-codeaction)
" "" Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)

" fzf mappings
map <C-P> :Files<CR>
" replace fzf command to ignore git files
" let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" ctrl-A to select all
nnoremap <C-A> ggVG

" format json command
com! FormatJSON %!python -m json.tool

" disable preview window for tooltips
" see https://github.com/ycm-core/YouCompleteMe/issues/2015
set completeopt-=preview

" trim whitespace command
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()

" make :vnew command split a new buffer to the right instead of left
set splitright

" <\-y> to copy selection to system clipboard
noremap <Leader>y "+y

" on line breaks, make j and k move regardless of the file contents
nnoremap j gj
nnoremap k gk

" set colorcolumn and auto line breaks at N characters so that the lines break
" at automatically N characters
com! -nargs=1 LineCol set tw=<args> | set colorcolumn=<args>


" set a write mode and a code mode.
" inspired from: https://old.reddit.com/r/vim/comments/ckyspu/heres_how_to_create_custom_workspaces_to_switch/
:command ModeWrite colorscheme xcodelight | set linebreak | Goyo 90
:command ModeCode colorscheme xcodedarkhc | set linebreak! | Goyo!

" ale linters
let b:ale_linters = ['pyflakes', 'flake8', 'pylint']

" updatetime for git diff and other stuff, maybe
set updatetime=100

" set the color of the vertical column in script files (at 80 chars)
" see for colors: https://www.ditig.com/256-colors-cheat-sheet
highlight ColorColumn ctermbg=242

" enable true colors
set termguicolors
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" set tab size to 4 spaces
set tabstop=4
set shiftwidth=4

" ignore certain files and folders while using vimgrep
:set wildignore+=venv/**,.venv/**,node_modules,*.pdf,*.pyc,*onnx

" Default to static completion for SQL, to supress SQLComplete warning
let g:omni_sql_default_compl_type = 'syntax'
let g:loaded_sql_completion = 0
let g:omni_sql_no_default_maps = 1

" set tags folder to a tmp one
let g:gutentags_cache_dir = "/tmp/vimtags"

" enable math mode syntax highlight in markdown
let g:vim_markdown_math = 1
" disable folding in markdown
let g:vim_markdown_folding_disabled = 1

" disable folding when opening a file
set nofoldenable

" " markdown block syntax highlight
let g:vim_markdown_fenced_languages = ['css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'html', 'py=python', 'python']

" disable csv replacement of commas to pipes
let g:csv_no_conceal = 1

" vim latex settings
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
" set conceallevel=1
" let g:tex_conceal='abdmg'

" snippet settings
let g:UltiSnipsExpandTrigger="<C-Space>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"


" language and spelling settings
set spell
set spelllang=es,en
" mapping to fix all spelling errors on the line while editing
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" install vim plugged if it's missing
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" remove redundant -- INSERT -- indicator
set noshowmode

" set status bar lightline to match color theme moonfly
let g:lightline = { 'colorscheme': 'moonfly' }

" vim-plug section for downloading and installing plugins
call plug#begin('~/.vim/plugged')  

" " fzf, for file finder and explorer
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }   
Plug 'junegunn/fzf.vim'

" multi-line cursor similar to vscode/sublime-text
Plug 'mg979/vim-visual-multi', {'branch': 'master'}  

" surround functionality for parentheses, brackets, quotes, etc
Plug 'tpope/vim-surround', {'branch': 'master' } 

" file tree view
Plug 'preservim/nerdtree', {'branch': 'master'} 

" editorconfig
Plug 'editorconfig/editorconfig-vim'

" linter runner
Plug 'dense-analysis/ale'

" git diff lines
Plug 'airblade/vim-gitgutter'

" autocomplete
" Plug 'ycm-core/YouCompleteMe'
" disable youcompleteme ycm (comment to re-enable)
" let g:loaded_youcompleteme = 1

" disable ycm auto tooltip on hover, map to toggle ycm doc tooltip
" let g:ycm_auto_hover = ''
" nmap <leader>D <plug>(YCMHover)

" snippet and additional text editing
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" tag viewer
Plug 'preservim/tagbar'

" mass comment lines
Plug 'tpope/vim-commentary'

" html and tags autocomplete
Plug 'mattn/emmet-vim'

" make % match xml tags
Plug 'tmhedberg/matchit'

" hex color codes
" disabled for being slow for 'large' files (>1000 lines)
Plug 'lilydjwg/colorizer', { 'on': [] }

" jsx support and syntax highlight
Plug 'maxmellon/vim-jsx-pretty'

" jinja syntax highlight
Plug 'lepture/vim-jinja'

" tag manager/generator
Plug 'ludovicchabant/vim-gutentags'

" jupyter notebook editor
Plug 'goerz/jupytext.vim'

" latex plugin
Plug 'lervag/vimtex'

" snippet generator for generating code
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" color scheme theme
Plug 'arzg/vim-colors-xcode'
Plug 'bluz71/vim-moonfly-colors'

" advanced syntax highlight
Plug 'sheerun/vim-polyglot'

" Goto for distraction-free writing
Plug 'junegunn/goyo.vim'

" Search results count, etc
Plug 'google/vim-searchindex'

" markdown syntax plugin
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'

" python folding options
Plug 'tmhedberg/SimpylFold'

" tmux integration/navigation
Plug 'christoomey/vim-tmux-navigator'

" status bar
Plug 'itchyny/lightline.vim'

" undo tree
Plug 'simnalamburt/vim-mundo'
nnoremap <F5> :MundoToggle<CR>

call plug#end()

" set theme
" silent! colorscheme xcodedarkhc 
silent! colorscheme moonfly
