set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'sjl/gundo.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'othree/html5.vim'
Plugin 'ag.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'mxw/vim-jsx'

call vundle#end()

" VISUAL STUFF
set title                 " Sets the title at top of tab to be the filename if "titlestring" isn't defined
set laststatus=1          " Has to do with the status bar at the bottom. Check :help laststatus
set number                " Line numbers on the left hand side
set visualbell            " That bell is the worst sound. Shut it the fuck off.
syntax enable             " Sets syntax highlighting on because what is this notepad
filetype plugin indent on " This gets vim to automatically load filetype specific options for plugins and indentation
hi LineNr   ctermfg=gray ctermbg=NONE
hi htmlTagName ctermfg=black ctermbg=NONE

" BASIC FUNCTIONALITY

set encoding=utf-8        " Duh
set history=5112          " Default is 20, I'd rather set this to infinity
set viminfo='1000,<500,:500,/500
set nofoldenable          " Don't fold shit because it's the worst.
set ignorecase smartcase

" Swap file stuff.
set noswapfile
set hidden
set undofile
set undodir=~/.vim/undo

" Formatting
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
"autocmd BufWritePre * :%s/\s\+$//e " Remove trailing whitespace on save

" Fix indenting for css style things (sass, css)
au BufEnter *.css set nocindent
au BufLeave *.css set cindent
au BufEnter *.scss set nocindent
au BufLeave *.scss set cindent
au BufEnter *.sass set nocindent
au BufLeave *.sass set cindent
au BufEnter *.less set nocindent
au BufLeave *.less set cindent

autocmd BufNewFile,BufRead *.scss set ft=scss.css "Sets filetype of scss to be css. Helps with plugins.
autocmd BufNewFile,BufRead *.less set ft=less.css "Sets filetype of less to be css. Helps with plugins.

" Enter newlines without entering insert mode
" http://vim.wikia.com/wiki/Insert_newline_without_entering_insert_mode
nnoremap <CR> o<Esc>k

" Local list nav
nnoremap fj :execute "noautocmd vimgrep /" . expand("<cword>") . "/j **" <Bar> cnext<CR>

nnoremap cn :cn<CR>
nnoremap cp :cp<CR>

" Custom Plugin Mappings
nnoremap ff :CtrlP<CR>
"nnoremap -- :GundoToggle<CR>

" Ignore node_modules in CtrlP
let g:ctrlp_custom_ignore = '\v[\/](\.(git|hg|svn)|node_modules)$'
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

let g:jsx_ext_required = 0 " Allow JSX in normal JS files

inoremap ;d :r !date -u <CR>
"set iskeyword+=- "Makes foo-bar considered one word
"


"let mapleader = ","
nnoremap <leader>v :e $MYVIMRC<CR>
nnoremap <leader>gx :Gbrowse<CR>
nnoremap <leader>g :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>c :ccl<CR>
nnoremap <leader>o :copen<CR>
map <Esc><Esc> :w<CR>

set wildignore=node_modules/*,*.jpg,*.png,*.gif,*.woff,node_modules " See :help wildignore
autocmd FileType css set omnifunc=csscomplete#CompleteCSS           " Gives css auto completion to files using filetype=css
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


" Escape/unescape & < > HTML entities in range (default current line).
function! HtmlEntities(line1, line2, action)
  let search = @/
  let range = 'silent ' . a:line1 . ',' . a:line2
  if a:action == 0  " must convert &amp; last
    execute range . 'sno/&lt;/</eg'
    execute range . 'sno/&gt;/>/eg'
    execute range . 'sno/&amp;/&/eg'
  else              " must convert & first
    execute range . 'sno/&/&amp;/eg'
    execute range . 'sno/</&lt;/eg'
    execute range . 'sno/>/&gt;/eg'
  endif
  nohl
  let @/ = search
endfunction
command! -range -nargs=1 Entities call HtmlEntities(<line1>, <line2>, <args>)
noremap <silent> \h :Entities 0<CR>
noremap <silent> \H :Entities 1<CR>

"Save read only files
cnoremap sudow w !sudo tee % >/dev/null
