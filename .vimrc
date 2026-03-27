" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off
 
"  Load plugins here using vim-plug
call plug#begin()

Plug 'Exafunction/windsurf.vim', { 'branch': 'main' }
Plug 'preservim/nerdtree'
Plug 'rishi-opensource/vim-claude-code'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'


call plug#end()

" Turn on syntax highlighting
syntax on
let mapleader = " "

" Plug settings
"  Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" Plugin bindings
"  NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let NERDTreeShowHidden=1
"  Airline
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
"  FZF
nnoremap <Leader>p :Files<CR>
nnoremap <Leader>g :Rg<CR>
nnoremap <Leader>b :Buffers<CR>
"  undotree
nnoremap <Leader>u :UndotreeToggle<CR>

" For plugins to load correctly
filetype plugin indent on


" Security
set modelines=0

" Show line numbers
set number
set relativenumber

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set nowrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk
" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" copying
" nnoremap <C-1> :call system("wl-copy", @")<CR>
xnoremap <silent> <F2> :w !wl-copy<CR><CR>

" Searching
" nnoremap / /\v
" vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search
" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>
" Textmate holdouts

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬

" Uncomment this to enable by default:
" set list " To enable by default

" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL
" Netrw: open explorer in a new tab with a vertical split
command! -nargs=? -complete=dir Sex tab split | execute 'Vexplore ' . <q-args>
" Color scheme (terminal)
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors/ and uncomment:
" colorscheme solarized
"
"Align CSV Files
"useage ':AlignCSV'
command! AlignCSV %s/,/,|/g | %!column -t -s '|'

" Clipboard
set clipboard=unnamedplus
