" Vim compiler file
" Compiler: ESLint (local via npx)
" Uses built-in stylish formatter (unix was removed from ESLint core in v9).

if exists('current_compiler')
  finish
endif
let current_compiler = 'eslint'

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=npx\ eslint\ --format\ stylish\ --no-color
CompilerSet errorformat=%-P%f,
      \%\\s%#%l:%c\ %#\ %trror\ \ %m,
      \%\\s%#%l:%c\ %#\ %tarning\ \ %m,
      \%-Q,
      \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
