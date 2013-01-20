" LaTeX related functions

" Compiles a tex file to PDF and displays it using system PDF viewer
function! TexCompileAndView(verbose, view)
	" Tex filename
	let l:tex_fname = shellescape(expand("%:p"))
	" Tex output directory
	let l:tex_dname = shellescape(fnamemodify(expand("%:p"), ":h"))
	" PDF filename
	let l:pdf_fname = substitute(l:tex_fname, ".tex", ".pdf", 'g')

	" Compiles Tex file to PDF
	let l:cmd = 'pdflatex -output-directory ' . l:tex_dname . ' ' . l:tex_fname

	if (a:view == 1)
		let l:cmd .= ' && '
		let l:cmd .= 'evince ' . l:pdf_fname
	endif

	if (a:verbose == 1)
		silent exec "Shell " . l:cmd
	else
		call system(l:cmd . " &")
	endif
endfunction

command! TexCompile call TexCompileAndView(1, 0)
command! TexCompileAndView call TexCompileAndView(0, 1)

nnoremap <silent> <leader>r :TexCompileAndView<cr>
nnoremap <silent> <leader>c :TexCompile<cr>
