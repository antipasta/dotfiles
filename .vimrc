set history=100         " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
set smartindent
set bs=2                " allow backspacing over everything in insert mode
set hlsearch
" set nohls " hlsearch if want highlighting
syntax on
set winminheight=0
set incsearch
set smartindent
set magic
"set nobackup
"set nowritebackup
set noswapfile
set backup
set backupdir=/~/.vim/backup
set directory=/~/.vim/tmp
map <F12> <C-W>_
map <F11> 25<C-W>_
 set matchpairs+=<:>
map <F6> mzggVG='z
map <C-k> :tabnext<CR>
map <C-j> :tabprev<CR>
vmap  / y/<C-R>=substitute(escape(@", '\\/.*$^~[]'), "\n", "\\\\n", "g")<CR><CR>
vmap <F5> y :!cpanm -v <C-r>"<CR>
vmap <F4> y :new \| :0read !perldoc -t <C-r>"<CR>:set syntax=pod<CR>:set buftype=nofile<CR>gg
map <F4> :new \| :0read !perl -Ilib -MO=Deparse,-p #<CR>:set syntax=perl<CR>:set buftype=nofile<CR>gg
vmap <F3> y :new \| :0read !perldoc -m <C-r>"<CR>:set syntax=perl<CR>:set buftype=nofile<CR>:file <C-r>" <CR>gg
set wildmenu
imap <C-\.> <C-n>
map ,/ :s/^/\/\//<CR> <Esc>:noh<CR>
map ./ :s/^\/\///<CR> <Esc>:noh<CR>
map ,# :s/^/#/<CR> <Esc>:noh<CR>
map .# :s/^#//<CR> <Esc>:noh<CR>
" map <C-J> <C-W>x<C-W><Down>
map <F9> :. s/title="\([^"]\+\)"/[% tooltip("\1") %]/g<CR>:. s/class="tooltip"//g<CR>/tooltip<CR>
set tabstop=4
set shiftwidth=4
set expandtab
autocmd BufRead *.as set filetype=java
autocmd BufRead *.tt set filetype=php
set dir=~/.vim/swp
" set t_Co=256
colors elflord
    "colorscheme oceanblack 
    "colors darkblue
    "colorscheme mustang 
    "colorscheme symfony 
    "colorscheme clouds-midnight 
    "colorscheme wombat256  
set ttyfast
set fileencodings=utf-8
set encoding=utf-8 
set enc=utf-8
set fencs=utf-8
" show matching brackets
autocmd FileType perl set showmatch


" check perl code with :make
autocmd FileType perl set makeprg=perl\ -Ilib\ -c\ %\ $*
autocmd FileType perl set errorformat=%f:%l:%m
autocmd FileType perl set autowrite
autocmd FileType perl set expandtab
autocmd FileType perl set equalprg=perltidy
autocmd FileType javascript set equalprg=js_beautify.pl\ -
autocmd FileType make set noexpandtab
let perl_include_pod = 1
autocmd FileType set equalprg&

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
nnoremap / /\v
vnoremap / /\v

"yank/paste to a buffer file for pasting between separate vi instances
vmap <Leader>y :w! ~/.vimbuffer<CR> 
nmap <Leader>y :.w! ~/.vimbuffer<CR>
nmap <Leader>p :r ~/.vimbuffer<CR>

"remove trailing whitespace
map .$ :s/\s\+$//<CR> <Esc>:noh<CR>

"shortcut for quoting and comma separating items
vmap <Leader>, :s/\v(\w+)/'\1',/g<CR>
nmap <Leader>, :s/\v(\w+)/'\1',/g<CR>
set visualbell           " don't beep
set noerrorbells         " don't beep
set pastetoggle=<Leader>1
nnoremap ; : 

" w!! will save file with sudo
cmap w!! w !sudo tee % >/dev/null

" changed to use leader from sam's version
map <Leader>[ gewi[<Esc>ea]<Esc>
map <Leader>{ gewi{<Esc>ea}<Esc>
map <Leader>' gewi'<Esc>ea'<Esc>
map <Leader>" gewi"<Esc>ea"<Esc>
map <Leader>( gewi(<Esc>ea)<Esc>
