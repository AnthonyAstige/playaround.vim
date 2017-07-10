let s:playbuf = 0
function! s:Play()
	let l:filename = expand('%:p')
	let l:extension = tolower(expand('%:e'))

	let l:cmd = ""
	if "js" == l:extension
		let l:cmd = "node"
	elseif "swift" == l:extension
		let l:cmd = "swift"
	endif

	" Don't play if we don't have a command to run
	if "" == l:cmd
		return
	endif

	if 0 == s:playbuf
		" Open new window & new buffer
		:execute ":botright vnew"

		" Save buffer reference
		let s:playbuf = bufnr("$")

		"Buffer - Not listed in buffers, not modifiable
		:setlocal nobuflisted
		:setlocal nomodifiable

		"Buffer - Scratch
		:setlocal buftype=nofile
		:setlocal bufhidden=hide
		:setlocal noswapfile
	endif

	" Go to play buffer & unlock it
	execute ":buffer " . s:playbuf
	:setlocal modifiable

	" Get blank buffer with timestamp only
	:normal ggdG
	:put =strftime(\"%c\")
	:normal ggddG

	" Show command exection in window
	:execute ":read !" . l:cmd. " " . l:filename

	" Lock buffer again
	:setlocal nomodifiable
endfunction
:autocmd BufWritePost * :call s:Play()
