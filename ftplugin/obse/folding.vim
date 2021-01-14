setlocal foldmethod=expr
setlocal foldexpr=GetOBSEFold(v:lnum)
let s:end_if = 0
" most of this comes from Learning Vimscript the Hard Way
" while it works ok, it doesn't actually fold the parts of the
" if statement that are inline with the first if like else and endif
" i wanted to fix this

" GetOBSEFold {{{
" This is the actual fold expression
function! GetOBSEFold(lnum)
  " check if current line is blank or not
  if getline(a:lnum) =~? '\v^\s*$'
    return '-1'
  endif
  let current = a:lnum
  let l:end_if = -1
  let if_block = FindIfBlock(current)
  let if_block = split(if_block) " this gives me my list

  " we need to see the current indent and the next indent line
  let this_indent = IndentLevel(a:lnum)
  let next_indent = IndentLevel(NextNonBlankLine(a:lnum))

  " are we at the start of if block?
  " basically what i'm doing is seeing if we start the if_block
  " then pass the end of the if block to this function to be folded
  if current ==? get(if_block, 0, 'default')
    let s:end_if = get(if_block, 2, 'default')
    return '>' . next_indent
  elseif current ==? s:end_if
    let s:end_if = 0
    return '>' . (this_indent + 1)
  else
    " this is straight from the guide
    if next_indent ==? this_indent
      return this_indent
    elseif next_indent < this_indent
      return this_indent
    elseif next_indent > this_indent
      return '>' . next_indent
    endif
  endif
endfunction
" }}}

" FindIfBlock {{{
" this function finds the if block so we can fold it
function! FindIfBlock(lnum)
  " get total lines and current line
  let numlines = line('$')
  let current = a:lnum
  " if current line is an if block

  if getline(current) =~? '\<if'
    " pass that and get the indentlevel
    let l:start = current
    let l:start_indent = IndentLevel(start)
    let l:end = 0
    let l:end_indent = 0

    while current <= numlines
      if getline(current) =~? '\<endif' " if current line has our end
        if IndentLevel(current) ==? start_indent " and if it has the same indent
          let l:end = current " pass the line
          let l:end_indent = IndentLevel(end)
          break
        endif
      endif
      let current += 1
    endwhile
    " i needed to cocatanate like this for some reason so i could get a list
    return l:start .  ' ' . l:start_indent . ' ' . l:end  . ' ' . l:end_indent
  endif
endfunction
" }}}

" IndentLevel {{{
" this gets us the indent level of the current line
function! IndentLevel(lnum)
  " return the indent level divided by our shiftwidth
  return indent(a:lnum) / &shiftwidth
endfunction
" }}}

" NextNonBlankLine {{{
" This function finds the next non-blank line
" this means we won't fold on a blank for blocks
function! NextNonBlankLine(lnum)
  " find number of lines in file
  let numlines = line('$')
  " get the current line + 1
  let current = a:lnum + 1

  " while next line isn't more than the total line
  while current <= numlines
    " see if blank only
    if getline(current) =~? '\v\S'
      " if it is return
      return current
    endif

    " otherwise increment
    let current += 1
  endwhile
  return -2
endfunction
" }}}
