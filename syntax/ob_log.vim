" CSE SciptSync Syntax file

if exists("b:current_syntax")
  finish
endif

let b:current_syntax = 'ob_log'

" Message type column {{{
syn match logInfo '\[I\]' nextgroup=logLineNumber
syn match logError '\[E\]' nextgroup=logLineNumber
syn match logLineNumber 'Line \d*'
" }}}

if !exists("did_ob_log_inits")
  let did_ob_log_inits = 1

  hi def link logInfo Label
  hi def link logError Error
  hi def link logLineNumber Number
endif
