" ------------------------------------------------------------------------ 
" important
" ------------------------------------------------------------------------ 
set nocompatible


" ------------------------------------------------------------------------ 
" moving around, searching and patterns
" ------------------------------------------------------------------------ 
set incsearch
set smartcase


" ------------------------------------------------------------------------ 
" tags
" ------------------------------------------------------------------------ 


" ------------------------------------------------------------------------ 
" displaying text
" ------------------------------------------------------------------------ 
set list listchars=tab:→\ ,trail:·
colorscheme mac_classic
set t_Co=256
set so=4


" ------------------------------------------------------------------------ 
" syntax, highlighting and spelling
" ------------------------------------------------------------------------ 
set hlsearch
syntax on
hi Folded term=reverse cterm=bold ctermbg=2
hi LineNr term=bold ctermfg=6


" ------------------------------------------------------------------------ 
" multiple windows
" ------------------------------------------------------------------------ 
set hidden

call jeetlib#_UI_StatusLine_DefineSpecialHighlights()
if has("autocmd")
    au ColorScheme * call jeetlib#_UI_StatusLine_DefineSpecialHighlights()
endif
set statusline=%!jeetlib#_UI_StatusLine_Compose()
set laststatus=2

" via osfameron
" via hlen on #vim !  woot! (slightly modified in the way that made sense to
" me :-)
" let &statusline='%-2.2n %t %m '                                                  .
"   \ '[%-2.(%{strlen(&filetype)?&filetype:strlen(&syntax)?&syntax:"unknown"}] %)' .
"   \ '%{synIDattr(synID(line("."), col("."), 1), "name")}'                        .
"   \ '%= %{&encoding}  %3.3b 0x%-4B '                                             .
"   \ '%-10.(%l,%c%V%) %<%P'


" ------------------------------------------------------------------------ 
" multiple tab pages
" ------------------------------------------------------------------------ 


" ------------------------------------------------------------------------ 
" terminal
" ------------------------------------------------------------------------ 


" ------------------------------------------------------------------------ 
" using the mouse
" ------------------------------------------------------------------------ 


" ------------------------------------------------------------------------ 
" GUI
" ------------------------------------------------------------------------ 
" MacVim settings
if has("gui_running")
   set guifont="Droid Sans Mono:h11.00"
   set fullscreen
   set guioptions-=T
   " set guioptions=''

   set guioptions-=t    " Disable Menu tear-offs
   set guioptions-=T    " Disable the tool-bar
   set guioptions-=m    " Disable the menu
   set guioptions-=l
   set guioptions-=L
   set guioptions-=r    " Disable the scrollbar
   set guioptions-=R

   set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
   set lines=59 columns=191
   set number
   set numberwidth=5
   set transparency=5
   set fuoptions=maxvert,maxhorz
   syntax on
   set background=dark
   colorscheme solarized
endif


" ------------------------------------------------------------------------ 
" printing
" ------------------------------------------------------------------------ 


" ------------------------------------------------------------------------ 
" messages and info
" ------------------------------------------------------------------------ 
set ruler


" ------------------------------------------------------------------------ 
" selecting text
" ------------------------------------------------------------------------ 


" ------------------------------------------------------------------------ 
" editing text
" ------------------------------------------------------------------------ 
set showmatch
set matchtime=2
set backspace=indent,eol,start


" ------------------------------------------------------------------------ 
" tabs and indenting
" ------------------------------------------------------------------------ 
set smartindent
set shiftwidth=4 " for autoindent
set copyindent
set expandtab
set ts=4


" ------------------------------------------------------------------------ 
" folding
" ------------------------------------------------------------------------ 
set foldmethod=manual
" let perl_fold = 1


" ------------------------------------------------------------------------ 
" diff mode
" ------------------------------------------------------------------------ 
set diffopt=filler,iwhite


" ------------------------------------------------------------------------ 
" mapping
" ------------------------------------------------------------------------ 
let mapleader = ","

:map  <C-tab> :tabnext<cr>
:imap <C-tab> <ESC>:tabnext<cr>i
:nmap <C-t>   :tabnew<cr>

map + v%zf

" via http://pdx.pm.org/kwiki/index.cgi?VimRCFile (JoshHeumann)
" 'keep me away from that damn command history'
map q: :q

map <F5> :! perl -c %<C-M>
map <F6> :! perl %<C-M>
map <F7> :! perl -d %<C-M>

map <F8> :! prove %<C-M>

",v brings up my .vimrc
",V reloads it -- making all changes active (have to save first)
map <Leader>v :sp $VIMRC<CR><C-W>_
map <silent> <Leader>V :source $VIMRC<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" http://vim.wikia.com/wiki/Easily_add_folds_in_code
nmap <silent> <leader><leader> [{V%zf

" line numbers
map <Leader>n :set number<CR>
map <Leader>N :set nonumber<CR>

" paste
map <Leader>p :set paste<CR>
map <Leader>P :set nopaste<CR>

" Tlist
" map <Leader>t :TlistToggle<CR>

" NERDTree
map <Leader>T :NERDTree<CR>

" search
nmap n nzz
nmap N Nzz
nmap * *zz

silent! nmap <unique> <silent> <Leader>t :CommandT<CR>

" JS lint
nmap <F4> :w<CR>:make<CR>:cw<CR>

function! CleverTab()
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
        return "\<Tab>"
    else
        return "\<C-N>"
endfunction

inoremap <Tab> <C-R>=CleverTab()<CR>

function! UrlTransform()
    exec "r !~/bin/uritransform.pl \"" . getline(".") . "\""   
endfunction

map <Leader>u :call UrlTransform()<CR>

function! HandleURI()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
  echo s:uri
  if s:uri != ""
      exec "!open \"" . s:uri . "\""
  else
      echo "No URI found in line."
  endif
endfunction
map <Leader>b :call HandleURI()<CR>


" ------------------------------------------------------------------------ 
" reading and writing files
" ------------------------------------------------------------------------ 
set nobackup
set modeline 


" ------------------------------------------------------------------------ 
" the swap file
" ------------------------------------------------------------------------ 
set noswapfile


" ------------------------------------------------------------------------ 
" command line editing
" ------------------------------------------------------------------------ 
set wildmenu
set wildignore=*.swp,*.bak


" ------------------------------------------------------------------------ 
" executing external commands
" ------------------------------------------------------------------------ 


" ------------------------------------------------------------------------ 
" running make and jumping to errors
" ------------------------------------------------------------------------ 


" ------------------------------------------------------------------------ 
" language specific
" ------------------------------------------------------------------------ 


" ------------------------------------------------------------------------ 
" multi-byte characters
" ------------------------------------------------------------------------ 
set encoding=utf-8 " Necessary to show Unicode glyphs


" ------------------------------------------------------------------------ 
" various
" ------------------------------------------------------------------------ 
set exrc
abbrev skall plan 'skip_all' => '';
" abbrev euro €


" ------------------------------------------------------------------------ 
" moving around, searching and patterns
" ------------------------------------------------------------------------ 


" ------------------------------------------------------------------------ 
" autoactions
" ------------------------------------------------------------------------ 

" au BufWinLeave * mkview
" au BufWinEnter * silent loadview

" http://vimdoc.sourceforge.net/htmldoc/vimfaq.html
" 5.5. How do I configure Vim to open a file at the last edited location?
" Vim stores the cursor position of the last edited location for each buffer
" in the '"' register. You can use the following autocmd in your .vimrc or
" .gvimrc file to open a file at the last edited location:
au BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

if has("autocmd")

    augroup perl
        autocmd BufNewFile,BufRead *.p?   setf perl
        autocmd BufNewFile,BufRead *.t    setf perl
    augroup END

endif

au FileType pl,pm,t set filetype=perl

if exists("did\_load\_filetypes")
 finish
endif

augroup markdown
    au! BufRead,BufNewFile *.mkd   setfiletype mkd
augroup END

augroup markdown
    au! BufRead,BufNewFile *.tt   set ft=html
augroup END

augroup mkd
    autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
augroup END

" From http://www.reddit.com/r/vim/comments/m2k76/vim_porn_that_is_show_me_your_vim/
" Always show line numbers, but only in current window.
set number
:au WinEnter * :setlocal number
:au WinLeave * :setlocal nonumber

" Automatically resize vertical splits.
:au WinEnter * :set winfixheight
:au WinEnter * :wincmd =

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

source organizer.rc

let g:Powerline_theme="skwp"

let g:Powerline_colorscheme="skwp"

let g:Powerline_symbols = 'fancy'

call pathogen#infect()
