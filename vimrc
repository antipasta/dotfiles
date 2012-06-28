set history=100         " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
set bs=2                " allow backspacing over everything in insert mode
set hlsearch
syntax on
set winminheight=0
set incsearch
set magic
set ignorecase
set smartcase
set ttyfast
set fileencodings=utf-8
set encoding=utf-8 
set enc=utf-8
set fencs=utf-8
set wildmenu
set tabstop=4
set shiftwidth=4
set expandtab
set nobackup
set nowritebackup
set noswapfile
"set backup
"set backupdir=~/.vim/backup
"set directory=~/.vim/tmp
 set matchpairs+=<:>
set visualbell           " don't beep
set noerrorbells         " don't beep
map <C-k> :tabnext<CR>
map <C-j> :tabprev<CR>
map ,/ :s/^/\/\//<CR> <Esc>:noh<CR>
map ./ :s/^\/\///<CR> <Esc>:noh<CR>
map ,# :s/^/#/<CR> <Esc>:noh<CR>
map .# :s/^\(\s*\)#\+<CR> <Esc>:noh<CR>
autocmd BufRead *.as set filetype=java
autocmd BufRead *.tt set filetype=php
set dir=~/.vim/swp
colors elflord
    "colorscheme oceanblack 
    "colors darkblue
    "colorscheme mustang 
    "colorscheme symfony 
    "colorscheme clouds-midnight 
    "colorscheme wombat256  
autocmd FileType perl set showmatch

" Prevent perl filetype plugin from adding @INC to autocomplete
"let perlpath = '/home/antipasta/perl5/lib/perl5/'
filetype plugin indent on
syntax enable

" check perl code with :make
autocmd FileType perl set makeprg=perl\ -Ilib\ -c\ %\ $*
autocmd FileType perl set errorformat=%f:%l:%m
autocmd FileType perl set autowrite
autocmd FileType perl set expandtab
autocmd FileType perl set equalprg=perltidy
autocmd FileType javascript set equalprg=js_beautify.pl\ -
autocmd FileType make set noexpandtab
let perl_include_pod = 1


" syntax color complex things like @{${"foo"}}
let perl_extended_vars = 1
set mouse=a
set iskeyword+=:


"joey changes start here-
"remap leader from \ to ,
let mapleader = ","
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>




"turn on magic for regexes, so i dont have to use vi's weird formatting for them
"nnoremap / /\v
"vnoremap / /\v

"yank/paste to a buffer file for pasting between separate vi instances
vmap <Leader>y :w! ~/.vimbuffer<CR> 
nmap <Leader>y :.w! ~/.vimbuffer<CR>
nmap <Leader>p :r ~/.vimbuffer<CR>

"remove trailing whitespace
map .$ :s/\s\+$//<CR> <Esc>:noh<CR>

"shortcut for quoting and comma separating items
vmap <Leader>, :s/\v(\w+)/'\1',/g<CR>
nmap <Leader>, :s/\v(\w+)/'\1',/g<CR>
set pastetoggle=<F1>
nnoremap ; : 

" w!! will save file with sudo
cabbrev w!! w !sudo tee % >/dev/null

" changed to use leader from sam's version
map <Leader>[ gewi[<Esc>ea]<Esc>
map <Leader>{ gewi{<Esc>ea}<Esc>
map <Leader>' gewi'<Esc>ea'<Esc>
map <Leader>" gewi"<Esc>ea"<Esc>
map <Leader>( gewi(<Esc>ea)<Esc>

set wildmode=list:longest,full
set scrolloff=5
" set dir to directory of current file
autocmd BufEnter * silent! lcd %:p:h


command! -bar -nargs=1 DoPod %!perldoc -t <args>

command! -bar -nargs=1 Pod
\   new
\|  DoPod <args>
\|  set syntax=pod
\|  goto 1
\|  set buftype=nofile
"Remap K to lookup perldoc
autocmd FileType perl noremap K :Pod <C-R><C-W><CR>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>
