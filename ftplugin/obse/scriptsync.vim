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
  let g:ov_JumpNextError = '\en'
endif
if !exists("g:ov_JumpPrevError")
  let g:ov_JumpPrevError = '\ep'
endif
if !exists("g:ov_JumpNextInfo")
  let g:ov_JumpNextInfo = '\in'
endif
if !exists("g:ov_JumpPrevInfo")
  let g:ov_JumpPrevInfo = '\ip'
endif
if !exists("g:ov_JumpNextAll")
  let g:ov_JumpNextAll = '\n'
endif
if !exists("g:ov_JumpPrevAll")
  let g:ov_JumpPrevAll = '\p'
endif
execute 'nnoremap <buffer> ' . g:ov_JumpNextError . " :call obse#scriptsync#JumpSigns('error','next')<CR>"
execute 'nnoremap <buffer> ' . g:ov_JumpPrevError . " :call obse#scriptsync#JumpSigns('error','prev')<CR>"
execute 'nnoremap <buffer> ' . g:ov_JumpNextInfo . " :call obse#scriptsync#JumpSigns('info','next')<CR>"
execute 'nnoremap <buffer> ' . g:ov_JumpPrevInfo . " :call obse#scriptsync#JumpSigns('info','prev')<CR>"
execute 'nnoremap <buffer> ' . g:ov_JumpNextAll . " :call obse#scriptsync#JumpSigns('all','next')<CR>"
execute 'nnoremap <buffer> ' . g:ov_JumpPrevAll . " :call obse#scriptsync#JumpSigns('all','prev')<CR>"
" }}}

" set show floating window defaults {{{
if !exists("g:ov_ShowFloatLog")
  let g:ov_ShowFloatLog = '\l'
endif
execute 'nnoremap <buffer> ' . g:ov_ShowFloatLog . " :call OV_Main(2)<CR>"
" }}}
augroup ov_beginauto
  autocmd!
  autocmd BufWritePre <buffer> call OV_Main(7)
augroup END

" autocommands {{{
function! OV_Autogroup(state)
  if a:state ==? 1
    augroup ov_autocommand
      autocmd!
      autocmd BufWritePre <buffer> call OV_Main(0)
      autocmd BufWritePost <buffer> call OV_Main(1)
      autocmd TextChanged <buffer> call OV_Main(0)
      autocmd TextChangedI <buffer> call OV_Main(0)
    augroup END
  else 
    augroup ov_autocommand
      autocmd!
    augroup END
  endif 
endfunction
" }}}


" Sign function {{{
" this exists so we can pass off sign creation to a timer
" using sleep() stops vim from working
function OV_Sign(timer)
  call obse#scriptsync#AddSign()
  redraw
endfunction
" }}}

" Main {{{
function! OV_Main(sign)
  " I need to present the signs whenever the log file gets updated
  " use the sync time
  if g:ov_disable_cse ==? 0
    augroup ov_autocommand
      autocmd!
      autocmd BufWritePre <buffer> call OV_Main(0)
      autocmd BufWritePost <buffer> call OV_Main(1)
      autocmd TextChanged <buffer> call OV_Main(0)
      autocmd TextChangedI <buffer> call OV_Main(0)
    augroup END
  else
    augroup ov_autocommand
      autocmd!
    augroup END
  endif

  if a:sign ==? 0
    " NOTE: we add a logcheck for each one that needs it
    " not sure if most efficient
    if obse#scriptsync#LogCheck() ==? 0
      return 0
    else
      call obse#scriptsync#UnSign()
      redraw
    endif
  elseif a:sign ==? 1
    " add timer so we don't read an unupdated log file
    if obse#scriptsync#LogCheck() ==? 0
      return 0
    else
      let timer = timer_start(((g:ov_sync_time * 1000) + 50), 'OV_Sign')
    endif
  " show log line
  elseif a:sign ==? 2
    if obse#scriptsync#LogCheck() ==? 0
      return 0
    else
      call obse#scriptsync#ShowFloatLog()
    endif
  elseif a:sign ==? 3
    if g:ov_nvim_support ==? 1
      call obse#scriptsync#CloseFloatLogNV()
    endif
  endif

endfunction
" }}}
