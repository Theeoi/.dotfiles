""""""""""""""""""""""""
"   Standard Config!   "
""""""""""""""""""""""""

set nocompatible " Makes this .vimrc system-wide
syntax on " Enables syntax highlighting
set nowrap " Disable textwrapping by default
set encoding=utf8

" Enables linenumbers and cursor position
set number
set cursorline
set ruler

" Press \\ to jump back to the last cursor position.
nnoremap <leader>\ ``

" Set Proper Tabs
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

" Always display the status line
set laststatus=2

" Enables good searching
set incsearch
set hlsearch
nnoremap // :nohlsearch<CR>
nnoremap n nzz
nnoremap N Nzz

" Type jj to exit insert-mode
inoremap jj <esc>

" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Enable Elite mode, No ARRRROWWS!!!!
let g:elite_mode=1
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

""""""""""""""""""""""""
"    Plugin Config!    "
""""""""""""""""""""""""
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source ~/.vimrc
\| endif

call plug#begin('~/.vim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-surround' 
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'

Plug 'lervag/vimtex'
Plug 'vim-syntastic/syntastic'

call plug#end() " Enables filetype identification and syntax

""""""""""""""""""""""""
"    Theme Config!     "
""""""""""""""""""""""""

set t_Co=256
set background=dark
colorscheme dracula

""""""""""""""""""""""""
"   Specific Config!   "
""""""""""""""""""""""""
" Enable wrapping on words for tex-files
autocmd Filetype tex set wrap linebreak 

" LaTeX and qpdfview
let g:vimtex_view_general_viewer = 'qpdfview'
let g:vimtex_view_general_options
    \ = '--unique @pdf\#src:@tex:@line:@col'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:Tex_IgnoreWarnings =
    \"Intersentence spacing (`\@') should perhaps be used.\n".
    \"Underfull\n".
    \"Overfull\n".
    \"specifier changed to\n".
    \"You have requested\n".
    \"Missing number, treated as zero.\n".
    \"There were undefined references\n"
    \"Citation %.%# undefined"
let g:Tex_IgnoreLevel = 8

" Syntastic Configuration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Vim-Airline Configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1 
let g:airline_theme='hybrid'
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1

" NERDTree Config
map <C-n> :NERDTreeToggle<CR>

