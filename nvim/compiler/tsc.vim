" Vim compiler file
" Compiler: TypeScript (local via npx, --noEmit)

if exists('current_compiler')
  finish
endif
let current_compiler = 'tsc'

let s:cpo_save = &cpo
set cpo&vim

" Override with: let b:tsc_makeprg = '...' or g:tsc_makeprg
execute $'CompilerSet makeprg={escape(get(b:, 'tsc_makeprg', get(g:, 'tsc_makeprg', 'npx tsc --noEmit --pretty false')), ' \|"')}'
CompilerSet errorformat=%f\ %#(%l\\,%c):\ %trror\ TS%n:\ %m,
      \%trror\ TS%n:\ %m,
      \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
