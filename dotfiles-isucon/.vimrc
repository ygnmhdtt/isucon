" vim-plug
" When update, call `:source ~/.vimrc` and `:PlugInstall`
call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'airblade/vim-gitgutter'
Plug 'elzr/vim-json'
Plug 'tpope/vim-endwise'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'w0ng/vim-hybrid'
Plug 'tpope/vim-fugitivE'
Plug 'junegunn/vim-easy-align'
Plug 'w0rp/ale'
Plug 'haya14busa/vim-auto-programming'
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

filetype plugin indent on

"----------------------------------------------------------------------------
" Edit
"----------------------------------------------------------------------------
set fenc=utf-8
set encoding=utf-8
set fileformats=unix,dos,mac
set ambiwidth=double
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
noremap PP "0p
" dont't yank x
noremap x "_x

" hit esc 2 times to disable highlight
noremap <Esc><Esc> :nohl<CR>

set clipboard=autoselect
set backspace=indent,eol,start

" Removing white spaces on end of line when saved file
autocmd BufWritePre * :call Rstrip()

function! Rstrip()
  let s:tmppos = getpos(".")
  if &filetype == "markdown"
    %s/\v(\s{2})?(\s+)?$/\1/e
    match Underlined /\s\{2}$/
  else
    %s/\v\s+$//e
  endif
  call setpos(".", s:tmppos)
endfunction

" open at last modified line
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

let mapleader = ","
nnoremap <Leader>w :w<CR>

"----------------------------------------------------------------------------
" UI
"----------------------------------------------------------------------------
syntax on
set number
set cursorline
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set laststatus=2

"----------------------------------------------------------------------------
" Tab
"----------------------------------------------------------------------------
set expandtab
set tabstop=2
set shiftwidth=2

"----------------------------------------------------------------------------
" Search
"----------------------------------------------------------------------------
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

" hit space 2 times to highlight focused word
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>

"----------------------------------------------------------------------------
" lightline.vim
"----------------------------------------------------------------------------
set noshowmode
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \    'left': [
  \      ['mode', 'paste'],
  \      ['readonly', 'filename', 'modified']
  \    ]
  \ },
\ }


"----------------------------------------------------------------------------
" ale
"----------------------------------------------------------------------------
let g:ale_fix_on_save = 1

"----------------------------------------------------------------------------
" fzf.vim
"----------------------------------------------------------------------------
" for fzf installed by homebrew
" set rtp+=/usr/local/opt/fzf

nmap ; :Buffers
nmap t :Files
" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~30%' }

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
nmap m :GGrep

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

"----------------------------------------------------------------------------
" vim-gitgutter
"----------------------------------------------------------------------------
" let g:gitgutter_sign_added = '∙'
" let g:gitgutter_sign_modified = '∙'
" let g:gitgutter_sign_removed = '∙'
" let g:gitgutter_sign_modified_removed = '∙'

"----------------------------------------------------------------------------
" vim-easy-align
"----------------------------------------------------------------------------
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"----------------------------------------------------------------------------
" nerdtree
"----------------------------------------------------------------------------
" autocmd vimenter * NERDTree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" autocmd VimEnter * wincmd p

"----------------------------------------------------------------------------
" indentLine
"----------------------------------------------------------------------------
" let g:indentLine_color_term = 255
" let g:indentLine_char = '|'

"----------------------------------------------------------------------------
" vim-auto-programming
"----------------------------------------------------------------------------
set completefunc=autoprogramming#complete
noremap <C-p> <C-x><C-u>

"----------------------------------------------------------------------------
" colorscheme
"----------------------------------------------------------------------------
set background=dark
colorscheme hybrid
" colorscheme moonshine
" colorscheme iceberg
" colorscheme molokai
" colorscheme solarized
" colorscheme jellybeans

"----------------------------------------------------------------------------
" Ruby
"----------------------------------------------------------------------------
augroup RubyAutoCmd
  au!
  au FileType ruby set shiftwidth=2 tabstop=2
augroup END

"----------------------------------------------------------------------------
" Javascript
"----------------------------------------------------------------------------
augroup JsAutoCmd
  au!
  au FileType javascript set shiftwidth=2 tabstop=2
augroup END

"----------------------------------------------------------------------------
" Golang
"----------------------------------------------------------------------------
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_autosave = 1
let g:go_gocode_unimported_packages = 1
let g:go_fmt_command = "goimports"

set completeopt=menu,preview
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")

augroup GoAutoCmd
  au!
  au FileType go :highlight goErr cterm=bold ctermfg=lightblue
  au FileType go :match goErr /\<err\>/
augroup END

inoremap <buffer> <C-X><C-O> <C-X><C-O><C-P>

"----------------------------------------------------------------------------
" Haskell
"----------------------------------------------------------------------------
augroup HaskellAutoCmd
  au!
  au FileType haskell set shiftwidth=2 tabstop=2
augroup END

"----------------------------------------------------------------------------
" Java
"----------------------------------------------------------------------------
augroup JavaAutoCmd
  au!
  au FileType java set shiftwidth=4 tabstop=4
  au FileType java setlocal noexpandtab
augroup END

"----------------------------------------------------------------------------
" Shell script
"----------------------------------------------------------------------------
augroup ShellScriptAutoCmd
  au!
  au FileType sh set shiftwidth=2 tabstop=2
augroup END

"----------------------------------------------------------------------------
" Vim script
"----------------------------------------------------------------------------
augroup VimScriptAutoCmd
  au!
  au FileType vim set shiftwidth=2 tabstop=2
augroup END

"----------------------------------------------------------------------------
" Makefile
"----------------------------------------------------------------------------
augroup MakefileAutoCmd
  au!
  au FileType make setlocal noexpandtab
augroup END

"----------------------------------------------------------------------------
" JSON
"----------------------------------------------------------------------------
let g:vim_json_syntax_conceal = 0
