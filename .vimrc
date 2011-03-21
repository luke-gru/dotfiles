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
  elseif has("mac")
    set guifont=Monaco:h12
  elseif has("win32")
    set guifont=Consolas:h11,Courier\ New:h10
  elseif has("unix")
    if &guifont == ""
      set guifont=bitstream\ vera\ sans\ mono\ 10
    endif
  endif

"terminal colors. test `tput colors`
" IMPORTANT: Uncomment one of the following lines to force
" using 256 colors (or 88 colors) if your terminal supports it,
" but does not automatically use 256 colors by default.
set t_Co=256
" set t_Co=88
set background=dark

  if (&t_Co == 256 || &t_Co == 88) && !has('gui_running')
    " \ filereadable(expand("$HOME/.vim/plugin/guicolorscheme.vim"))
    " Use the guicolorscheme plugin to makes 256-color or 88-color
    " terminal use GUI colors rather than cterm colors.
    " runtime! plugin/guicolorscheme.vim
    " GuiColorScheme XXX
    colorscheme xoria256
  elseif &diff
    colorscheme peaksea
  else
    colorscheme blackboard
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
set magic "see h pattern.txt
"Set to auto read when a file is changed from the outside
set autoread "when a file is changed outside of vim and it's in the buffer
set lazyredraw "don't redraw screen when running macros
set matchtime=3 " 3/10 of second paren matches
set wildmenu " give me menu for tab completion
set wildmode=full "all I need (and default)
set noerrorbells "no annoying little vi error noises!
set scrolloff=3 "give me context of 3 lines when at top v bottom of buffer
set nobackup
set tabstop=2 " This is how many columns each literal tab indents
set softtabstop=2 " This is how many columns each tab key hit counts for in INSERT mode. If noexpandtab is set and tabstop=softtabstop, VIM always uses tabs.
set expandtab "replace tab characters with spaces
set sw=2 "shiftwidth
set listchars=tab:>−,trail:−
set nowrap "don't wrap text by default, tw=0
set formatprg=par "use par to format paragraphs. Default tw is 72
set ai "auto indent
set si "smart indent
set cpoptions+=$ "compatibility with vi options, when using nmode c or C, show
"last changed character with $ instead of its value
set nu "line numbering
set incsearch "show search while typing, incrementally
set ignorecase " ignore the case of regexes
set smartcase " but don't ignore them when I type a capital letter, to
"override i
if exists("+spelllang")
  set spelllang=en_us
endif
set pastetoggle=<F8>




"diff stuff
set diffopt+=vertical,context:4

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
  \ | wincmd p | diffthis
endif

" diff mappings
nmap <leader>dh :DiffOrig<CR>
nmap <leader>du :diffupdate<CR>
nmap <leader>do :diffoff<CR>
"/diff stuff

"alignment stuff (taken from vimcasts.org)
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif
"/alignment stuff

"wipe all hidden buffers
function! CloseHiddenBuffers()
  " figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " close any buffer that are loaded and not visible
  let l:tally = 0
  for b in range(1, bufnr('$'))
    if bufloaded(b) && !has_key(visible, b)
      let l:tally += 1
      exe 'bw ' . b
    endif
  endfor
  echon "Deleted " . l:tally . " buffers"
endfun

command! -nargs=* Only call CloseHiddenBuffers()
"/wipe all hidden buffers

"edit file in same dir. as current buffer mappings
map <leader>ee :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
"/edit mappings

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
:cabbr mks mks! ~/.vim/sessions/session

set viewdir=~/.vim/views "dir where mkview files are stored
set directory=~/.backup// "dir for swap files, // ensures full path in swap name separated by %
set mousehide "Hide mouse until it's moved.
set mouse=a
set history=40 "command-line history remembered. default = 20
set bs=2 "backspace over everything in insert mode
" :let loaded_project = 1 uncomment to turn off project plugin
set cmdheight=3 "cmd line height.
set path+=./**,~/.vim/pathinclude "search path when using gf, find sfind etc...
"project
set laststatus=2 " All windows have status lines
set shortmess=at " To avoid the 'Hit ENTER to continue' promp
set helpheight=20 "minimum height for help wins, default=20, 0 is default spli
"win height
let g:proj_flags='imst' "default is imst, g toggles proj file w/ F12
set noequalalways "all windows auto-same size when splitting or closing
"set winminwidth=5
set winfixwidth   "splits resize width of current win. only (good for vsplits)
set splitright    "verti. splits go right (good for vsplits)
"set winfixheight  "splits resize height of current win. only
set splitbelow    "horiz. splits go below (good for splits)

"n- and i-mode mappings

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction 

if version >= 730
  nnoremap <F12> :GundoToggle<CR>
else
  nmap <F12> <Nop>
endif

" stop hightlighting for hlsearch, turn back on w/ next search
nnoremap <leader>n :noh<CR>

" colorschemes and font types
nnoremap <Leader>fm :set guifont=Monospace\ 10<CR>
nnoremap <Leader>fi :set guifont=Inconsolata\ Medium\ 12<CR>
nnoremap <Leader>cm :colorscheme mayansmoke<CR>
nnoremap <Leader>cv :colorscheme vividchalk<CR>
nnoremap <Leader>cb :colorscheme blackboard<CR>
nnoremap <Leader>cx :colorscheme xoria256<CR>
nnoremap <Leader>ci :colorscheme ir_black<CR>
nnoremap <Leader>cp :colorscheme peaksea<CR>
command! -bar Starwars :let &background = (&background=="light"?"dark":"light")
command! -bar -nargs=0 Bigger :let &guifont = substitute(&guifont,'\d\+$','\=submatch(0)+1','')
command! -bar -nargs=0 Smaller :let &guifont = substitute(&guifont,'\d\+$','\=submatch(0)-1','')
" /colorschemes and font types

" rails-vim mappings
nnoremap <leader>rc :Rcontroller<CR>
nnoremap <leader>rvc :RVcontroller<CR>
nnoremap <leader>rml :Rmigration<CR>
nnoremap <leader>rmi :Rinvert<CR>
nnoremap <leader>rep :Rextract<CR>
" /rails-vim mappings

nnoremap <C-y> "+y
nnoremap <C-\> "+p
" yanking remaps
nmap gy y$
nnoremap Y :call Preserve("normal 0y$")<CR>

" Set the indent width to 2, 4, or 8
nmap <Leader>2 :setlocal tabstop=2 shiftwidth=2<CR>
nmap <Leader>4 :setlocal tabstop=4 shiftwidth=4<CR>
nmap <Leader>8 :setlocal tabstop=8 shiftwidth=8<CR>

" --TAB MAPPINGS--
"  CTRL-L, CTRL, R or tab previous, next
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
"  ALT-L, ALT-R for moving tabs left/right
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>
" --/TAB MAPPINGS--

" fold mappings
nmap <silent> <CR> za
" /fold mappings

noremap <silent> <F3> <ESC>:e $MYVIMRC<CR>

nnoremap <F9> :set virtualedit=block<CR>
nnoremap <F11> :set virtualedit=all<CR>
nnoremap <leader>l :set list!<CR>

" indenting, useful stuff..
nnoremap < <<
nnoremap > >>

" hightlight text I just pasted, compliments gv well
nnoremap gV `[v`]

inoremap <A-m> <ESC>
inoremap <F1> <ESC>
" omnicompletion
inoremap <silent> <C-o> <C-x><C-o>

" Locate and return character above current cursor position regardless of blank lines
" taken directly from this vim-scripting tutorial:
" http://www.ibm.com/developerworks/linux/library/l-vim-script-1/index.html
function! LookUpwards()
  " Locate current column and preceding line from which to copy...
  let column_num      = virtcol('.')
  let target_pattern  = '\%' . column_num . 'v.'
  let target_line_num = search(target_pattern . '*\S', 'bnW')

  " If target line found, return vertically copied character...

  if !target_line_num
    return ""
  else
    return matchstr(getline(target_line_num), target_pattern)
  endif
endfunction
" Reimplement CTRL-Y within insert mode...
imap <silent>  <C-Y>  <C-R><C-R>=LookUpwards()<CR>


nmap <leader>- :call Preserve("%s/\s\+$//e")<CR>
nmap <leader>= :call Preserve("normal gg=G")<CR>
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
vnoremap <Space> I<Space><Esc>gv
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

"working with wrapped text
" softwrap
command! -nargs=* Swrap setl wrap linebreak nolist showbreak=…
" ellipsis = unicode 2026

" (hard wrapping options in autocmds below for filetypes)

if has("autocmd")

  "mozrepl stuff
  function! Refresh_firefox()
    if &modified && has("gui_running")
      write
      silent !echo  'vimYo = content.window.pageYOffset;
            \ vimXo = content.window.pageXOffset;
            \ BrowserReload();
            \ content.window.scrollTo(vimXo,vimYo);
            \ repl.quit();'  |
            \ nc localhost 4242 2>&1 > /dev/null
    endif
  endfunction

  command! -nargs=1 Repl silent !echo
        \ "repl.home();
        \ content.location.href = '<args>';
        \ repl.enter(content);
        \ repl.quit();" |
        \ nc localhost 4242

  nmap <leader>mh :Repl http://
  "mnemonic is Http
  nmap <silent> <leader>ml :Repl file:///%:p<CR>
  "mnemonic is Local
  nmap <silent> <leader>ms :Repl http://localhost/

  autocmd BufWriteCmd *.html*,*.css :call Refresh_firefox()
  "/mozrepl stuff

  "vimrc
  autocmd! bufwritepost .vimrc source $MYVIMRC
  "text and mail
  au FileType mail,gitcommit setl tw=72 list formatoptions formatoptions+=an
  "-q option for par handles nested quotations in plaintext mail
  au FileType mail setl formatprg=par\ -q
  au FileType qf unmap <buffer> <CR>
  au FileType mail,gitcommit echo "'textwidth' set to" &textwidth
  au BufRead *.txt setl tw=78 formatoptions formatoptions+=an formatprg=par\ -w78
  "don't know if I like that for php, hopefully won't use php much anyway
  au FileType cpp,c,cs,java setl ai et sta sw=4 sts=4 cin
  au FileType php,vb setl ai et sta sw=4 sts=4
  au FileType xml,xsd,xslt setl ai et sw=2 sts=2 ts=2
  au FileType python setl ts=4 sw=4 expandtab
  au FileType ruby set omnifunc=rubycomplete#Complete |
        \ let g:rubycomplete_rails = 1 |
        \ let g:rubycomplete_buffer_loading = 1
  " line below not working for some reason
  " au Filetype ruby let g:rubycomplete_classes_in_global = 1
  au FileType css silent! setl omnifunc=csscomplete#CompleteCSS
  au FileType perl silent! compiler perl
  au FileType javascript setl ai et sta sw=2 sts=2 ts=2 cin isk+=$

  au BufReadPost *.snippets setl expandtab
  au BufReadPost *.snippets echo "'expandtab' option is set to" &expandtab
  au BufReadPost *.yml setl expandtab
  au BufReadPost *.yml echo "'expandtab' option is set to" &expandtab
  au BufReadPost *.make setl noexpandtab ts=8 sts=8 sw=8
  au BufReadPost *.make echo "'expandtab' option is set to" &expandtab
  "rss as xml
  au BufReadPost *.rss set ft=xml

  au GUIEnter * set title icon guioptions-=T
  au GUIEnter * if has("diff") && &diff | set columns=165 | endif
  "last cursor position in buffer
  au BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif

endif


if has("gui_running")
  " GUI is running or is about to start.
  " set gvim window size and set gvim pos
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

"autocmd User Rails
