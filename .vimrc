"pathogen
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
"/pathogen

set nocompatible "not compatible with vi
syntax enable

  if has("autocmd")
    filetype plugin on "all plugins are on by default
    filetype indent on
  endif

  if hostname() == 'luke-Pavilion-dv4000-PX311UA-ABL'
    set guifont=Inconsolata\ Medium\ 12
  else
    set guifont=Monospace\ 10
  endif

"terminal colors
"IMPORTANT: Uncomment one of the following lines to force
"using 256 colors (or 88 colors) if your terminal supports it,
"but does not automatically use 256 colors by default.
set t_Co=256
"set t_Co=88

  if (&t_Co == 256 || &t_Co == 88) && !has('gui_running') &&
     \ filereadable(expand("$HOME/.vim/plugin/guicolorscheme.vim"))
    " Use the guicolorscheme plugin to makes 256-color or 88-color
    " terminal use GUI colors rather than cterm colors.
    "runtime! plugin/guicolorscheme.vim
    "GuiColorScheme XXX
    colorscheme desert
  elseif has('gui_running') && &diff
    colorscheme peaksea
  else
    colorscheme blackboard
    "colorscheme blackboard
  endif
"/terminal colors


set ruler
set list "show me listchars
let mapleader=" "
set tags=tags;,tags
set textwidth=0 "default, overridden local to buffer for certain filetypes, see autocommands
set virtualedit=block "so useful, f11 virtualedit=all, f9 back to block
set nojoinspaces "oh historical reasons... for SHAME

"set formatoptions-=c "don't break comments according to textwidth option
set hls "highlight search
set statusline=
set statusline+=%2*[b%n]%*\        " flags and buf num.
set statusline+=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file form
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
set magic "see h pattern.tx
"Set to auto read when a file is changed from the outside
set noautoread "when a file is changed outside of vim and it's in the buffer
set lazyredraw "don't redraw screen when running macros
set matchtime=3 " 3/10 of second paren matches
set wildmenu " give me menu for tab completion
set wildmode=full "all I need (and default)
set noerrorbells "no annoying little vi error noises!
set scrolloff=3 "give me context of 3 lines when at top v bottom of buffer
set nobackup
set tabstop=2 " This is how many columns each literal tab indents
set softtabstop=2 " This is how many columns each tab counts for in INSERT mode. If noexpandtab is set and tabstop=softtabstop, VIM always uses tabs.
set expandtab "replace tab characters with spaces
set sw=2 "shiftwidth
set listchars=tab:>−,trail:−
set nowrap "don't wrap text by default, tw=0
set ai "auto indent
set si "smart indent
set cpoptions+=$ "compatibility with vi options, when using nmode c or C, show
"last changed character with $ instead of its value
set nu "line numbering
set incsearch "show search while typing, incrementally
set ignorecase " ignore the /i of regexes
set smartcase " but don't ignore them when I type a capital letter, to
"override i

"diff stuff
set diffopt+=vertical,context:4
"/diff stuff

"my Rails abbreviations
:iabbr ie initialize
:iabbr rto redirect_to
:iabbr bto button_to
:iabbr lto link_to
:iabbr jsit javascript_include_tag
:iabbr attrac attr_accessible
:iabbr attra attr_accessor
:iabbr attrr attr_reader
:iabbr attrw attr_writer
:iabbr slt stylesheet_link_tag
"/my Rails abbreviations
:iabbr mymail luke<DOT>gru<AT>gmail<DOT>com
:cabbr proj Project ~/.vim/projects/
:cabbr mks mks! ~/.vim/sessions/

set viewdir=~/.vim/views "dir where mkview files are stored
set directory=~/.backup// "dir for swap files, // ensures full path in swap name separated by %
set mousehide "Hide mouse until it's moved.
set mouse=
set history=40 "command-line history remembered. default = 20
set bs=2 "backspace over everything in insert mode
" :let loaded_project = 1 uncomment to turn off project plugin
set cmdheight=3 "cmd line height.
set path+=./**,~/.vim/pathinclude "search path when using gf, find sfind etc...
"project
set laststatus=2 " All windows have status lines
set shortmess+=mrwx " To avoid the 'Hit ENTER to continue' promp
set helpheight=20 "minimum height for help wins, default=20, 0 is default spli
"win height
let g:proj_flags='gimst' "default is imst, g toggles proj file w/ F12
set noequalalways "all windows auto-same size when splitting or closing
"set winminwidth=5
set winfixwidth   "splits resize width of current win. only (good for vsplits)
set splitright    "verti. splits go right (good for vsplits)
"set winfixheight  "splits resize height of current win. only
set splitbelow    "horiz. splits go below (good for splits)

"n- and i-mode mappings

"colorschemes and font types
nnoremap <Leader>fm :set guifont=Monospace\ 10<CR>
nnoremap <Leader>fi :set guifont=Inconsolata\ Medium\ 12<CR>
nnoremap <Leader>cm :colorscheme mayansmoke<CR>
nnoremap <Leader>cr :colorscheme railscasts<CR>
nnoremap <Leader>cb :colorscheme blackboard<CR>
nnoremap <Leader>cx :colorscheme xoria256<CR>
nnoremap <Leader>cs :colorscheme sorcerer<CR>
nnoremap <Leader>cp :colorscheme peaksea<CR>
"/colorschemes and font types

nnoremap <C-y> "+y
nnoremap <C-\> "+p
"oh vim...must I have to do this? Really should be vim default.
nmap Y y$
" Set the indent width to 2, 4, or 8
nmap <Leader>2 :setlocal tabstop=2 shiftwidth=2<CR>
nmap <Leader>4 :setlocal tabstop=4 shiftwidth=4<CR>
nmap <Leader>8 :setlocal tabstop=8 shiftwidth=8<CR>

"--TAB MAPPINGS--
"CTRL-L, CTRL, R or tab previous, nex
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
"ALT-L, ALT-R for moving tabs left/righ
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>
"--/TAB MAPPINGS--

"fold mappings
nnoremap <silent> <CR> z
"/fold mappings

noremap <silent> <F3> <ESC>:e ~/.vimrc<CR>
" Open quickfix window
nnoremap <F9> :set virtualedit=block<CR>
nnoremap <F11> :set virtualedit=all<CR>

"indenting, useful stuff..
nnoremap < <<
nnoremap > >>

" hightlight text I just pasted, compliments gv well
nnoremap gV `[v`]

inoremap <A-m> <ESC>
inoremap <F1> <ESC>

"Locate and return character above current cursor position regardless of blank lines
"taken directly from this vim-scripting tutorial:
"http://www.ibm.com/developerworks/linux/library/l-vim-script-1/index.html
function! LookUpwards()
  "Locate current column and preceding line from which to copy...
  let column_num      = virtcol('.')
  let target_pattern  = '\%' . column_num . 'v.'
  let target_line_num = search(target_pattern . '*\S', 'bnW')

  "If target line found, return vertically copied character...

  if !target_line_num
    return ""
  else
    return matchstr(getline(target_line_num), target_pattern)
  endif
endfunction
"Reimplement CTRL-Y within insert mode...
imap <silent>  <C-Y>  <C-R><C-R>=LookUpwards()<CR>

"/n- and i-mode mappings

"c-mode mappings
cnoremap <C-j> <S-left>
cnoremap <C-k> <S-right>
cnoremap <C-h> <left>
cnoremap <C-l> <right>
cnoremap <C-s> source ~/.vim/sessions/session
cnoremap <C-t> call LoadFileTemplate(
"/c-mode mappings

"v-mode mappings
vnoremap <C-y> "+y
"/v-mode mappings

"startup info + sessions:
set sessionoptions-=options
set viminfo+=<100

"colours
" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
"/colours

"working with wrapped tex
"softwrap
command! -nargs=* Swrap setl wrap linebreak nolist showbreak=…
"ellipsis = unicode 2026

"hard wrapping options in autocmds

if has("autocmd")
  "vimrc
  autocmd! bufwritepost .vimrc source $MYVIMRC
  "text and mail
  au FileType mail,gitcommit setl tw=72 list formatoptions formatoptions+=an
  au FileType mail,gitcommit echo "'textwidth' set to" &textwidth
  au BufRead *.txt setl tw=78 formatoptions formatoptions+=an
  "don't know if I like that for php, hopefully won't use php much anyway
  au FileType cpp,c,pl,sh,php setl cindent ts=8 sw=8
  au FileType python setl ts=4 sw=4 expandtab
  au BufReadPost *.yml setl expandtab
  au BufReadPost *.yml echo "'expandtab' option is set to" &expand
  au BufReadPost *.make setl noexpandtab ts=8 sts=8 sw=8
  au BufReadPost *.make echo "'expandtab' option is set to" &expand
  "rss as xml
  au BufReadPost *.rss set ft=xml
  "last cursor position in buffer
  au BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif

endif


if has("gui_running")
  " GUI is running or is about to start.
  " set gvim window size and set gvim fon
  au GUIEnter * set lines=80 columns=80
  au GUIEnter * winpos 618 24
else
  " This is console Vim.
  if exists("+lines")
    set lines=50
  endif
  if exists("+columns")
    set columns=100
  endif
endif

"autocmd User Rails      set noexpandtab "stop screwing with my noexpandtab!
