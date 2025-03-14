" General settings
set encoding=UTF-8
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set clipboard+=unnamedplus
set wrap
set cursorline
set termguicolors
set background=dark
syntax on
filetype plugin indent on

" vim-plug setup
call plug#begin('~/.config/nvim/plugged')

" --- Language Server and Code Completion ---
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletion & LSP

" --- Linting and Formatting ---
Plug 'dense-analysis/ale'                    " Linting and Fixing
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'morhetz/gruvbox'
Plug 'psf/black'                              " Python formatter
Plug 'tell-k/vim-autopep8'                    " AutoPEP8 for Python
Plug 'sbdchd/neoformat'                       " Code formatting
Plug 'rhysd/vim-clang-format'                 " Clang formatting for C/C++
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
" --- Debugging with nvim-dap ---
Plug 'mfussenegger/nvim-dap'                  " Debugging (DAP)
Plug 'rcarriga/nvim-dap-ui'                   " UI for nvim-dap
Plug 'mfussenegger/nvim-dap-python'           " Python DAP
Plug 'nvim-telescope/telescope-dap.nvim'      " Telescope integration for DAP

" --- Syntax Highlighting ---
Plug 'sheerun/vim-polyglot'                   " Syntax highlighting for many languages
Plug 'nvim-tree/nvim-web-devicons'
" --- File Navigation & UI Enhancements ---
Plug 'preservim/nerdtree'                     " File tree explorer
Plug 'ryanoasis/vim-devicons'                 " File icons
Plug 'itchyny/lightline.vim'                  " Status line
Plug 'nvim-lua/plenary.nvim'                  " Dependency for telescope
Plug 'nvim-telescope/telescope.nvim'          " Fuzzy finder
Plug 'tpope/vim-fugitive'                     " Git integration
Plug 'airblade/vim-gitgutter'                 " Git changes in the gutter
Plug 'nvim-neotest/nvim-nio'
call plug#end()
" Select All
nnoremap <C-a> ggVG

" Copy to System Clipboard
vnoremap <C-c> "+y

" Paste from System Clipboard
inoremap <C-v> <C-r>+
nnoremap <C-v> "+p
" Enable vim-devicons globally
let g:webdevicons_enable = 1

" --- LSP and Code Completion Configuration ---
let g:coc_global_extensions = ['coc-clangd','coc-pyright','coc-sh','coc-snippets']
"--- NERDTree Configuration ---
let g:NERDTreeShowHidden=1
nmap <C-b> :NERDTreeToggle<CR>
nmap <C-f> :NERDTreeFind<CR>

" --- ALE Linting Configuration ---
let g:ale_linters = {
\   'python': ['pylint'],
\   'cpp': ['clangd'],
\   'c': ['clangd'],
\   'sh': ['shellcheck']
\}
let g:ale_fixers = {
\   'python': ['black', 'autopep8'],
\   'cpp': ['clang-format'],
\   'c': ['clang-format'],
\   'sh': ['shfmt']
\}
let g:ale_fix_on_save = 1
nnoremap <C-s> :w<CR>:ALEFix<CR>:ALELint<CR>
inoremap <C-s> <Esc>:w<CR>:ALEFix<CR>:ALELint<CR>a

" open NERDTree automatically
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree

let g:NERDTreeGitStatusWithFlags = 1
"let g:WebDevIconsUnicodeDecorateFolderNodes = 1
"let g:NERDTreeGitStatusNodeColorization = 1
"let g:NERDTreeColorMapCustom = {
    "\ "Staged"    : "#0ee375",  
    "\ "Modified"  : "#d9bf91",  
    "\ "Renamed"   : "#51C9FC",  
    "\ "Untracked" : "#FCE77C",  
    "\ "Unmerged"  : "#FC51E6",  
    "\ "Dirty"     : "#FFBD61",  
    "\ "Clean"     : "#87939A",   
    "\ "Ignored"   : "#808080"   
    "\ }                         


let g:NERDTreeIgnore = ['^node_modules$']
" --- Debugging (nvim-dap) ---
lua << EOF
local dap = require('dap')
local dapui = require('dapui')

require('dapui').setup()

-- Python Debugging
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

-- Key mappings for debugging
vim.api.nvim_set_keymap('n', '<F5>', ':lua require("dap").continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F10>', ':lua require("dap").step_over()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F11>', ':lua require("dap").step_into()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F12>', ':lua require("dap").step_out()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>b', ':lua require("dap").toggle_breakpoint()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dr', ':lua require("dap").repl.open()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dl', ':lua require("dap").run_last()<CR>', { noremap = true, silent = true })

-- Open/Close DAP UI
vim.api.nvim_set_keymap('n', '<Leader>du', ':lua require("dapui").toggle()<CR>', { noremap = true, silent = true })
EOF

" --- Compilation & Running Code ---
autocmd FileType c nnoremap <F9> :w<CR>:!gcc -Wall % -o %:r && ./%:r<CR>
autocmd FileType cpp nnoremap <F9> :w<CR>:!g++ -Wall % -o %:r && ./%:r<CR>
autocmd FileType sh nnoremap <F9> :w<CR>:!bash %<CR>
autocmd FileType python nnoremap <F9> :w<CR>:!python3 %<CR>

" --- Telescope Mappings ---
nnoremap <C-p> :Telescope find_files<CR>
nnoremap <C-g> :Telescope live_grep<CR>
nnoremap <Leader>dt :Telescope dap commands<CR>

lua << EOF
require("toggleterm").setup({
    size = function(term)
        if term.direction == "horizontal" then
            return 15
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        else
            return 20
        end
    end,
    open_mapping = [[<c-j>]], -- Map Ctrl + j to toggle the terminal
    direction = 'float',      -- Set the terminal to open as a floating window
    float_opts = {
        border = 'curved',    -- Border style for the floating window
        width = function()
            return math.floor(vim.o.columns * 0.8) -- 80% of the editor width
        end,
        height = function()
            return math.floor(vim.o.lines * 0.8) -- 80% of the editor height
        end,
    },
})
EOF


" --- Auto Format on Save ---
autocmd BufWritePre *.py execute ':Black'
autocmd BufWritePre *.c,*.cpp execute ':ClangFormat'
autocmd BufWritePre *.sh execute ':Neoformat'

" --- Undo/Redo Mappings ---
nnoremap <C-z> u
nnoremap <C-r> <C-r>
inoremap <C-z> <Esc>u
inoremap <C-r> <Esc><C-r>
" --- Key Bindings for Moving Between Modes ---
inoremap <C-n> <Esc>
vnoremap <C-n> <Esc>
nnoremap i i
nnoremap v v
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"
set background=dark    " Set background to dark mode
colorscheme gruvbox    " Set colorscheme to Gruvbox
" --- Git Integration ---
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gc :Gcommit<CR>
nmap <Leader>gp :Gpush<CR>
nmap <Leader>gl :Gpull<CR>
