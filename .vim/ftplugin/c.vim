" """ cscope (vim native plugin)
" if has("cscope") && !exists("g:cscope_loaded")
"   let g:cscope_loaded = 1
"   set cscopeprg=/usr/local/bin/cscope
"   set cscopetagorder=0
"   set cscopequickfix=s-,c-,d-,i-,t-,e-
"   set cscopetag " void tag and use cstag instead for ctrl-] and ctrl-t
"   set nocscopeverbose
"   if filereadable("cscope.out")
"     cs add cscope.out
"   elseif $CSCOPE_DB != ""
"     cs add $CSCOPE_DB
"   endif
"   set cscopeverbose
"   "" mappings
"   command! -nargs=+ -complete=tag	Code cs find <args>
"   nnoremap <leader>c :cs find
" 	nnoremap <leader><leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
" 	nnoremap <leader><leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
" 	nnoremap <leader><leader>t :cs find t <C-R>=expand("<cword>")<CR><CR>
" 	nnoremap <leader><leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"   "" reverse the unintuitive called and calling
" 	nnoremap <leader><leader>d :cs find c <C-R>=expand("<cword>")<CR><CR>
" 	nnoremap <leader><leader>c :cs find d <C-R>=expand("<cword>")<CR><CR>
" endif
call RunCmdRegister("!./%<")
