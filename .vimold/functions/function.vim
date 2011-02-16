function! LoadFileTemplate(name)
	let s:template = '~/.vim/templates/' . a:name
	silent source s:template
	silent execute "0read " . s:template
endfunction
