" To use this, put `source $HOME/.vim/vimrc_ft/angularjs.vim` in 
" your local .vimrc file

""" activate snipmate snippets
if !exists("g:snipMate")
  " g:snipMate is defined in plugin.vimrc
  finish
endif
function! s:SnippetHelper(ori, alt)
  function! IsTrue(arg)
    " this function attemps to fix the broken boolean testing for empty string in vimscript
    " it will do the right thing for the boolean value of strings
    if type(a:arg) == type("")
      return !empty(a:arg)
    endif
    return a:arg
  endfunction

  if !exists("g:snipMate.scope_aliases")
    let g:snipMate.scope_aliases = {}
  endif
  if !empty(get(g:snipMate.scope_aliases, a:ori))
    let g:snipMate.scope_aliases[a:ori] = printf("%s,%s", a:ori, a:alt)
  else
    let g:snipMate.scope_aliases[a:ori] = g:snipMate.scope_aliases[a:ori] . ',' . a:alt
  endif
endfunction

call s:SnippetHelper('html', 'angular_html')
call s:SnippetHelper('javascript', 'angular_js')
call s:SnippetHelper('haml', 'angular_haml')
call s:SnippetHelper('coffee', 'angular_coffee')

""" command to run
" TODO
