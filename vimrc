"source ~/vimfiles/bundle/vim-pathogen/autoload/pathogen.vim
"execute pathogen#infect()

set nocompatible
set incsearch
set hlsearch
set ignorecase
set smartcase
set smartindent
set autoindent
set expandtab
set shiftwidth=3
set tabstop=3
set nowrap
set ruler
set cursorline
set hidden
colo chuck
source $VIMRUNTIME/vimrc_example.vim
set backspace=indent,eol,start

set vb
set wildmode=list:full
set foldlevelstart=20
set number
filetype plugin indent on
syntax on

function! FormatJSON()
   %s/\n//g
   "newline after opening brace
   %s/{/{\r/g

   "  closing braces get their own line (can't just do new after every
   "  closing curly because closing curlies and commas can share a line)
   %s/}\(\s*\(,\|}\|\]\)\)\@!/}\r/g
   %s/}/\r}/g

   "   newline after fields 
   "%s/\("\|}\|\]\|\(null\)\),/\1,\r/g
   %s/\("[^"]*":[^,]*,\)/\1\r/g

   "  newline after objects and arrays
   %s/\(}\|\]\)\s*,/\1,\r/g

   "handle array brackets
   %s/\[/[\r/g
   %s/\]/\r]/g

   set filetype=json
   "set indentexpr&
endfunction

function! UnescapeXML()
   %s/\n//g
   %s/&lt;/</g
   %s/&gt;/>/g
   %s/&quot;/"/g
   %s/&amp;/\&/g
   %s/>\s*</>\r</g
endfunction

"key mappings
let mapleader = ","
"when lines wrap, navigate one visual line at a time
"nnoremap j gj
"nnoremap k gk
nnoremap <C-l> :noh<CR><C-l>
nnoremap <leader>l :noh<CR>
nnoremap <leader>, =
nnoremap <leader>cf :let @+ = expand("%") <CR>
nnoremap <leader>cp :let @+ = expand("%:p") <CR>
nnoremap <leader>x :call UnescapeXML() gg =G :noh<CR>
nnoremap <leader>o :call FormatJSON()<CR> :noh<CR> 
noremap <C-n> :NERDTreeToggle<CR>

"setup folding for xml files
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
"maxmize window on startup
"au GUIEnter * simalt ~x
"yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

if has("win32")
   set directory=$TEMP
   set backupdir=$TEMP
   source $VIMRUNTIME/mswin.vim
   behave mswin
   noremap <A-n> :NERDTreeFind<CR>
endif

if has("gui_win32")
   set guifont=lucida_console:h10
   "maximize and minimize
   nnoremap <leader>k :simalt ~x<CR><C-W>=
   nnoremap <leader>j :simalt ~r<CR><C-W>=
endif

if has("unix")
   set directory=~/tmp
   set backupdir=~/tmp
   "maximize and minimize
   nnoremap <leader>k :set lines=999 columns=999<cr>
   nnoremap <leader>j :set lines=26 columns=80<cr>
   noremap ˜ :NERDTreeFind<CR>
endif

set tw=0
set packpath+=~/.vim/pack/plugins
