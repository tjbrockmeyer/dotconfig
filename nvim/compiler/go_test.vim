" Vim compiler file
" Compiler: go test

if exists('current_compiler')
  finish
endif
let current_compiler = 'go_test'

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=go\ test\ ./...
CompilerSet errorformat=
      \%-G#\ %.%#,
      \%-G%.%#panic:\ %m,
      \%-GFAIL\ %.%#,
      \%-Gok\ %.%#,
      \%-GPASS%.%#,
      \%-G---\ PASS:%.%#,
      \%E---\ FAIL:\ %m,
      \%A%f:%l:%c:\ %m,
      \%A%f:%l:\ %m,
      \%C%*\\s%m,
      \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
