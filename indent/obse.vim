" Vim indent file
" Language:    OB Script
" Maintainer:  Kat <katisntgood@gmail.com>
" Created:     February 01, 2021
" Last Change: February 01, 2021

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetObseIndent()
setlocal indentkeys+==end,=else,=loop

if exists("*GetObseIndent")
  finish
endif
let s:keepcpo= &cpo
set cpo&vim

let s:SKIP_LINES = '^\s*\(;.*\)'
function! GetObseIndent()

  let lnum = prevnonblank(v:lnum - 1)
  let cur_text = getline(v:lnum)
  if lnum == 0
    return 0
  endif
  let prev_text = getline(lnum)
  let found_cont = 0
  let ind = indent(lnum)

  " indent next line on start terms
  let i = match(prev_text, '\c^\s*\(\s\+\)\?\({\|\(if\|while\|foreach\|begin\|else\%[if]\)\>\)')
  if i >= 0
    let ind += shiftwidth()
    if strpart(prev_text, i, 1) == '|' && has('syntax_items')
          \ && synIDattr(synID(lnum, i, 1), "name") =~ '\(Comment\|String\)$'
      let ind -= shiftwidth()
    endif
  endif
  " indent current line on end/else terms
  if cur_text =~ '\c^\s*\(\s\+\)\?\({\|\(loop\|end\|endif\|else\%[if]\)\>\)'
    let ind = ind - shiftwidth()
  endif
  return ind
endfunction

