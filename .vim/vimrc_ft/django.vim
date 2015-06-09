" To use this, put `source $HOME/.vim/vimrc_ft/django.vim` in 
" your local .vimrc file

""" activate snipmate snippets
if !exists("g:snipMate")
  " g:snipMate is defined in plugin.vimrc
  finish
endif
function! s:SnippetHelper(ori, alt)
  if !exists("g:snipMate.scope_aliases")
    let g:snipMate.scope_aliases = {}
  endif
  if !vimlib#IsTrue(get(g:snipMate.scope_aliases, a:ori))
    let g:snipMate.scope_aliases[a:ori] = printf("%s,%s", a:ori, a:alt)
  else
    let g:snipMate.scope_aliases[a:ori] = g:snipMate.scope_aliases[a:ori] . a:alt
  endif
endfunction

call s:SnippetHelper('python', 'django')
call s:SnippetHelper('html', 'htmldjango')

""" tags
set tags+=/Users/enting/Development/python/django/pythondjango.tags

""" command to run django
" TODO
