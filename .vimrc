set nocompatible "not compatible with vi
syntax on "syntax highlighting that is...
filetype plugin on "all plugins are on by default
filetype indent on 
set ruler
let mapleader=" "
set tags=tags;
" Tags, byebye JS 
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"
"set formatoptions-=c "don't break comments according to textwidth option
set hls "highlight search
set statusline=
set statusline+=%2*[b%n]%*\        " flags and buf no
set statusline+=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%m      "modified flag
set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}
set statusline+=%=      "left/right separator
set statusline+=x=%c,     "x=cursor column
set statusline+=y=%l/%L   "y=cursor line/total lines
set statusline+=\ (%P)    "percent through file
set showmode
set showcmd
set showmatch "matching brackets
"Set to auto read when a file is changed from the outside
set noautoread "when a file is changed outside of vim and it's in the buffer
"list, don't auto-read it, please...vim...
set lazyredraw "don't redraw screen when running macros
set matchtime=3 " 3/10 of second paren matches
set wildmenu " give me menu for tab completion
set noerrorbells "no annoying little vi error noises!
set scrolloff=3	"give me context of 3 lines when at top v bottom of buffer
set nobackup
set tabstop=2 " This is how many columns each tab counts for 
set softtabstop=2 " This is how many columns each tab counts for in INSERT mode. If noexpandtab is set and tabstop=softtabstop, VIM always uses tabs.
set noexpandtab "don't replace tabs with lines you crazy Vim
set sw=2 "shiftwidth
set nowrap "don't wrap text
set ai "auto indent
set si "smart indent
set cpoptions+=$ "compatibility with vi options, when using nmode c or C, show
"last changed character with $ instead of its value
autocmd! bufwritepost .vimrc source ~/.vimrc  
set nu "line numbering 
set incsearch "show search while typing, incrementally
set ignorecase " ignore the /i of regexes
set smartcase " but don't ignore them when I type a capital letter, to
"override it
"my Rails abbreviations
:iabbr ie initialize
:iabbr rto redirect_to
:iabbr bto button_to
:iabbr jsit javascript_include_tag
:iabbr attrac attr_accessible
:iabbr attra attr_accessor
:iabbr slt stylesheet_link_tag
:iabbr attrr attr_reader
:iabbr memail luke<DOT>gru<AT>gmail<DOT>com
:cabbr proj Project ~/.vim/projects/
:cabbr mks mks! ~/.vim/sessions/
colorscheme mayansmoke "slate is nicest default one for sure...blue, yellow, grey...
set viewdir=~/.vim/view "dir where mkview files are stored
set directory=~/.backup// "dir for swap files
set columns=100
set lines=70
set mousehide "Hide mouse until it's moved.
set mouse=a
set history=350 "command-line history remembered.
set bs=2 "backspace over everything in insert mode 
" :let loaded_project = 1 uncomment to turn off project plugin
set cmdheight=3 "cmd line height.
set path+=./**,~/rails_projects/depot2/** "project path, change when working on a diff.
"project
set laststatus=2 " All windows have status lines
set shortmess+=mrwx	" To avoid the 'Hit ENTER to continue' prompt
set helpheight=0 "minimum height for help wins, default=20, 0 is default split
"win height
let g:proj_flags='gimst' "default is imst, g toggles proj file w/ F12
set noequalalways "all windows auto-same size when splitting or closing
"set winminwidth=5
set winfixwidth   "splits resize width of current win. only (good for vsplits)
set splitright	  "verti. splits go right (good for vsplits)
"set winfixheight  "splits resize height of current win. only
set splitbelow		"horiz. splits go below (good for splits)

"n- and i-mode mappings
nnoremap <C-y> "+y
nnoremap <C-\> "+p
"oh vim...must I have to do this?
nmap Y y$
" Set the indent width to 2, 4, or 8
nmap <Leader>2 :setlocal tabstop=2 shiftwidth=2<CR>
nmap <Leader>4 :setlocal tabstop=4 shiftwidth=4<CR>
nmap <Leader>8 :setlocal tabstop=8 shiftwidth=8<CR>

" Fold current HTML tag.
nnoremap <Leader>Ft Vatzf

"--TAB MAPPINGS--
"CTRL-L, CTRL, R or tab previous, next
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
"ALT-L, ALT-R for moving tabs left/right
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>
"--/TAB MAPPINGS--

"fold mappings
nnoremap <silent> <CR> za
"/fold mappings

noremap <silent> <F3> <ESC>:e ~/.vimrc<CR>
" Open quickfix window
nmap <Leader>q :cwindow<CR>
nnoremap <F9> :set virtualedit=<CR>
nnoremap <F11> :set virtualedit=all<CR>
inoremap <A-m> <ESC> 
inoremap <F1> <ESC>
"/n- and i-mode mappings

"c-mode mappings
cnoremap <C-j> <S-left>
cnoremap <C-k> <S-right>
cnoremap <C-h> <left>
cnoremap <C-l> <right>
cnoremap <C-s> source ~/.vim/sessions/session
"/c-mode mappings

"v-mode mappings
vnoremap <C-y> "+y
"/v-mode mappings

"startup info + sessions:
set sessionoptions+=winpos
set sessionoptions-=options
set viminfo+=<100

if has("autocmd")
	au FileType mail,gitcommit setl tw=72
	au FileType mail,gitcommit echo "'textwidth' set to" &textwidth
  au BufRead *.txt setl tw=78
  " When editing a file, always jump to the last cursor position
	au FileType cpp,c,pl,sh,php setl cindent ts=8 sw=8
	au FileType python setl ts=4 sw=4 expandtab
	au BufReadPost *.yml setl expandtab
	au BufReadPost *.yml echo "'expandtab' option is set to" &expandtab
	"last cursor position in buffer
  au BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif
"++++++viminfo stuff that I don't use anymore++++++:
"
"autocmd User Rails      set noexpandtab "stop screwing with my noexpandtab!
"set viminfo='50,f1,<100,%5,nluke-gru "in order, save 50 file marks, global
"marks, at most 100 lines/register, 5 last buffer files (when starting vim
"without file options in xterm), viminfo file with name in ~ dir
":autocmd VimEnter	~/luke-gru	vr "on entering vim, viminfo read from luke-gru
":autocmd VimLeave	~/luke-gru	vw "on leaving vim, viminfo write to luke-gru
