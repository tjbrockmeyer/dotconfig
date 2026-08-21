" Vim compiler file
" Compiler: Jest (local via npx)
" Parses failure stack frames into the quickfix list.

if exists('current_compiler')
  finish
endif
let current_compiler = 'jest'

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=npx\ jest\ --no-coverage\ --no-colors
CompilerSet errorformat=%E\ %#●\ %m,
      \%Z%.%#\ at\ %.%#(%f:%l:%c),
      \%.%#\ at\ %.%#(%f:%l:%c),
      \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
