" pathogen
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
" /pathogen

set nocompatible " not compatible with vi
syntax enable

if has("autocmd")
  filetype plugin on " all plugins are on by default
  filetype indent on
endif

" my computers: fonts, dictionary, etc...
if hostname() == "luke-Pavilion-dv4000-PX311UA-ABL" ||
      \ hostname() == "luke-K52F" ||
      \ hostname() == "ubuntu"
  " set guifont=Mensch\ Regular\ 13
  set guifont=Inconsolata\ Medium\ 12
  " set guifont=Monaco\ 12
  set swapsync=fsync
  set dictionary=usr/dict/words
elseif has("mac")
  set guifont=Monaco:h12
elseif has("win32")
  set guifont=Consolas:h11,Courier\ New:h10
elseif has("unix")
  set dictionary=usr/dict/words
  set swapsync=fsync
  if &guifont == ""
    set guifont=bitstream\ vera\ sans\ mono\ 10
  endif
endif

" *terminal colors*
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
  "colorscheme blackboard
  colorscheme xoria256
endif
" /terminal colors


set ruler
set list " show me listchars
let mapleader=" "
set report=0 " always report when changing lines
set modelines=5 " just to make sure
set pastetoggle=<F2>
set winaltkeys=no " allow use of <alt> for mappings by disabling window alt
set tags=tags;,tags
set textwidth=78 " overridden local to buffer for certain filetypes,
" see autocommands
set virtualedit=block " so useful, f11 virtualedit=all, f9 back to block
set nojoinspaces " oh historical reasons... for SHAME
set hls " highlight search
set foldcolumn=1 " must... see... folds
set foldmethod=marker " marker folding  styles
set statusline=
set statusline+=%2*[b%n]%*\        " flags and buf num.
set statusline+=%t                 " tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}]            " file form
set statusline+=%r                 " read only flag
set statusline+=%y                 " filetype
set statusline+=%m                 " modified flag
set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}
"if exists("g:loaded_syntastic_plugin")
"  set statusline+=%#warningmsg#
"  set statusline+=%{SyntasticStatuslineFlag()}
"  set statusline+=%*
"endif
set statusline+=%=        " left/right separator
set statusline+=%{exists('*CapsLockStatusline')?CapsLockStatusline():''}
set statusline+=c=%c,     " x=cursor column
set statusline+=l=%l/%L   " y=cursor line/total lines
set statusline+=\ (%P)    " percent through file
set showmode
set showcmd
set showmatch " matching brackets
set magic     "see pattern.txt
" Set to auto read when a file is changed from the outside
set autoread      " when a file is changed outside of vim and it's in the buffer
set lazyredraw    " don't redraw screen when running macros
set matchtime=3   " 3/10 of second paren matches
set wildmenu      " give me menu for tab completion
set wildmode=full " all I need (and default)
set wildcharm=<C-z> " let me tab a cmdline mapping
set wildignore+=*~
set suffixes+=.git,tags " lower priority for wildmenu
set noerrorbells  " no annoying little vi error noises!
set novisualbell
set scrolloff=3   " give me context of 3 lines when at top v bottom of buffer
set sidescrolloff=2
set timeoutlen=1250
set ttimeoutlen=50
set nobackup
set tabstop=2     " This is how many columns each literal tab indents
set softtabstop=2 " This is how many columns each tab key hit counts for in
" INSERT mode. If noexpandtab is set and tabstop=softtabstop, VIM always uses
" tabs.
set expandtab " replace tab characters with spaces
set sw=2 " shiftwidth
set shiftround " when indenting with >>, <<, do to nearest sw
set listchars=tab:>−,trail:−
set nowrap     " don't wrap text by default, tw=0
" set wrap " wrap my text!
if filereadable("/usr/bin/par")
  set formatprg=par " use par to format paragraphs. Default tw is 72
endif
set ai " auto indent
set si " smart indent
set cpoptions+=$ " compatibility with vi options, when using nmode c or C, show
"last changed character with $ instead of its value
set nu " line numbering
set incsearch   " show search while typing, incrementally
set ignorecase  " ignore the case of regexes
set smartcase   " but don't ignore them when I type a capital letter, to
"override i
if exists("+spelllang")
  set spelllang=en_us
endif

funct! ToggleWrapKeys()
  if &wrap == 1
    set nowrap
    nnoremap j j
    nnoremap k k
    vnoremap j j
    vnoremap k k
    echo "wrap keys off"
  elseif &wrap == 0
    set wrap
    nnoremap j gj
    nnoremap k gk
    vnoremap j gj
    vnoremap k gk
    nnoremap <Down> gj
    nnoremap <Up> gk
    vnoremap <Down> gj
    vnoremap <Up> gk
    echo "wrap keys on"
  endif
endfunction
command! -nargs=0 WK call ToggleWrapKeys()

funct! ToggleWrapMargin()
  if &wm == 0
    " turn wrap margin on
    set tw=0
    set wm=76
    echo "tw=0, wm=76"
  else
    set wm=0
    set tw=76
    echo "wm=0, tw=76"
  endif
endfunction
command! -nargs=0 WM call ToggleWrapMargin()

" *diff stuff*
set diffopt+=vertical,context:4

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" diff mappings
nmap <leader>dh :DiffOrig<CR>
" mnemonic of 'diff HEAD'
nmap <leader>du :diffupdate<CR>
nmap <leader>do :diffoff<CR>
" /diff stuff

" *alignment stuff (taken from vimcasts.org)*
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif
" /alignment stuff

" *edit file in same dir. as current buffer mappings*
map <leader>ee :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
" /edit mappings

" fast cd
map <leader>cd :cd <C-R>=expand("%:p:h") <CR>

" *my Rails abbreviations*
" mnemonic is rubyinit
:iabbr rinit initialize
:iabbr rto redirect_to
:iabbr bto button_to
:iabbr lto link_to
:iabbr jsit javascript_include_tag
:iabbr attrac attr_accessible
:iabbr attra attr_accessor
:iabbr attrr attr_reader
:iabbr attrw attr_writer
:iabbr slt stylesheet_link_tag
" /my Rails abbreviations

:iabbr myemail luke<DOT>gru<AT>gmail<DOT>com
:cabbr proj Project ~/.vim/projects/
:cabbr mks mks! ~/.vim/sessions/session
:cabbr Ls ls
:cabbr LS ls
:cabbr W w
:cabbr B# b#

if isdirectory(glob("~/.vim/views"))
  set viewdir=~/.vim/views " dir where mkview files are stored
else
  set viewdir=/tmp
endif

if isdirectory(glob("~/.backup"))
  set directory=~/.backup  " dir for swap files, // ensures full path in swap
  " filename separated by %
else
  set directory=/tmp
  echoerr "Backup directory ~/.backup doesn't exist!"
endif

if version >= 703
  set undofile
  if has("unix")
    set undodir=/tmp
  endif
endif

set mousehide  " Hide mouse until it's moved.
set mouse=a
set mousemodel=popup " Windows at least got this right
set history=40 " command-line history remembered. default = 20
set bs=2       " backspace over everything in insert mode

" let loaded_project = 1 "uncomment to turn off project plugin
set cmdheight=3 " cmd line height.
" the include path for current file, and the find command and its variants
set path+=.,,./**,~/.vim/pathinclude
set laststatus=2  " All windows have status lines
set shortmess=at  " To avoid the 'Hit ENTER to continue' promp
set helpheight=20 " minimum height for help wins, default=20, 0 is default split
"win height

" *plugin stuff*
let g:syntastic_auto_loc_list=1
let g:syntastic_disable_file_types = ['php']
let g:proj_flags='imst' " default is imst, g toggles proj file w/ F12
let g:proj_run1='silent !gvim %f'
let g:proj_run4='!git add %f'
let g:proj_run5='!git add .'
let g:bufExplorerSplitRight=1
if version >= 703
  nnoremap <F5> :GundoToggle<CR>
else
  nmap <F5> <Nop>
endif
" /plugin stuff

set noequalalways " don't auto-same size all windows when splitting or closing
"set winminwidth=5
set winfixwidth   " splits resize width of current win. only (good for vsplits)
set splitright    " verti. splits go right (good for vsplits)
"set winfixheight " splits resize height of current win. only
set splitbelow    " horiz. splits go below (good for splits)

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

" *n- and i-mode mappings*

" stop hightlighting for hlsearch, turn back on w/ next search
nnoremap <leader>n :noh<CR>

" colorschemes and font types
nnoremap <Leader>fm :set guifont=Monospace\ 10<CR>
nnoremap <Leader>fi :set guifont=Inconsolata\ Medium\ 12<CR>
" following color mappings contain 'k' instead of 'c'
" because of NerdCommenter
nnoremap <Leader>kv :colorscheme vividchalk<CR>
nnoremap <Leader>kb :colorscheme blackboard<CR>
nnoremap <Leader>kx :colorscheme xoria256<CR>
nnoremap <Leader>ki :colorscheme ir_black<CR>
nnoremap <Leader>cp :colorscheme peaksea<CR>
command! -bar Starwars :let &background =(&background=="light"?"dark":"light")

command! -bar -nargs=0 Bigger :let &guifont =
      \ substitute(&guifont,'\d\+$','\=submatch(0)+1','')
command! -bar -nargs=0 Smaller :let &guifont =
      \ substitute(&guifont,'\d\+$','\=submatch(0)-1','')
" /colorschemes and font types

" rails-vim mappings
nnoremap <leader>rc :Rcontroller<CR>
nnoremap <leader>rvc :RVcontroller<CR>
nnoremap <leader>rml :Rmigration<CR>
nnoremap <leader>rmi :Rinvert<CR>
nnoremap <leader>rep :Rextract<CR>
" /rails-vim mappings

" syntastic mappings
nnoremap <leader>se :SyntasticEnable<CR>
nnoremap <leader>sd :SyntasticDisable<CR>
cnoremap <leader>se SyntasticEnable
cnoremap <leader>sd SyntasticDisable
" /syntastic mappings

" clipboard yank
nnoremap <C-y> "+y
nnoremap <C-\> "+p
" clipboard
inoremap <C-\> <ESC>"+p$
" default yanking remaps
nnoremap Y y$
nnoremap gy :call Preserve("normal 0y$")<CR>

" Set the indent width to 2, 4, or 8
nmap <Leader>2 :setlocal tabstop=2 shiftwidth=2<CR>
nmap <Leader>4 :setlocal tabstop=4 shiftwidth=4<CR>
nmap <Leader>8 :setlocal tabstop=8 shiftwidth=8<CR>

" --TABS MAPPINGS--
"  CTRL-L, CTRL, R or tab previous, next
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
"  ALT-L, ALT-R for moving tabs left/right
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>
" --/TABS MAPPINGS--

" fold mappings
nmap <silent> <CR> za
" /fold mappings

noremap <silent> <F3> <ESC>:e $MYVIMRC<CR>
noremap <silent> <F4> <ESC>:so $MYVIMRC<CR>
" making [count] newlines
nnoremap <leader>; o<ESC>

nnoremap <F9> :set virtualedit=block<CR>
nnoremap <F10> <nop>
nnoremap <F11> :set virtualedit=all<CR>
nnoremap <leader>l :set list!<CR>

" indenting, useful stuff..
nnoremap < <<
nnoremap > >>
vnoremap < <gv
vnoremap > >gv

" hightlight text I just pasted, compliments gv well
nnoremap gV `[v`]

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv
" don't move on *
nnoremap * *<C-o>

" ESCaping
inoremap <A-m> <ESC>
inoremap <F1> <ESC>
" CTRL-l is useless for me, so I'll map it to go to the end of the line
" mnemonic is *last*
inoremap <C-l> <ESC>g_a
" there is no <C-b> in i_mode, so I'll map it to go the start of the line
" mnemonic is *beginning*
inoremap <C-b> <ESC>^i

" *omnicompletion*
" default <c-o> I find useless, so map it to omni
inoremap <silent> <C-o> <C-x><C-o>

" finding filenames

" *jumps*
" last jump
nnoremap <C-b> <C-o>

" Locate and return character above current cursor position regardless of
" blank lines
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

nmap <leader>= :call Preserve("normal gg=G")<CR>
" /n- and i-mode mappings

" *c-mode mappings*
cnoremap <C-j> <S-left>
cnoremap <C-k> <S-right>
cnoremap <C-b> <left>
cnoremap <C-f> <right>
cnoremap <C-a> <C-b>
cnoremap <C-s> source ~/.vim/sessions/session
" works well with tab for tab completion previous

" to make tab understand I want to view the contents of the dir, not do <C-n>
cnoremap <leader>t i<BS>

" /c-mode mappings

" *v-mode mappings*
vnoremap <C-y> "+y
vnoremap <Space> I<Space><Esc>gv
" /v-mode mappings

" *startup info and sessions*
set sessionoptions-=options
set viminfo+=<100

" *syntax groups*
" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" /syntax groups

" *working with wrapped text*
" softwrap
command! -nargs=0 Swrap setl wrap linebreak nolist showbreak=…
" ellipsis = unicode 2026
" (hard wrapping options in autocmds below for filetypes)
" //working with wrapped text

" *encoding (set)*
" http://vim.wikia.com/wiki/Working_with_Unicode
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif
" /encoding (set)


" view markup'd markdown in browser (linux)
nnoremap <leader>pm :w!<CR>:!markdown % > %.html && sensible-browser
      \ file://%:p.html<CR><CR>

" define :HighlightLongLines command to highlight the offending parts of
" lines that are longer than the specified length (defaulting to 80)
command! -nargs=? HighlightLongLines call s:HighlightLongLines('<args>')

function! s:HighlightLongLines(width)
  let targetWidth = a:width != '' ? a:width : 79
  if targetWidth > 0
    exec 'match Todo /\%>' . (targetWidth) . 'v/'
  else
    echomsg "Usage: HighlightLongLines [natural number]"
  endif
endfunction

" add modeline to file with current settings
" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d :",
        \ &tabstop, &shiftwidth, &textwidth)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction

function! RubyShebang()
  let l:shebang = "#!/usr/bin/env ruby"
  call append(line("0"), l:shebang)
  exe "normal dd"
  call She_Bang()
endfunction

command! -nargs=0 Rsheb call RubyShebang()
command! -nargs=0 Mode call AppendModeline()
command! -nargs=* Xe !chmod +x <args>
command! -nargs=0 Xe !chmod +x %

if has("unix") || has("mac")
  " from https://github.com/tpope/tpope/blob/master/.vimrc
  " a source of wonder...
  function! OpenURL(url)
    if has("win32")
      exe "!start cmd /cstart /b ".a:url.""
    elseif $DISPLAY !~ '^\w'
      exe "silent !sensible-browser \"".a:url."\""
    else
      exe "silent !sensible-browser -T \"".a:url."\""
    endif
    redraw!
  endfunction
  command! -nargs=1 OpenURL :call OpenURL(<q-args>)
  " open URL under cursor in browser
  nnoremap gB :OpenURL <cfile><CR>
  nnoremap gG :OpenURL http://www.google.com/search?q=<cword><CR>
  nnoremap gW :OpenURL http://en.wikipedia.org/wiki/Special:Search?search=<cword><CR>
endif


function! FoldView()
  if &cursorline
    windo set foldcolumn=1
    if exists("+cursorcolumn")
      set nocursorcolumn nocursorline
    endif
  else
    windo set foldcolumn=2
    if exists("+cursorcolumn")
      set cursorline
    endif
  endif
endfunction
command! -bar FoldView :call FoldView()

" useful MAKE function taken from https://github.com/tpope/tpope/blob/master/.vimrc
function! Run()
  let old_makeprg = &makeprg
  let cmd = matchstr(getline(1),'^#!\zs[^ ]*')
  if exists("b:run_command")
    exe b:run_command
  elseif cmd != '' && executable(cmd)
    wa
    let &makeprg = matchstr(getline(1),'^#!\zs.*').' %'
    make
  elseif &ft == "mail" || &ft == "text" || &ft == "help" || &ft == "gitcommit"
    setlocal spell!
  elseif exists("b:rails_root") && exists(":Rake")
    wa
    Rake
  elseif &ft == "ruby"
    wa
    if executable(expand("%:p")) || getline(1) =~ '^#!'
      compiler ruby
      let &makeprg = "ruby"
      make %
    elseif expand("%:t") =~ '_test\.rb$'
      compiler rubyunit
      let &makeprg = "ruby"
      make %
    elseif expand("%:t") =~ '_spec\.rb$'
      compiler ruby
      let &makeprg = "spec"
      make %
    else
      !irb -r"%:p"
    endif
  elseif &ft == "html" || &ft == "xhtml" || &ft == "php" || &ft == "aspvbs" || &ft == "aspperl"
    wa
    if !exists("b:url")
      call OpenURL(expand("%:p"))
    else
      call OpenURL(b:url)
    endif
  elseif &ft == "vim"
    wa
    unlet! g:loaded_{expand("%:t:r")}
    return 'source %'
  elseif &ft == "sql"
    1,$DBExecRangeSQL
  elseif expand("%:e") == "tex"
    wa
    exe "normal :!rubber -f %:r && xdvi %:r >/dev/null 2>/dev/null &\<CR>"
  else
    wa
    if &makeprg =~ "%"
      make
    else
      make %
    endif
  endif
  let &makeprg = old_makeprg
  return ""
endfunction

command! -bar Run :execute Run()

" start autocmd section
if has("autocmd")
  autocmd!

  " mozrepl stuff
  function! Refresh_firefox()
    if &modified && has("gui_running")
      write
      silent !echo  'vimYo = content.window.pageYOffset;
            \ vimXo = content.window.pageXOffset;
            \ BrowserReload();
            \ content.window.scrollTo(vimXo,vimYo);
            \ repl.quit();'  |
            \ nc localhost 4242
    endif
  endfunction

  command! -nargs=1 Repl silent !echo
  " \ repl.home();
        \ content.location.href = '<args>';
        \ repl.enter(content);
        \ repl.quit();" |
        \ nc localhost 4242

  nmap <leader>mh :Repl http://
  "mnemonic is Http
  nmap <leader>ml :Repl file://%:p<CR>
  "mnemonic is Local
  nmap <silent> <leader>ms :Repl http://localhost/

  autocmd BufWriteCmd *.html*,*.css* :call Refresh_firefox()
  " /mozrepl stuff

  " trailing whitespace stuff, from
  " http://got-ravings.blogspot.com/search/label/vim
  set statusline+=%{StatuslineTrailingSpaceWarning()}

  " recalculate the trailing whitespace warning when idle, and after saving
  autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

  " return '[\s]' if trailing white space is detected
  " return '' otherwise
  function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
      if search('\s\+$', 'nw') != 0
        let b:statusline_trailing_space_warning = '[\s]'
      else
        let b:statusline_trailing_space_warning = ''
      endif
    endif
    return b:statusline_trailing_space_warning
  endfunction

  " vimrc source on write
  autocmd bufwritepost .vimrc source $MYVIMRC|redraw
  autocmd bufread * syntax enable
  " remove trailing whitespace
  augroup whitespace
    au!
    autocmd BufWritePre * :%s/\s\+$//e
  augroup END
  " text and mail
  au FileType mail,gitcommit setl tw=68 list wrap formatoptions formatoptions+=an
  "-q option for par handles nested quotations in plaintext mail
  au FileType mail setl formatprg=par\ -q
  " au FileType qf silent unmap <buffer> <CR>
  au FileType mail,gitcommit echo "'textwidth' set to" &textwidth
  au BufRead *.txt setl tw=78 wrap formatoptions formatoptions+=an formatprg=par\
        \ -w78
  " don't know if I like that for php, hopefully won't use php much anyway
  au FileType cpp,c,cs,java setl ai et sta sw=4 sts=4 cin
  au FileType php,vb setl ai et sta sw=4 sts=4
  au FileType php nnoremap <leader>bi :%s/^\(print "<br \/>"\)/    \1/g<CR>
  au BufNewFile,BufRead /var/www/*.module  set ft=php
  au FileType xml,xsd,xslt setl ai et sw=2 sts=2 ts=2
  au FileType python setl ts=4 sw=4 expandtab
  au FileType ruby setl keywordprg=ri omnifunc=rubycomplete#Complete |
        \ let g:rubycomplete_rails = 1 |
        \ let g:rubycomplete_buffer_loading = 1
  " line below not working for some reason
  " au Filetype ruby let g:rubycomplete_classes_in_global = 1
  au FileType perl silent! compiler perl
  au FileType javascript setl ai et sta sw=4 sts=4
  au FileType vim setl keywordprg=:help
  au FileType binary augroup! whitespace

  au BufReadPost *.snippets setl expandtab
  au BufReadPost *.snippets echo "'expandtab' option is set to" &expandtab
  au BufReadPost *.yml setl expandtab
  au BufReadPost *.yml echo "'expandtab' option is set to" &expandtab
  au BufReadPost *.make setl noexpandtab ts=8 sts=8 sw=8
  au BufReadPost *.make echo "'expandtab' option is set to" &expandtab
  " rss as xml
  au BufReadPost *.rss set ft=xml

  au GUIEnter * set title icon guioptions-=T
  au GUIEnter * if has("diff") && &diff | set columns=165 | endif
  " last cursor position in buffer
  au BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif

  " long line warnings
  set statusline+=%{StatuslineLongLineWarning()}

  " recalculate the long line warning when idle and after saving
  autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

  " return a warning for 'long lines' where 'long' is either &textwidth or 80
  " (if no &textwidth is set)

  " return '' if no long lines
  " return '[#x,my,$z] if long lines are found, were x is the number of long
  " lines, y is the median length of the long lines and z is the length of the
  " longest line
  function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")
      let long_line_lens = s:LongLines()

      if len(long_line_lens) > 0
        let b:statusline_long_line_warning = "[" .
              \ '#' . len(long_line_lens) . "," .
              \ 'm' . s:Median(long_line_lens) . "," .
              \ '$' . max(long_line_lens) . "]"
      else
        let b:statusline_long_line_warning = ""
      endif
    endif
    return b:statusline_long_line_warning
  endfunction

  " return a list containing the lengths of the long lines in this buffer
  function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)

    let long_line_lens = []

    let i = 1
    while i <= line("$")
      let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
      if len > threshold
        call add(long_line_lens, len)
      endif
      let i += 1
    endwhile

    return long_line_lens
  endfunction

  " find the median of the given array of numbers
  function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
      let i = (l-1) / 2
      return nums[i]
    else
      return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
  endfunction

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

" /of if has autocmd
endif


" to override certain settings on other computers
" keep at end of file
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
