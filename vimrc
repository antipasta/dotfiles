" Plugin installation {{{
call plug#begin('~/.vim/plugged')
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'ervandew/supertab'
    Plug 'vim-syntastic/syntastic'
    Plug 'junegunn/fzf', { 'dir': '~/bin/fzf', 'do': './install --all --no-key-bindings' }
    Plug 'junegunn/fzf.vim'
    Plug 'jamessan/vim-gnupg'
    Plug 'vim-scripts/openssl.vim'
call plug#end()
" }}}

" Basic vim setup {{{
syntax on
syntax enable
colors molokaimod
"colors elflord
set nocompatible
set ttyfast
"set mouse=a
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
autocmd FileType html,yaml,json setlocal tabstop=2
autocmd FileType html,yaml,json setlocal shiftwidth=2

" Dont expand tabs in makefiles
autocmd FileType make set noexpandtab
" }}}

" File types {{{
au BufNewFile,BufRead *.html.tpl set filetype=html

" }}}

" File manager settings {{{

set wildmenu
set wildmode=list:longest,full
set wildignore+=*/bower_components/*,*/node_modules/*,*.so,*.swp,*.zip

" Open file manager in directory of current file
autocmd BufEnter * silent! lcd %:p:h
set autochdir


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
autocmd FileType go set equalprg=gofmt

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

nmap <leader>e V:s/,/,\r/g<CR>:noh<CR>
vmap <leader>e :s/,/,\r/g<CR>:noh<CR>

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
nnoremap <Leader>f :Gitag 
nnoremap <Leader>* :Gitag <cword><CR>
nnoremap <Leader>t :SyntasticToggle<CR>
autocmd FileType go setlocal omnifunc=go#complete#Complete

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
" }}}

"shortcut for quoting and comma separating items
vmap <Leader>, :s/,/,\r/g<CR><Esc>:noh<CR>
nmap <Leader>, :s/\v(\w+)/'\1',/g<CR><Esc>:noh<CR>
nmap <Leader>= [[V%=

" }}}
" Yank and Paste {{{
vmap <Leader>y :w! ~/.vimbuffer<CR>
nmap <Leader>y :.w! ~/.vimbuffer<CR>
nmap <Leader>p :r ~/.vimbuffer<CR>
" }}}


" Plugin setup {{{

" Use ag with ack.vim if available
if executable("ag")
    let g:ackprg="ag --nocolor --nogroup --column"
endif

" fzf setup
function! s:find_git_root()
      return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

fun! FzfOmni()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GitFiles
  endif
endfun


if executable("fzf")
    command! -bang -nargs=+ -complete=dir Gitag call fzf#vim#ag_raw(<q-args> . ' ' . s:find_git_root(), 
      \                 <bang>0 ? fzf#vim#with_preview('up:60%')
      \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
      \                 <bang>0)

    let g:fzf_layout = { 'down': '~40%' }
    nnoremap <silent> <C-P> :<C-u>GFiles<CR>
    let g:fzf_colors =
                \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }
endif
" }}}

"Misc {{{
autocmd FileType javascript set equalprg=js-beautify\ -
"autocmd FileType html set equalprg=tidy\ -q\ -i\ --show-errors\ 0\ -
autocmd FileType html set equalprg=js-beautify\ --type\ html\ -
set matchpairs+=<:>
" omni complete pops up annoying preview window
set completeopt-=preview
"au FileType go let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabDefaultCompletionType = "context"
autocmd FileType javascript let g:SuperTabDefaultCompletionType= '<c-p>'
autocmd FileType *
    \ if &omnifunc != '' |
    \   call SuperTabChain(&omnifunc, "<c-n>") |
    \ endif
" }}}

"Go stuff {{{
let g:go_version_warning = 0
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
au FileType go nmap <Leader>dx <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <Leader>l :%s/\s*q.Q(.*$\n//g<CR>
map <C-n> :lne<CR>
map <C-m> :lp<CR>
"let g:go_auto_type_info = 1
"set updatetime=100
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1


" }}}

"Syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_html_tidy_exec = 'tidy'
let g:syntastic_html_tidy_ignore_errors = [ 'is not recognized', 'proprietary attribute' ]
let g:syntastic_yaml_checkers = ['yamllint']
let g:syntastic_yaml_yamllint_quiet_messages = {"regex" : 'missing document start\|line too long\|too many spaces inside braces'}



" Reccommendation of when using syntastic with vimgo to prevent lag
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
let g:syntastic_quiet_messages = { "regex": 'should have comment\|comment on' }

let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['html', 'perl'] }

"" }}}

let g:GPGDefaultRecipients=['0x059BE1E2A99DA7EB']
augroup GPGFile
    nmap <silent> <C-W>Q <C-W>qi
augroup END

" For working with creds file
augroup CredFile
      au! BufRead,BufNewFile,BufEnter creds.yml.asc nmap <Leader>o f:w"+y$0yt::vs ../sf-deploy-application/<C-r>".aes<CR>
augroup END

let g:nv_search_paths = ['~/wiki']

" vim: set fdm=marker:
