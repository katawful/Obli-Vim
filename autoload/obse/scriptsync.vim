" Add sign {{{
function! obse#scriptsync#AddSign()
  let l:list = obse#scriptsync#ParseLogFile()
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
function! obse#scriptsync#UnSign()
  " unsign all signs
  call sign_unplace("info")
  call sign_unplace("error")
endfunction
" }}}

" Parse log file {{{
function! obse#scriptsync#ParseLogFile()
  " these are set to -1 instead of blank
  " not sure why this was needed
  let l:e_output = ['-1']
  let l:i_output = ['-1']
  let name = obse#scriptsync#GetLogFile()

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
function! obse#scriptsync#ExtractLine()
  let name = obse#scriptsync#GetLogFile()
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
function! obse#scriptsync#ShowFloatLog()
  let l:list = obse#scriptsync#ParseLogFile()
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

  let l:matched_line = obse#scriptsync#ExtractLine()
  let l:width = strchars(l:matched_line)

  " check if we even have signs
  let l:signs_exist = obse#scriptsync#GetSigns('error', 0)
  if type(l:signs_exist) ==? type(0)
    let l:signs_exist = obse#scriptsync#GetSigns('info', 0)
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
function! obse#scriptsync#CloseFloatLogNV()
  let win = win_findbuf(s:buf)
  call nvim_win_close(get(win, 0, 'default'), 0)
endfunction
" }}}

" Get log file {{{
function! obse#scriptsync#GetLogFile()
  " trim current buffer than append '.log' to it
  let name = expand("%:r") . ".log"
  return name
endfunction
" }}}

" Check if log exists {{{
function! obse#scriptsync#LogCheck()
  let file = obse#scriptsync#GetLogFile()
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
function! obse#scriptsync#GetSigns(type, line)
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
function! obse#scriptsync#JumpSigns(type, direction)

  let signs = []

  let curr_line = line('.')
  
  " get sign type
  if a:type ==? 'error'
    let err_signs = obse#scriptsync#GetSigns('error', 0)
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
    let info_signs = obse#scriptsync#GetSigns('info', 0)
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
    let err_signs = obse#scriptsync#GetSigns('error', 0)
    if type(err_signs) ==? 0
      let l:error = 0
    else
      let l:error = 1
    endif
    let info_signs = obse#scriptsync#GetSigns('info', 0)
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
