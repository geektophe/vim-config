"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pathogen
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"filetype off
"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()
execute pathogen#infect()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("autocmd")
  filetype plugin on
  filetype plugin indent on
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Modeline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set modeline


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
setlocal tabstop=4
setlocal shiftwidth=4


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clipboard Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disables selection to x11 clipboard
set clipboard-=autoselect


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set guioptions-=m
set guioptions-=r
set guioptions-=l
set guioptions-=b
set guioptions-=T
set guioptions-=R
set guioptions-=L

" Syntax coloring
syntax on

" Disables bell
set visualbell

if has("gui_running")
	colorschem wombat

	augroup BgHighlight
		autocmd!
		autocmd WinEnter * set cursorline
		autocmd WinLeave * set nocursorline
	augroup END
else
	if has("termguicolors")
		set t_Co=256
		colorschem wombat256
		set cursorline
		"set lazyredraw
	endif
endif

" Displays ruler
set ruler

" Highlight end of line whitespace.
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" Colorise les nbsp
highlight NbSp ctermbg=red guibg=red
match NbSp /\%xa0/

" Displayes 80 columns margin
if exists('+colorcolumn')
	set colorcolumn=80
else
	" Highlight rows longer than 79 columns
highlight rightMargin ctermbg=darkblue guibg=darkblue
	match rightMargin /\%>79v.\+/
endif

" Fonts settings
if has("win32")
	" fonts
	set guifont=Courier_New:h10
else
	"set guifont=Monospace\ 10
	set guifont=Deja\ Vu\ Sans\ Mono\ 9
endif

"set wildmenu
set wildchar=<Tab> wildmenu wildmode=longest,full
set nu

" Always show some lines above or below the cursor.
set scrolloff=5


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Backup settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backup

if has("win32")
	" Store all backup and temporary files in one place
	set backupdir=~/vimfiles/backup,~/,.
	set directory=~/vimfiles/tmp,~/,.
else
	" Store all backup and temporary files in one place
	set backupdir=~/.vim/backup,~/,.
	set directory=~/.vim/tmp,~/,.
endif

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

"" Restores last cursor position
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Netrw settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Netrw setting
let g:netrw_silent = 1

if has("win32")
	let g:netrw_cygwin = 0
	" Putty has to be in PATH environment variable
	let g:netrw_scp_cmd = "pscp.exe"
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Search while typing
set incsearch

" Show matching parens
set showmatch


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mail filetytpe detection
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead neomutt-* setf mail


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Removes trailing white spaces on save
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"auto remove whitespace at the end of line before :w,
"it also save email signiture spliter "-- "
"function! s:RemoveWhiteSpace()
"    let save_cursor = getpos(".")
"    %s/\s\+$//e
"    if &filetype == 'mail'
"        %s/^--$/-- /e
"    endif
"    call setpos(".", save_cursor)
"endfunction
function! s:RemoveWhiteSpace()
    if &filetype == 'mail'
        return
    endif
    let cursor_pos = getpos(".")
    %s/\s\+$//e
    call setpos(".", cursor_pos)
endfunction
autocmd BufWritePre * :call <SID>RemoveWhiteSpace()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN: Pymode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:pymode_syntax_print_as_function = 1
let g:pymode_doc = 0
let g:pymode_folding = 0
let g:pymode_rope_guess_project = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_lint_cwindow = 0
let g:pymode_doc = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN: Supertab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType="<C-X><C-O>"

if has("gui_running")
	let g:SuperTabMappingForward = '<c-space>'
	let g:SuperTabMappingBackward = '<s-c-space>'
else
	let g:SuperTabMappingForward = '<nul>'
	let g:SuperTabMappingBackward = '<s-nul>'
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN: TaskList
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:tlWindowPosition = 1
"let g:tlTokenList = ['TODO', 'FIXME', 'XXX', 'BUG']


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN: TagList
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Taglist variables
" Display function name in status bar:
"let g:ctags_statusline=1
" Automatically start script
"let generate_tags=1
" Displays taglist results in a vertical window:
"let Tlist_Use_Horiz_Window=0
" Shorter commands to toggle Taglist display
"nnoremap TT :TlistToggle<CR>
"map <F4> :TlistToggle<CR>
" Various Taglist diplay config:
"let Tlist_Use_Right_Window = 1
"let Tlist_Compact_Format = 1
"let Tlist_Exit_OnlyWindow = 1
"let Tlist_GainFocus_On_ToggleOpen = 1
"let Tlist_File_Fold_Auto_Close = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN: Project
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:proj_window_width = 40
let g:proj_flags = "imsgt"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN: Pylint
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Prevents Pylint to becalled each time a buffer is saved
let g:pylint_onwrite = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN: Buftabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if ! &diff
	set laststatus=2
	"set statusline=%{buftabs#statusline()}%<%=%-16(%h%m%r%)%-12.(%l,%c%)\ %P

	let g:buftabs_in_statusline   = 0
	let g:buftabs_only_basename   = 1
	let g:buftabs_marker_start    = '['
	let g:buftabs_marker_end      = ']'
	let g:buftabs_separator       = ' '
	let g:buftabs_marker_modified = ''
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN: Lightlime
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive' ], [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?" ".fugitive#head():""}',
      \   'filename': '[%n] %f'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype != "help" && &readonly)',
      \   'modified': '(&filetype != "help" && (&modified || !&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && "" != fugitive#head())'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN: ACP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:acp_enableAtStartup = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN: CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ctrlp_map = '<c-p>'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN: Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = "powerlineish"
"let g:airline_theme_patch_func = 'AirlineThemePatch'

function! AirlineThemePatch(palette)
  if g:airline_theme == 'powerlineish'
    for colors in values(a:palette.normal)
      let colors[3] = 245
    endfor
  endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN: VimWiki
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:vimwiki_list = [
  \ {'path': '~/Documents/vimwiki/work', 'list_margin': 2},
  \ {'path': '~/Documents/vimwiki/perso', 'list_margin': 2},
  \ {'path': '~/Documents/vimwiki/copro', 'list_margin': 2}
\]
let g:vimwiki_hl_headers = 1
let g:vimwiki_hl_cb_checked = 2


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" <Leader> is "\"... but on azerty keyboard it better to use "," wich is
" more accessible
let mapleader = ","
let maplocalleader = ","

" Backspace key mapping
set backspace=indent,eol,start

" Windows move mappings
set splitbelow
set splitright

" Alt to buffer mapping
nnoremap <leader>" :buffer 1<cr>
nnoremap <leader>« :buffer 2<cr>
nnoremap <leader>» :buffer 3<cr>
nnoremap <leader>( :buffer 4<cr>
nnoremap <leader>) :buffer 5<cr>
nnoremap <leader>@ :buffer 6<cr>
nnoremap <leader>+ :buffer 7<cr>
nnoremap <leader>- :buffer 8<cr>
nnoremap <leader>/ :buffer 9<cr>
nnoremap <leader>* :buffer 10<cr>
nnoremap <leader>= :buffer 11<cr>
nnoremap <leader>% :buffer 12<cr>
nnoremap <leader><PageUp> :bfirst<cr>
nnoremap <leader><PageDown> :blast<cr>

map <silent> <C-Down> <C-w>j
map <silent> <C-Up> <C-w>k
map <silent> <C-Right> <C-w>l
map <silent> <C-Left> <C-w>h
map <silent> <C-q> <C-w>q
map <silent> <C-m> <C-w>_

"map <C-S-Down> <C-w>J
"map <C-S-Up> <C-w>K
"map <C-S-Right> <C-w>L
"map <C-S-Left> <C-w>H

map <silent> <S-Right> :bnext<cr>
map <silent> <S-Left>  :bprev<cr>
map <silent> gt :bnext<cr>
map <silent> gT :bprev<cr>
map <silent> <C-k> :bclose<cr><c-w>l

set winaltkeys=no
map <silent> <M-Up> :3wincmd +<cr>
map <silent> <M-Down> :3wincmd -<cr>
map <silent> <M-Right> :3wincmd ><cr>
map <silent> <M-Left> :3wincmd <<cr>
map <silent> <M-r> :wincmd x<cr>

" Folding based on indent
"set foldmethod=indent
nnoremap <space> za
vnoremap <space> zf

" Easy indentation in visual mode
" This keeps the visual selection active after indenting.
" Usually the visual selection is lost after you indent it.
vmap > >gv
vmap < <gv

" Searches and highlight word under cursor
nnoremap <silent> <Leader>s :set invhls<cr>:exec "let @/='\\<".expand("<cword>")."\\>'"<cr>

" Enable or disable indentation guides
nnoremap <silent> <Leader>i :IndentGuidesToggle<CR>

" Enable or disable taglist window
nnoremap <silent> <F9> :TagbarToggle<CR>
nnoremap <silent> tt :TagbarToggle<CR>

" Toggles gundo
nnoremap <silent> <Leader>g :GundoToggle<CR>

" Go to next mark
nnoremap <silent> <Leader>n ]'
nnoremap <silent> <Leader>N ['

" Fuzzy buffer search
nnoremap <silent> <leader>d :CtrlPBuffer<CR>

" Enable or disable show marks
let g:showmarks_toggled = 0

function! ToggleShowMarks()
	if g:showmarks_toggled == 0
		silent DoShowMarks!
		let g:showmarks_toggled = 1
	else
		silent NoShowMarks!
		let g:showmarks_toggled = 0
	endif
endfunction
command! ToggleShowMarks call ToggleShowMarks()
nnoremap <silent> <Leader>m :ToggleShowMarks<CR>

" Mouse and copy/paste control
if has("gui_running")
	if has("win32")
		noremap <Silent> <S-Insert> "+y
		noremap <Silent> <C-Insert> "+gP
	else
		map <S-Insert> <MiddleMouse>
		map! <S-Insert> <MiddleMouse>
	endif
	set mouse=
endif

" Enable or disable line number
let g:nu_toggled = 0

function! ToggleNu()
	if g:nu_toggled == 0
		silent set number
		let g:nu_toggled = 1
	else
		silent set nonumber
		let g:nu_toggled = 0
	endif
endfunction
command! ToggleNu call ToggleNu()
"nnoremap <Silent> <Leader>n :ToggleNu<CR>

" Saves current vim session
nnoremap <Silent> <Leader>b :mksession! ~/Session.vim<CR>

" Enable or disable ACP autocompletion module
let g:acp_toggled = 0

function! AcpToggle()
	if g:acp_toggled == 0
		silent AcpEnable
		let g:acp_toggled = 1
	else
		silent AcpDisable
		let g:acp_toggled = 0
	endif
endfunction
command! AcpToggle call AcpToggle()

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
	let l:currentBufNum = bufnr("%")
	let l:alternateBufNum = bufnr("#")

	if buflisted(l:alternateBufNum)
		buffer #
	else
		bnext
	endif

	if bufnr("%") == l:currentBufNum
		new
	endif

	if buflisted(l:currentBufNum)
		execute("bdelete! ".l:currentBufNum)
	endif
endfunction


" Swap windows buffers
let g:markedWinNum = -1

function! WindowSwap()
	if g:markedWinNum < 0
		call MarkWindowSwap()
		echo "Window marked for swap"
	else
		call DoWindowSwap()
		let g:markedWinNum = -1
	endif
endfunction

function! MarkWindowSwap()
	let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
	let curNum = winnr() "Mark destination
	let curBuf = bufnr( "%" )
	exe g:markedWinNum . "wincmd w"
	let markedBuf = bufnr( "%" ) "Switch to source and shuffle dest->source
	"Hide and open so that we aren't prompted and keep history
	exe 'hide buf' curBuf
	"Switch to dest and shuffle source->dest"
	exe curNum . "wincmd w"
	"Hide and open so that we aren't prompted and keep history"
	exe 'hide buf' markedBuf
endfunction

nmap <silent> <S-Up> :call MarkWindowSwap()<CR>
nmap <silent> <S-Down> :call DoWindowSwap()<CR>
"nmap <silent> <S-Up> :call WindowSwap()<CR>

" Togles lines wrap
noremap <silent> <Leader>w :call ToggleWrap()<CR>
function ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
    set virtualedit=all
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
  else
    echo "Wrap ON"
    setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
  endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Loads bepo key mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"source ~/.vim/bepo.vim
"set langmap=ba,éz,pe,or,èt,çy,vu,di,lo,fp,j^,z$,aq,us,id,ef,\,g,ch,tj,sk,nl,rm,mù,^*,ê<,àw,hx,yc,.v,kb,'n,q\,,g;;,x:,w!,BA,ÉZ,PE,OR,ÈT,ÇY,VU,DI,LO,FP,J¨,Z£,AQ,US,ID,EF,?G,CH,TJ,SK,NL,RM,M%,!*,Ê>,ÀW,HX,YC,:V,KB,\\;N,QG,G.,X/,W§,@œ,_&,"é,«",»',((,)-,+è,-_,*ç,/à,=),%=,$Œ,^°,µ+,#“,{´,}~,<#,>{,[[,]|,±`,¬\,×^,÷@,¯],%}

if filereadable($HOME . "/.vimrc.local")
	source $HOME/.vimrc.local
endif
