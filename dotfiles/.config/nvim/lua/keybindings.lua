-- Keybindings config

vim.keymap.set('n', '<C-A>', 'ggVG', {desc = 'Select entire file'})

vim.keymap.set('n', 'j', 'gj', {desc = 'Move cursor down regardless of linebreaks'})
vim.keymap.set('n', 'k', 'gk', {desc = 'Move cursor up regardless of linebreaks'})

vim.keymap.set('i', '<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u', {desc = 'Auto fix last spelling error with first suggestion'})

vim.keymap.set({'n', 'i', 'v'}, '<F9>', ':NERDTreeToggle<CR>', {desc = 'NERDTree toggle file tree'})
vim.keymap.set({'n', 'i', 'v'}, '<F10>', ':NERDTreeFind<CR>', {desc = 'NERDTree open file tree on current open file'})

vim.keymap.set({'n', 'i', 'v'}, '<F8>', ':TagbarToggle<CR>', {desc = 'Toggle tag/lsp symbol view'})

vim.keymap.set({'n', 'i', 'v'}, '<C-P>', ':Files<CR>', {desc = 'Open file by name'})

vim.keymap.set({'n', 'i', 'v'}, '<F5>', ':MundoToggle<CR>', {desc = 'Open undo tree'})
