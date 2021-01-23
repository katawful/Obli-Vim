" Look for NeoVim support
if has('nvim')
  let g:ov_nvim_support = 1
else
  let g:ov_nvim_support = 0
endif

" set default sync time
if !exists("g:ov_sync_time")
  let g:ov_sync_time = 3
elseif g:ov_sync_time < 1 || type(g:ov_sync_time) == type(0.0)
  echohl Error
  echomsg "Error: g:ov_sync_time is not a valid integer, defaulting to 3"
  echohl None
  let g:ov_sync_time = 3
endif

augroup ov_autocommand
  autocmd!
  autocmd BufWritePre *.obl call OV_Main(0)
  autocmd BufWritePost *.obl call OV_Main(1)
  autocmd TextChanged *.obl call UpdateSignsNV()
  autocmd TextChangedI *.obl call UpdateSignsNV()
augroup END

" Sign function {{{
function OV_Sign(timer)
  if g:ov_nvim_support ==? 1
    call AddSignNV()
  endif
  redraw
endfunction
" }}}

" Main {{{
function! OV_Main(sign)
  " I need to present the signs whenever the log file gets updated
  " use the sync time
  if LogCheck() ==? 0
    return 0
  endif
  if a:sign ==? 0
    if g:ov_nvim_support ==? 1
      call UnSignNV()
    endif
    redraw
  elseif a:sign ==? 1
    " add timer so we don't read an unupdated log file
    let timer = timer_start(((g:ov_sync_time * 1000) + 150), 'OV_Sign')
  endif

endfunction
" }}}

" Show the log {{{
function! ShowCSLog()
    " open up log file and stuff
    if LogCheck() ==? 1
      " create and draw buffer
      let l:log_file = GetLogFile()
      execute 'below split ' . l:log_file
      let l:lines = line('$')
      setlocal filetype=ob_log
      set nomodifiable
      execute 'resize ' . l:lines
      redraw

      " maps to close buffer easily
      nnoremap <buffer> <Esc> :bd<CR>
      nnoremap <buffer> <Space> :bd<CR>
      nnoremap <buffer> <C-[> :bd<CR>
    endif
endfunction
" }}}

" Add sign - NeoVim support {{{
function! AddSignNV()
  " sign define test text=>> texthl=Error linehl=ErrorMsg
  " sign place 3 line=3 name=test
  let l:list = ParseLogFile()
  " define error sign for number of error
  let l:error = get(l:list, 0, 'default')
  let l:info = get(l:list, 1, 'default')
  let i = 0
  for l:match in l:error
    if l:match !=? -1
      let l:sign_name = join(["Line", l:match], ":")
      execute 'sign define ' . l:sign_name . ' text=>> texthl=Error linehl=ErrorMsg'
      execute 'sign place ' . i . ' group=error line=' . l:match . ' name=' . l:sign_name
    endif
    let i += 1
  endfor
  for l:match in l:info
    if l:match !=? -1
      let l:sign_name = join(["Line", l:match], ":")
      execute 'sign define ' . l:sign_name . ' text=>> texthl=Title'
      execute 'sign place ' . i . ' group=info line=' . l:match . ' name=' . l:sign_name
    endif
    let i += 1
  endfor
endfunction
" }}}

" Unsign - NeoVim support {{{
function! UnSignNV()
  sign unplace * group=error
  sign unplace * group=info
endfunction
" }}}

" Update signs - NeoVim Support {{{
function! UpdateSignsNV()
  call UnSignNV()
  call AddSignNV()
endfunction
" }}}

" Parse log file {{{
function! ParseLogFile()
  let l:e_output = ['-1']
  let l:i_output = ['-1']
  let name = GetLogFile()

  let l:file = readfile(name)
  for l:line in l:file
    " find error line
    if match(l:line, "[E]") ==? 1
      let l:split = split(l:line)
      let l:get = get(l:split, 2, 'default')
      let l:e_output = add(l:e_output, l:get)
    elseif match(l:line, "[I]") ==? 1
      let l:split = split(l:line)
      let l:get = get(l:split, 2, 'default')
      let l:i_output = add(l:i_output, l:get)
    endif
  endfor
  return [l:e_output, l:i_output]
endfunction
" }}}

" Get log file {{{
function! GetLogFile()
  " trim current buffer than append '.log' to it
  let name = trim(bufname("%"), ".obl") . ".log"
  return name
endfunction
" }}}

" Check if log exists {{{
function! LogCheck()
  let file = GetLogFile()
  if filereadable(file)
    return 1
  else
    echohl ErrorMsg
    echomsg "ERROR:" file . " does not exist, please figure out why"
    echohl None
    return 0
  endif
endfunction
" }}}

" Get signs {{{
function! GetSigns(type, line)
  let list = [] " we need an empty list to add stuff to
  if a:type ==? 'error'
    let signs_dict = sign_getplaced(bufname("%"), {'group' : 'error'})
  elseif a:type ==? 'info'
    let signs_dict = sign_getplaced(bufname("%"), {'group' : 'info'})
  endif

  " append the line number to the function
  for sign in signs_dict
    for num in sign.signs
      call add(list, num.lnum)
    endfor
  endfor
  return list
endfunction
" }}}

" Jump to sign {{{
function! JumpSign(type, direction)
  " get the list of signs 
  let err_signs = GetSignsNV('error', 0)
  let info_signs = GetSignsNV('info', 0)

  let signs = []
  for sign in err_signs
    let signs = add(signs, sign)
  endfor
  for sign in info_signs
    let signs = add(signs, sign)
  endfor
  call sort(signs, 'n')

  " get current line
  let curr_line = line('.')

endfunction
" }}}
