""" run
" call RunCmdRegister(":!/usr/local/bin/python %")
call RunCmdRegister(":make! % | clast")
function! PytestHelper(scope)
  if empty(a:scope)
    " use last mode
    if !exists("g:pytesthelper_last_mode")
      echoerr "No last mode used"
    else
      bufdo update
      execute "Pytest ".g:pytesthelper_last_mode
    endif
  else
    if !exists("g:pytesthelper_last_mode")
      let g:pytesthelper_last_mode = a:scope
    endif
    bufdo update
    execute "Pytest ".g:pytesthelper_last_mode
  endif
endfunction
nnoremap <leader>tf :call PytestHelper("file")<CR>
nnoremap <leader>td :call PytestHelper("function")<CR>
nnoremap <leader>tc :call PytestHelper("class")<CR>
nnoremap <leader>tp :call PytestHelper("project")<CR>
nnoremap <leader>tt :call PytestHelper("")<CR>

""" eval
nnoremap <buffer> <silent> <leader>e :.w !/usr/local/bin/python<CR>
vnoremap <buffer> <silent> <leader>e :w !/usr/local/bin/python<CR>
nnoremap <buffer> <silent> <leader>E :.!/usr/local/bin/python<CR>
vnoremap <buffer> <silent> <leader>E :!/usr/local/bin/python<CR>

""" abbrev(beware not to use words too common as they will always get expanded)
" ia <buffer> ipdb import ipdb; ipdb.set_trace()<C-R>=Eatchar('\s')<CR>
" ia <buffer> pdb import pdb; pdb.set_trace()<C-R>=Eatchar('\s')<CR>
" ia <buffer> def def :<left><C-R>=Eatchar('\s')<CR>
" ia <buffer> ''' ''''''<left><left><left><C-R>=Eatchar('\s')<CR>
" ia <buffer> """ """"""<left><left><left><C-R>=Eatchar('\s')<CR>
" ia <buffer> ph print("HERE")<C-R>=Eatchar('\s')<CR>
" ia <buffer> p( print()<left><C-R>=Eatchar('\s')<CR>
" ia <buffer> namemain if __name__ == "__main__":<C-R>=Eatchar('\s')<CR>
" func! Eatchar(pat)
"   let c = nr2char(getchar(0))
"   return (c =~ a:pat) ? '' : c
" endfunc

""" pymode extracted
let g:pymode_motion = 0
let g:pymode_folding = 1

""" ctags
set tags+=~/Development/python/Python-2.7.9-src/Lib/python2corelib.tags " python core lib

""" code folding
" setlocal foldmethod=indent
setlocal foldlevel=99 " don't fold at all

" """ virtualenv
" " TODO use virtualenvwrapper instead
" python << EOF
" import os
" virtualenv = os.environ.get('VIRTUAL_ENV')
" if virtualenv:
"   activate_this = os.path.join(virtualenv, 'bin', 'activate_this.py')
"   if os.path.exists(activate_this):
"     exec(compile(open(activate_this).read(), activate_this, 'exec'), {'__file__': activate_this})
" EOF

""" jedi-vim
" let s:load_jedi_anyway = 1
" if exists("g:jedi_loaded") || s:load_jedi_anyway
"   let maplocalleader = ","
"   "" setting
"   let g:jedi#use_tabs_not_buffers = 0
"   setlocal noshowmode " g:jedi#show_call_signatures need this
"   let g:jedi#show_call_signatures = "2"
"   let g:jedi#popup_on_dot = 0
"   let g:jedi#completions_command = "" " use supertab
"   "" key mapping
"   let g:jedi#goto_command = "<C-]>"
"   let g:jedi#goto_assignments_command = "<localleader>G"
"   " let g:jedi#goto_definitions_command = "`g"
"   let g:jedi#goto_assignments_command = ",`"
"   let g:jedi#goto_definitions_command = ""
"   let g:jedi#documentation_command = "K"
"   let g:jedi#usages_command = "<localleader>u"
"   let g:jedi#completions_command = "<C-Space>"
"   let g:jedi#rename_command = "<localleader>r"
" endif

""" pydoc
let g:pydoc_cmd = "/usr/local/bin/python -m pydoc"

"""" the following is python3 specific
if !exists('g:python3')
  finish
endif

""" run
nnoremap <buffer> ! :!/usr/local/bin/python3 %<CR>

""" eval
nnoremap <buffer> <silent> <leader>e :.w !/usr/local/bin/python3<CR>
vnoremap <buffer> <silent> <leader>e :w !/usr/local/bin/python3<CR>
nnoremap <buffer> <silent> <leader>E :.!/usr/local/bin/python3<CR>
vnoremap <buffer> <silent> <leader>E :!/usr/local/bin/python3<CR>

""" airline
"" disable trailing whitespace because syntastic flake8 check this too
let g:airline#extensions#whitespace#enabled = 0

""" syntastic
let g:syntastic_python_python_exec = '/usr/local/bin/python3'

""" pydoc
let g:pydoc_cmd = "/usr/local/bin/python3 -m pydoc"
