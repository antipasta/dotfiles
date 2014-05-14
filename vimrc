" Basic vim setup {{{
syntax on
syntax enable
colors molokaimod
"colors elflord
set nocompatible
set ttyfast
set mouse=a
set history=100         
set ruler               " show the cursor position all the time
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
set bs=2                " allow backspacing over everything in insert mode
set winminheight=0
set scrolloff=5

" no beeping
set visualbell
set noerrorbells

" }}}

" Search {{{
set magic
" Ignore case in regex unless at least one capital 
set ignorecase
set smartcase

" Highlight all matches
set hlsearch

" Incremental search
set incsearch
" }}}

" Indenting {{{
filetype plugin indent on
set expandtab
set tabstop=4
set shiftwidth=4

" Dont expand tabs in makefiles
autocmd FileType make set noexpandtab
" }}}

" File manager settings {{{

set wildmenu
set wildmode=list:longest,full

" Open file manager in directory of current file
autocmd BufEnter * silent! lcd %:p:h

" }}}

" UTF8 {{{
set fileencodings=utf-8
set encoding=utf-8
set enc=utf-8
set fencs=utf-8
" }}}

" No backups or swap {{{
set nobackup
set nowritebackup
set noswapfile
" }}}

" Perl stuff {{{

let perl_include_pod = 1
let perl_extended_vars = 1
autocmd FileType perl set showmatch

" Prevent perl filetype plugin from adding @INC to autocomplete
let perlpath = '.'

" Check perl code with make
autocmd FileType perl set makeprg=perl\ -Ilib\ -c\ %\ $*

autocmd FileType perl set errorformat=%f:%l:%m
autocmd FileType perl set autowrite
autocmd FileType perl set expandtab
autocmd FileType perl set equalprg=perltidy

set iskeyword+=:

" Perldoc with K {{{
command! -bar -nargs=1 DoPod %!perldoc -t <args>

command! -bar -nargs=1 Pod
\   new
\|  DoPod <args>
\|  set syntax=pod
\|  goto 1
\|  set buftype=nofile
"Remap K to lookup perldoc
autocmd FileType perl noremap K :Pod <C-R><C-W><CR>
" }}}

" Comment and uncomment code {{{
map ,/ :s/^/\/\//<CR> <Esc>:noh<CR>
map ./ :s/^\/\///<CR> <Esc>:noh<CR>
map ,# :s/^/#/<CR> <Esc>:noh<CR>
map .# :s/^\(\s*\)#\+/\1<CR> <Esc>:noh<CR>
" }}}

" }}}

" Yank and Paste {{{
vmap <Leader>y :w! ~/.vimbuffer<CR>
nmap <Leader>y :.w! ~/.vimbuffer<CR>
nmap <Leader>p :r ~/.vimbuffer<CR>
vmap <Leader>Y :w ! ssh -p12344 joey@127.0.0.1 'pbcopy' <CR>
nmap <Leader>Y :.w ! ssh -p12344 joey@127.0.0.1 'pbcopy' <CR>
" }}}

" Function key toggles {{{
set pastetoggle=<F1>

"line number toggles
nnoremap <silent> <F2> :exec &nu==&rnu? "se nu!" : "se rnu!"<CR>
nnoremap <silent> <F3> :exec "se rnu!"<CR>
" }}}

" Basic key remapping {{{
let mapleader = ","
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Ctrl-I increments since Ctrl-A is my tmux key
noremap <C-I> <C-A>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>
nnoremap > >>
nnoremap < <<
vnoremap > >gv
vnoremap < <gv
nnoremap - }
nnoremap _ {
vnoremap - }
vnoremap _ {

nnoremap \ ;
nnoremap ; :
nnoremap 0 ^
nnoremap <Leader>r :Rack 

" w!! will save file with sudo
cabbrev w!! w !sudo tee % >/dev/null

"remove trailing whitespace
map .$ :%s/\s\+$//<CR> <Esc>:noh<CR>

" Move between tabs {{{
map <C-k> :tabnext<CR>
map <C-j> :tabprev<CR>
" }}}

" Jump to top and bottom of functions {{{
" from vim help docs
map [[ ?{<CR>w99[{<Esc>:noh<CR>
map ][ /}<CR>b99]}<Esc>:noh<CR>
map ]] j0[[%/{<CR><Esc>:noh<CR>
map [] k$][%?}<CR><Esc>:noh<CR>
" }}}

"shortcut for quoting and comma separating items
vmap <Leader>, :s/\v(\w+)/'\1',/g<CR><Esc>:noh<CR>
nmap <Leader>, :s/\v(\w+)/'\1',/g<CR><Esc>:noh<CR>

" }}}

" Autocomplete with tab {{{
function! CleverTab()
    if (strpart(getline('.'),col('.')-2,1)=~'^\W\?$')
      return "\<Tab>"
   else
      return "\<C-N>"
   endif
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>
" }}}

" Plugin setup {{{
" CtrlP setup
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Use ag with ack.vim if available
if executable("ag")
    let g:ackprg="ag --nocolor --nogroup --column"
endif
" }}}

"Misc {{{
autocmd FileType javascript set equalprg=js_beautify.pl\ -
set matchpairs+=<:>
" }}}

" vim: set fdm=marker:
