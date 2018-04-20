call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'eparreno/vim-l9'
Plug 'vim-scripts/taghighlight', {'pinned': 1}
Plug 'ervandew/supertab'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neomake/neomake'

" Syntax plugins
Plug 'vim-scripts/vim-less'
Plug 'rust-lang/rust.vim'
Plug 'keith/swift.vim'

" Color schemes
Plug 'jonathanfilip/vim-lucius'
Plug 'chriskempson/base16-vim'

call plug#end()

set nocompatible
set nobackup
set nowrap
set noautochdir
set cursorline
set number
set ignorecase
set smartcase
set incsearch
set hlsearch
set ruler
set tabstop=2
set shiftwidth=2
set expandtab
set colorcolumn=80
set autoindent
set preserveindent
set foldmethod=manual
set laststatus=2
set encoding=utf8
set splitbelow
set splitright
set linespace=2

set guioptions-=T
set guioptions-=m
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guitablabel=%N:%M%t

set background=dark

if has('gui_running')
  colorscheme base16-ocean
  if has('gui_gtk2')
    set columns=150 lines=43
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
  elseif has('gui_win32')
    set columns=160 lines=45
    set guifont=Consolas:h11
  elseif has('gui_macvim')
    set columns=160 lines=45
    set guifont=Source\ Code\ Pro:h13
  endif
else
  set t_Co=256
  set background=dark
  colorscheme lucius
  if substitute(system("uname -s"), '\n', '', '') != "Darwin"
    hi Normal ctermbg=none
    hi NonText ctermbg=none
  endif
endif

" Fix for backspace
set backspace=indent,eol,start

" The Leader key
let mapleader = ' '

" One-button compile and run
nnoremap <F5>  :make<CR>
nnoremap <F9>  :SCCompile<CR>
nnoremap <F10> :SCCompileRun<CR>
if has("win32")
  " On Windows we use MinGW's make 
  set makeprg=mingw32-make
endif

" Open directory tree
nnoremap <C-T> :NERDTreeTabsToggle<CR>

" Navigate more easily between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Tab management and navigation
"nnoremap <C-S-T> <Esc>:tabnew<CR>
"nnoremap <C-S-W> <Esc>:tabclose<CR>
noremap <Leader>1 1gt
noremap <Leader>2 2gt
noremap <Leader>3 3gt
noremap <Leader>4 4gt
noremap <Leader>5 5gt
noremap <Leader>6 6gt
noremap <Leader>7 7gt
noremap <Leader>8 8gt
noremap <Leader>9 9gt

" Search for the visually selected sequence of characters 
vnoremap g/ y/<C-R>"<CR>

" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty. 
" (doesn't seem to work...)
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Automatically adjust quickfix window height
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" Commands to quickly switch between popular indentation styles
command! -nargs=0 T4  :set noexpandtab | :set tabstop=4 | :set shiftwidth=4
command! -nargs=0 T4s :set expandtab | :set tabstop=4 | :set shiftwidth=4
command! -nargs=0 T2  :set noexpandtab | :set tabstop=2 | :set shiftwidth=2
command! -nargs=0 T2s :set expandtab | :set tabstop=2 | :set shiftwidth=2
command! -nargs=0 T8  :set noexpandtab | :set tabstop=8 | :set shiftwidth=8

" Non-standard file extensions
autocmd BufRead,BufNewFile,BufWritePost *.gyp,*.gypi set filetype=python
autocmd BufRead,BufNewFile,BufWritePost *.h++ set filetype=cpp
autocmd BufRead,BufNewFile,BufWritePost *.sage set filetype=python
autocmd BufRead,BufNewFile,BufWritePost *.spyx,*.pyx set filetype=python.c

" Set search path for ctags database
" http://stackoverflow.com/a/741486/249230
set tags=./tags;/

" Fix curly brace error in C++11 lambdas
let c_no_curly_error = 1

" Airline settings
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
let g:airline#extensions#whitespace#max_lines = 1000

" clang_complete settings
let g:clang_library_path = '/usr/lib/llvm-3.4/lib'
let g:clang_auto_select = 1
let g:clang_complete_auto = 1
let g:clang_hl_errors = 1
let g:clang_user_options = '-std=c++11'
let g:clang_complete_macros = 1

" Syntactic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Neomake
call neomake#configure#automake('nw', 750)
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_java_javac_args = ['-cp', 'WebContent/WEB-INF/lib']

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_files = 0
let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn|node_modules|.*\.class)$'
nnoremap <M-b> :CtrlPBuffer<CR>

if filereadable($HOME."/.vimrc.local")
  exec "source ".$HOME."/.vimrc.local"
endif