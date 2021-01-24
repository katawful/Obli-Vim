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
  autocmd TextChanged *.obl call OV_Main(0)
  autocmd TextChangedI *.obl call OV_Main(0)
augroup END

" TODO make these mappings not suck ass
let maplocalleader = "<C-a>"
nnoremap <buffer> <C-a>en :call JumpSign('error','next')<CR>
nnoremap <buffer> <C-a>ep :call JumpSign('error','prev')<CR>
nnoremap <buffer> <C-a>in :call JumpSign('info','next')<CR>
nnoremap <buffer> <C-a>ip :call JumpSign('info','prev')<CR>
nnoremap <buffer> <C-a>n :call JumpSign('all','next')<CR>
nnoremap <buffer> <C-a>p :call JumpSign('all','prev')<CR>

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
  let err_signs = GetSigns('error', 0)
  let info_signs = GetSigns('info', 0)

  let signs = []
  for sign in err_signs
    let signs = add(signs, sign)
  endfor
  for sign in info_signs
    let all_signs = add(signs, sign)
  endfor
  call sort(all_signs, 'n')

  let curr_line = line('.')
  
  " get sign type
  if a:type ==? 'error'
    let l:sign_len = len(err_signs)
    let signs = err_signs
  elseif a:type ==? 'info'
    let l:sign_len = len(info_signs)
    let signs = info_signs
  elseif a:type ==? 'all'
    let l:sign_len = len(signs)
    let signs = all_signs
  endif

  let match = index(signs, curr_line)
  " we aren't on a sign
  if match ==? -1

    " case 1: line # < first sign
      " for next: jump to first sign
      " for prev: jump to last sign 
    " case 2: sign < line < sign 
      " next: jump to sign that's bigger
      " prev: jump to sign that's smaller
    " case 3: line > last sign 
      " next: jump to first sign 
      " prev: jump to last sign
      
    " case 1: {{{
    if curr_line <? get(signs, 0, 'default')
      if a:direction ==? 'next'
        let jump = get(signs, 0, 'default')
      elseif a:direction ==? 'prev'
        let jump = get(signs, (l:sign_len - 1), 'default')
      endif
    " }}}
    " case 3: {{{
    elseif curr_line >? get(signs, (l:sign_len - 1), 'default')
      if a:direction ==? 'next'
        let jump = get(signs, 0, 'default')
      elseif a:direction ==? 'prev'
        let jump = get(signs, (l:sign_len - 1), 'default')
      endif
    " }}}
    " case 2: {{{
    else 
      let i = 0
      while i <? l:sign_len
        " we have passed from the signs being less than
        " the current line
        let l:sign_line = get(signs, i, 'default')
        if curr_line <? l:sign_line
          if a:direction ==? 'next'
            let jump = get(signs, (i), 'default')
            break
          elseif a:direction ==? 'prev'
            let jump = get(signs, (i - 1), 'default')
            break
          endif
        endif 
        let i += 1 
      endwhile
    " }}}
    endif

  execute jump
  else
  " we are on a sign

    if a:direction ==? 'next'
      " if match is the last then jump to first
      if match ==? (l:sign_len - 1)
        let jump = get(signs, (0), 'default') 
      " else just iterate
      else
        let jump = get(signs, (match + 1), 'default') 
      endif
    elseif a:direction ==? 'prev'
      " if match is first then jump to first
      if match ==? 0
        let jump = get(signs, (l:sign_len - 1), 'default') 
      " else just iterate
      else
        let jump = get(signs, (match - 1), 'default') 
      endif
    endif
    execute jump

  endif

endfunction
" }}}
