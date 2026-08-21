" Vim compiler file
" Compiler: go build (no binary written)

if exists('current_compiler')
  finish
endif
let current_compiler = 'go_build'

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=go\ build\ -o\ /dev/null\ ./...
CompilerSet errorformat=
      \%-G#\ %.%#,
      \%-G%.%#panic:\ %m,
      \%Ecan\'t\ load\ package:\ %m,
      \%A%f:%l:%c:\ %m,
      \%A%f:%l:\ %m,
      \%C%*\\s%m,
      \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
