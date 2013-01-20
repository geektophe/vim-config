" $HOME/.vimrc/ftplugin/php.vim
" activate the filetype plugin with the following command in  vimrc file :
" if has("autocmd")
"   filetype plugin on
" endif

" spaces per tab
setlocal tabstop=4

" indentation spaces
setlocal shiftwidth=4

" expands tabs to spaces
"setlocal expandtab

" for backsapce to suppress 4 spaces
setlocal softtabstop=4

" Automatic folding
set foldmethod=syntax

" Omni completion settings
set omnifunc=phpcomplete#CompletePHP

" You might also find this useful
" PHP Generated Code Highlights (HTML & SQL)
let php_sql_query=1
let php_htmlInStrings=1


" Generate ctags
if has("win32")
	"nmap <silent> <Leader>c call :!start /min phptags<CR>
	nmap <Leader>c :!start /min phptags.cmd<CR>
endif
