" Look for NeoVim support {{{
if has('nvim')
  let g:ov_nvim_support = 1
else
  let g:ov_nvim_support = 0
endif
" }}}

" set default sync time {{{
if !exists("g:ov_sync_time")
  let g:ov_sync_time = 3
elseif g:ov_sync_time < 1 || type(g:ov_sync_time) == type(0.0)
  echohl Error
  echomsg "Error: g:ov_sync_time is not a valid integer, defaulting to 3"
  echohl None
  let g:ov_sync_time = 3
endif
" }}}

" set default border style {{{
if !exists("g:ov_window_style")
  let g:ov_window_style = 'single'
elseif g:ov_window_style !=? 'single' || g:ov_window_style !=? 'double'
  echohl Error
  echomsg "Error: g:ov_window_style is not a valid setting, setting to default value ('single')"
  echohl None
  let g:ov_window_style = 'single'
endif
" }}}

" set sign text defaults {{{
if !exists("g:ov_error_sign")
  let g:ov_error_sign = "=>"
endif 
if !exists("g:ov_info_sign")
  let g:ov_info_sign = "=>"
endif 
" }}}

" set disable log default {{{
if !exists("g:ov_disable_cse")
  let g:ov_disable_cse = 0
endif 
" }}}

" set sign jump maps defaults {{{
if !exists("g:ov_JumpNextError")
  let g:ov_JumpNextError = '<C-a>en'
endif
if !exists("g:ov_JumpPrevError")
  let g:ov_JumpPrevError = '<C-a>ep'
endif
if !exists("g:ov_JumpNextInfo")
  let g:ov_JumpNextInfo = '<C-a>in'
endif
if !exists("g:ov_JumpPrevInfo")
  let g:ov_JumpPrevInfo = '<C-a>ip'
endif
if !exists("g:ov_JumpNextAll")
  let g:ov_JumpNextAll = '<C-a>n'
endif
if !exists("g:ov_JumpPrevAll")
  let g:ov_JumpPrevAll = '<C-a>p'
endif
execute 'nnoremap <buffer> ' . g:ov_JumpNextError . " :call JumpSign('error','next')<CR>"
execute 'nnoremap <buffer> ' . g:ov_JumpPrevError . " :call JumpSign('error','prev')<CR>"
execute 'nnoremap <buffer> ' . g:ov_JumpNextInfo . " :call JumpSign('info','next')<CR>"
execute 'nnoremap <buffer> ' . g:ov_JumpPrevInfo . " :call JumpSign('info','prev')<CR>"
execute 'nnoremap <buffer> ' . g:ov_JumpNextAll . " :call JumpSign('all','next')<CR>"
execute 'nnoremap <buffer> ' . g:ov_JumpPrevAll . " :call JumpSign('all','prev')<CR>"
" }}}

" set show floating window defaults {{{
if !exists("g:ov_ShowFloatLog")
  let g:ov_ShowFloatLog = '<C-a>l'
endif
execute 'nnoremap <buffer> ' . g:ov_ShowFloatLog . " :call OV_Main(2)<CR>"
" }}}

" autocommands {{{
if g:ov_disable_cse ==? 0
  augroup ov_autocommand
    autocmd!
    autocmd BufWritePre *.obl call OV_Main(0)
    autocmd BufWritePost *.obl call OV_Main(1)
    autocmd TextChanged *.obl call OV_Main(0)
    autocmd TextChangedI *.obl call OV_Main(0)
  augroup END
else
  augroup ov_autocommand
    autocmd 
  augroup END
endif
" }}}


" Sign function {{{
" this exists so we can pass off sign creation to a timer
" using sleep() stops vim from working
function OV_Sign(timer)
  call AddSign()
  redraw
endfunction
" }}}

" Main {{{
function! OV_Main(sign)
  " I need to present the signs whenever the log file gets updated
  " use the sync time
  if a:sign ==? 0
    " NOTE: we add a logcheck for each one that needs it
    " not sure if most efficient
    if LogCheck() ==? 0
      return 0
    else
      call UnSign()
      redraw
    endif
  elseif a:sign ==? 1
    " add timer so we don't read an unupdated log file
    if LogCheck() ==? 0
      return 0
    else
      let timer = timer_start(((g:ov_sync_time * 1000) + 50), 'OV_Sign')
    endif
  " show log line
  elseif a:sign ==? 2
    if LogCheck() ==? 0
      return 0
    else
      call ShowFloatLog()
    endif
  elseif a:sign ==? 3
    if g:ov_nvim_support ==? 1
      call CloseFloatLogNV()
    endif
  endif

endfunction
" }}}

" Show the log {{{
" TODO: Delete???
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

" Add sign {{{
function! AddSign()

  let l:list = ParseLogFile()
  " define error sign for number of error
  let l:error = get(l:list, 0, 'default')
  let l:info = get(l:list, 1, 'default')
  let i = 0
  " create a sign for each line with an matching message
  for l:match in l:error
    if l:match !=? -1
      let l:sign_name = join(["Line", l:match], ":")
      call sign_define(l:sign_name, {"text" : g:ov_error_sign, "texthl" : "Error"})
      call sign_place(i, 'error', l:sign_name, "%", {'lnum' : l:match})
    endif
    let i += 1
  endfor
  for l:match in l:info
    if l:match !=? -1 && l:match !=? 1
      let l:sign_name = join(["Line", l:match], ":")
      call sign_define(l:sign_name, {"text" : g:ov_info_sign, "texthl" : "Title"})
      call sign_place(i, 'info', l:sign_name, "%", {'lnum' : l:match})
    endif
    let i += 1
  endfor
endfunction
" }}}

" Unsign {{{
function! UnSign()
  " unsign all signs
  call sign_unplace("*")
endfunction
" }}}

" Parse log file {{{
function! ParseLogFile()
  " these are set to -1 instead of blank
  " not sure why this was needed
  let l:e_output = ['-1']
  let l:i_output = ['-1']
  let name = GetLogFile()

  " load log file and read each line
  let l:file = readfile(name)
  for l:line in l:file
    " find error line
    if match(l:line, "[E]") ==? 1
      " split line up into list
      let l:split = split(l:line)
      " read line number from 3 item
      let l:get = get(l:split, 2, 'default')
      let l:e_output = add(l:e_output, l:get)
    " find info line
    elseif match(l:line, "[I]") ==? 1
      let l:split = split(l:line)
      let l:get = get(l:split, 2, 'default')
      let l:i_output = add(l:i_output, l:get)
    endif
  endfor
  return [l:e_output, l:i_output]
endfunction
" }}}

" Extract Line from Log {{{
function! ExtractLine()
  let name = GetLogFile()
  let l:curr_line = line('.')

  let l:file = readfile(name)
  for l:line in l:file
    " find line with log info starting at the 8th character
    if match(l:line, l:curr_line, 8) >=? 1
      " replace tabs with spaces
      let l:line = substitute(l:line, "\t", " ", 'g')
      return l:line
    endif
  endfor
endfunction
" }}}

" Floating window {{{
function! ShowFloatLog()
  let l:list = ParseLogFile()
  let l:curr_line = line('.')
  let l:window_enable = 0

  " see if we are on a line with a sign
  " l:list is nested lists, use a nested for loop
  for l:match in l:list
    for l:line in l:match
      if l:line ==? l:curr_line
        let l:window_enable = 1
      endif
    endfor
  endfor 

  let l:matched_line = ExtractLine()
  let l:width = strchars(l:matched_line)

  " check if we even have signs
  let l:signs_exist = GetSigns('error', 0)
  if type(l:signs_exist) ==? type(0)
    let l:signs_exist = GetSigns('info', 0)
    if type(l:signs_exist) ==? type(0)
      let l:signs_exist = v:false
    else
      let l:signs_exist = v:true
    endif
  else
    let l:signs_exist = v:true
  endif 

  " we are on a matching line and we have signs
  if l:window_enable ==? 1 && l:signs_exist ==? v:true
    if g:ov_nvim_support ==? 1
      " set window opts
      let opts = {
            \'relative': 'cursor',
            \'width': l:width+2,
            \'height': 3,
            \'col': 1,
            \'row': 1, 
            \'style': 'minimal'
            \}
      " set border styles
      if g:ov_window_style ==? 'single'
        let top = "╭" . repeat("─", l:width ) . "╮"
        let mid = "│" . l:matched_line . "│"
        let bot = "╰" . repeat("─", l:width ) . "╯"
      elseif g:ov_window_style ==? 'double'
        let top = "╔" . repeat("═", l:width ) . "╗"
        let mid = "║" . l:matched_line . "║"
        let bot = "╚" . repeat("═", l:width ) . "╝"
      endif
      let lines = [top] + [mid] + [bot]

      " create a buffer as a script var so we know which one is created
      let s:buf = nvim_create_buf(v:false,v:true)
      call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
      let win = nvim_open_win(s:buf, v:true, opts)
      call nvim_buf_set_option(s:buf, 'syntax', 'ob_log')
      call nvim_win_set_option(win, 'winhl', 'Normal:Pmenu')
      let win = win_getid(win)
      call nvim_win_set_cursor(win, [2,4])

      " create a list of keys so we can exit the floating window
      let keys = [
            \'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h',
            \'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 
            \'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 
            \'y', 'z', '<CR>', '<Space>', '<Esc>',
            \ '<Tab>'
            \ ]
      " set all the above to close the window
      for key in keys
        call nvim_buf_set_keymap(s:buf, 'n', key, ':call OV_Main(3)<CR>', { 
              \'noremap' : v:true, 'nowait' : v:true, 'silent' : v:true})
      endfor
    " vim support
    else
      if g:ov_window_style ==? 'single' && has("gui_running") !=? v:true
        let l:border = ['─', '│', '─', '│', '┌', '┐', '┘', '└']
      elseif g:ov_window_style ==? 'double' || has("gui_running") ==? v:true
        let l:border = ['═','║','═','║','╔','╗','╝','╚']
      endif
      let s:propId = 90
      let winid = popup_atcursor(l:matched_line, #{
            \ pos: 'topleft',
            \ textpropid: s:propId,
            \ border: [2,2,2,2],
            \ borderchars: l:border,
            \ padding: [0,1,0,1],
            \ highlight: 'Pmenu',
            \ close: 'click',
            \ })
      call win_execute(winid, 'syntax enable')
      call setbufvar(winbufnr(winid), '&syntax', 'ob_log')
    endif
  endif
endfunction
" }}}

" Close floating window -- NeoVim Support {{{
function! CloseFloatLogNV()
  let win = win_findbuf(s:buf)
  call nvim_win_close(get(win, 0, 'default'), 0)
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
  " if file is readable it exists
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

  " see if we got any signs
  if get(list, 0, "empty") ==? "empty"
    return 0
  else
    return list
  endif
endfunction
" }}}

" Jump to sign {{{
function! JumpSign(type, direction)

  let signs = []

  let curr_line = line('.')
  
  " get sign type
  if a:type ==? 'error'
    let err_signs = GetSigns('error', 0)
    if type(err_signs) ==? 0
      echohl ErrorMsg
      echo "Error: no signs available"
      echohl None
      let l:error = 0
      return 0
    else
      let l:error = 1
    endif

    let l:sign_len = len(err_signs)
    let signs = err_signs

  elseif a:type ==? 'info'
    let info_signs = GetSigns('info', 0)
    if type(info_signs) ==? 0
      echohl ErrorMsg
      echo "Error: no signs available"
      echohl None
      let l:info = 0
      return 0
    else
      let l:info = 1
    endif

    let l:sign_len = len(info_signs)
    let signs = info_signs

  elseif a:type ==? 'all'
    let all_signs = []
    let err_signs = GetSigns('error', 0)
    if type(err_signs) ==? 0
      let l:error = 0
    else
      let l:error = 1
    endif
    let info_signs = GetSigns('info', 0)
    if type(info_signs) ==? 0
      let l:info = 0
    else
      let l:info = 1
    endif

    " check if we have any signs
    if l:error ==? 1
      for sign in err_signs
        let all_signs = add(signs, sign)
      endfor
    endif
    if l:info ==? 1
      for sign in info_signs
        let all_signs = add(signs, sign)
      endfor
    endif

    let l:sign_len = len(signs)
    call sort(all_signs, 'n')
    let signs = all_signs

  else
    echohl ErrorMsg
    echo "Error: no signs available"
    echohl None
    return 0
  endif

  let match = index(signs, curr_line)
  let l:sign_len = len(signs)
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
