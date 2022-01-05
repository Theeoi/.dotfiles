""""""""""""""""""""""""
"   Standard Config!   "
""""""""""""""""""""""""

set nocompatible " Makes this .vimrc system-wide
syntax enable " Enables syntax highlighting
set nowrap " Disable textwrapping by default
set textwidth=80
set guifont=mononoki\ Nerd\ Font\ Mono\ 12
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

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'

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

""" NERDTree Config
map <C-n> :NERDTreeToggle<CR>

""" Coc Config
let g:coc_global_extensions = [
    \'coc-pairs',
    \'coc-snippets',
    \'coc-texlab',
    \'coc-pyright',
    \'coc-html',
    \'coc-css',
    \'coc-tsserver'
    \]

set updatetime=300 " Faster updatetime for better coc-UX

" Use TAB to navigate coc suggestions
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Coc-GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
