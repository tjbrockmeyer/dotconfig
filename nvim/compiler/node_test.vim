" Vim compiler file
" Compiler: Node.js built-in test runner

if exists('current_compiler')
  finish
endif
let current_compiler = 'node_test'

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=node\ --test
CompilerSet errorformat=%E%.%#Error\ [%*[^]]]:\ %m,
      \%E%.%#Error:\ %m,
      \%Z%.%#\ at\ %.%#(%f:%l:%c),
      \%.%#\ at\ %.%#(%f:%l:%c),
      \%.%#\ at\ %f:%l:%c,
      \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
