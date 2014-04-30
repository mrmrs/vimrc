set nocompatible      " This should be the first line. It sets vim to not be backwards compatible with vi.
let mapleader = ","   " Set the map leader. Useful for custom commands.

" Install and setup vundle https://github.com/gmarik/Vundle.vim
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" PLUGINS
" Personally I wouldn't want to live without these

Bundle 'tpope/vim-fugitive'              " Wrapper for git:                   https://github.com/tpope/vim-fugitive
Bundle 'kien/ctrlp.vim'                  " Fuzzy file finder:                 https://github.com/kien/ctrlp.vim
Bundle 'sjl/gundo.vim'                   " Vim history visualizer:            https://github.com/sjl/gundo.vim
Bundle 'tomtom/tlib_vim'                 " Required bundle for snipmate-plus
Bundle 'MarcWeber/vim-addon-mw-utils'    " Require bundle for snipmate-plus
Bundle 'acevery/snipmate-plus'           " Snippets in vim:                   https://github.com/acevery/snipmate-plus
Bundle 'ag.vim'                          " The fastest search:                https://github.com/rking/ag.vim

" Syntax plugins
Bundle 'groenewege/vim-less'
Bundle 'othree/html5.vim'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'ap/vim-css-color'

" STUFF
set title                   " Sets the title at top of tab to be the filename if "titlestring" isn't defined
set laststatus=1            " Has to do with the status bar at the bottom. Check :help laststatus
set number                  " Line numbers on the left hand side
set visualbell              " That bell is the worst sound. Shut it the fuck off.
syntax enable               " Sets syntax highlighting on because what is this notepad
filetype plugin indent on   " This gets vim to automatically load filetype specific options for plugins and indentation

"" BASIC FUNCTIONALITY
set encoding=utf-8    " Duh
set history=512       " Default is 20, I'd rather set this to ∞
set nofoldenable      " Don't fold shit because it's the worst.

" Swap file stuff. If you don't have one make an undodir in ~/.vim
" In terminal just type mkdir -p ~/.vim/undodir
set noswapfile
set hidden
set undofile
set undodir=~/.vim/undodir

autocmd BufWritePre * :%s/\s\+$//e " Remove trailing whitespace on save

" Formatting
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" Grab last edited / pasted text
nnoremap gp `[v`]

" Fix indenting for css style things (sass, css)
au BufEnter *.css set nocindent
au BufLeave *.css set cindent
au BufEnter *.scss set nocindent
au BufLeave *.scss set cindent
au BufEnter *.less set nocindent
au BufEnter *.styl set nocindent
au BufLeave *.styl set cindent

autocmd BufNewFile,BufRead *.scss set ft=scss.css "Sets filetpe of scss to be css. Helps with plugins.
autocmd BufNewFile,BufRead *.less set ft=less.css "Sets filetpe of less to be css. Helps with plugins.
autocmd BufNewFile,BufRead *.styl set ft=styl.css "Sets filetpe of less to be css. Helps with plugins.

" Omnicompletion
imap <leader>m <c-x><c-o>
imap <leader>, <esc>

" Enter newlines without entering insert mode
" http://vim.wikia.com/wiki/Insert_newline_without_entering_insert_mode
nnoremap <CR> o<Esc>k

set statusline+=%*

" Tab Navigation
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tn  :tabnew<CR>

" I like to roll through buffers like
nnoremap <leader>m  :bn<CR>
nnoremap <leader>n  :bp<CR>

nnoremap <leader>p  :set paste!<CR>

" Local list nav
nnoremap fj :execute "noautocmd vimgrep /" . expand("<cword>") . "/j **" <Bar> cnext<CR>

" Run through jumplist with ease
nnoremap cn :cn<CR>
nnoremap cp :cp<CR>

" Custom Plugin Mappings
nnoremap ff :CtrlP<CR>
nnoremap -- :GundoToggle<CR>

let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_custom_ignore = '\v[\/](\.(git|hg|svn)|node_modules)$'

"set iskeyword+=- "Makes foo-bar considered one word
"
nnoremap <leader>ev :e $MYVIMRC<cr> " ,ev will open up your vimrc in a vertical split
nnoremap <leader>gb :Gbrowse<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>c :ccl<cr>
nnoremap <leader>o :copen<cr>

map <Esc><Esc> :w<CR>

set wildignore=node_modules/*,*.jpg,*.png,*.gif,*.woff,node_modules
autocmd FileType css set omnifunc=csscomplete#CompleteCSS " Gives css auto completion to files using filetype=css
