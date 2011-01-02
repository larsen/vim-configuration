""" General configuration

set hidden
set nobackup
set noswapfile
set modeline 

set showmatch
set matchtime=2
set so=4
set exrc

set incsearch
set hlsearch
set ruler

set smartindent
set shiftwidth=4 " for autoindent
set copyindent
set backspace=indent,eol,start
set wildmenu
set wildignore=*.swp,*.bak
set smartcase

set diffopt=filler,iwhite

set expandtab
set ts=4

" MacVim settings
if has("gui_running")
   set guifont="Droid Sans Mono:h11.00"
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
   colorscheme mayansmoke
endif


" set number 

" via osfameron
" via hlen on #vim !  woot! (slightly modified in the way that made sense to
" me :-)
let &statusline='%-2.2n %t %m '                                                  .
  \ '[%-2.(%{strlen(&filetype)?&filetype:strlen(&syntax)?&syntax:"unknown"}] %)' .
  \ '%{synIDattr(synID(line("."), col("."), 1), "name")}'                        .
  \ '%= %{&encoding}  %3.3b 0x%-4B '                                             .
  \ '%-10.(%l,%c%V%) %<%P'
set laststatus=2

source ~/.vim/plugin/minibufexpl.vim

""" Mappings and abbreviations

:map  <C-tab> :tabnext<cr>
:imap <C-tab> <ESC>:tabnext<cr>i
:nmap <C-t>   :tabnew<cr>

set foldmethod=manual
map + v%zf

" via http://pdx.pm.org/kwiki/index.cgi?VimRCFile (JoshHeumann)
" 'keep me away from that damn command history'
map q: :q

map <F5> :! perl -c %<C-M>
map <F6> :! perl %<C-M>
map <F7> :! perl -d %<C-M>

map <F8> :! prove %<C-M>

let mapleader = ","

" http://www.oreillynet.com/onlamp/blog/2006/08/make_your_vimrc_trivial_to_upd_1.html 
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


" Abbreviations

abbrev skall plan 'skip_all' => '';

""" Syntax highlight stuff

syntax on
hi Folded term=reverse cterm=bold ctermbg=2
hi LineNr term=bold ctermfg=6


""" Auto-actions

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


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif


""" Perl-related stuff

au FileType pl,pm,t set filetype=perl

" let perl_fold = 1
set ts=4

if has("autocmd")

    augroup perl
        autocmd BufNewFile,BufRead *.p?   setf perl
        autocmd BufNewFile,BufRead *.t    setf perl
    augroup END

endif


""" Useful tips

" match errorMsg /\%>73v.\+/
