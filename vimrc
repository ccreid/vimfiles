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
set backupdir=$TEMP
set guifont=lucida_console:h10
colo chuck
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
set backspace=indent,eol,start
set directory=$TEMP
set vb
set wildmode=list:full
set foldlevelstart=20
:filetype on


function! FormatTrace()
   set filetype=xml
   %s/></>\r</g
   %s/\\"/"/g
   %s/\\\//\//g
   %s/\\u000d\\u000a/\r/g
"   %s/\({\|}\)/\r\1\r/g
   call UnescapeXML()
endfunction

function! FormatJSON()
   %s/\n//g
"newline after opening brace
   %s/{/{\r/g

"  closing braces get their own line (can't just do new after every
"  closing curly because closing curlies and commas can share a line)
   %s/}\(\s*\(,\|}\|\]\)\)\@!/}\r/g
   %s/}/\r}/g

"   newline after fields 
   %s/\("\|}\|\]\),/\1,\r/g

"handle array brackets
   %s/\[/[\r/g
   %s/\]/\r]/g
   
   set filetype=javascript
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
nnoremap j gj
nnoremap k gk
nnoremap <CR> :noh<CR>
"maximize and minimize
nnoremap <leader>k :simalt ~x<CR><C-W>=
nnoremap <leader>j :simalt ~r<CR><C-W>=
nnoremap <leader>cf :let @+ = expand("%") <CR>
nnoremap <leader>cp :let @+ = expand("%:p") <CR>
nnoremap <leader>t :call FormatTrace()<CR> gg =G :noh<CR>
nnoremap <leader>x :call UnescapeXML() gg =G :noh<CR>
nnoremap <leader>o :call FormatJSON()<CR> :noh<CR>

"setup folding for xml files
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
"maxmize window on startup
"au GUIEnter * simalt ~x

