let s:playbuf = 0
function! s:Play()
	let l:filename = expand('%:p')
	let l:extension = tolower(expand('%:e'))

	" Figure out command
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

	" Construct full command
	let l:fullcommand= l:cmd . " " . l:filename

	" Destroy any existing buffer and start all over
	" * This bandaid is not ideal , but I was having trouble restoring the
	" cursor position to rows/columns that didn't exist in play buffer
	if 0 != s:playbuf
		execute "bdelete " . s:playbuf
	endif

	"" Open a new play buffer if needed
	" Open new window & new buffer
	:execute ":botright vnew"
	" Save buffer reference
	let s:playbuf = bufnr("$")
	" Unlisted & sratch
	:setlocal nobuflisted
	:setlocal buftype=nofile
	:setlocal bufhidden=hide
	:setlocal noswapfile

	" Go to play buffer
	execute ":buffer " . s:playbuf

	" Make blank buffer with timestamp & command running only
	:normal ggdG
	:put =l:fullcommand
	:put =strftime(\"%c\")
	let l:blankline=""
	:put =l:blankline
	:normal ggddG

	" Show command exection in window
	:execute ":read !" . l:fullcommand

	" Lock buffer
	:setlocal nomodifiable
endfunction

function! s:MakePlayground()
	if exists('#Playground#BufWritePost')
		if s:playbuf
			execute "bdelete " . s:playbuf
		endif
		augroup Playground
			autocmd!
		augroup END
		let s:playbuf = 0
		echo "Playground destroyed"
	else
		augroup Playground
			autocmd BufWritePost * :call s:Play()
		augroup END
		execute "w"
	endif
endfunction

command! PlayaroundToggle :call s:MakePlayground()
