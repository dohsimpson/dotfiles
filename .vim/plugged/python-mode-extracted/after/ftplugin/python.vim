" Python motion
if !exists("g:pymode_motion") || g:pymode_motion == 1
  if !&magic
    call pymode#error("Pymode motion requires `&magic` option. Enable them or disable g:pymode_motion")
  endif

  nnoremap <buffer> ]]  :<C-U>call pymode#motion#move('<Bslash>v^(class<bar>def)<Bslash>s', '')<CR>
  nnoremap <buffer> [[  :<C-U>call pymode#motion#move('<Bslash>v^(class<bar>def)<Bslash>s', 'b')<CR>
  nnoremap <buffer> ]C  :<C-U>call pymode#motion#move('<Bslash>v^(class<bar>def)<Bslash>s', '')<CR>
  nnoremap <buffer> [C  :<C-U>call pymode#motion#move('<Bslash>v^(class<bar>def)<Bslash>s', 'b')<CR>
  nnoremap <buffer> ]M  :<C-U>call pymode#motion#move('^<Bslash>s*def<Bslash>s', '')<CR>
  nnoremap <buffer> [M  :<C-U>call pymode#motion#move('^<Bslash>s*def<Bslash>s', 'b')<CR>

  onoremap <buffer> ]]  :<C-U>call pymode#motion#move('<Bslash>v^(class<bar>def)<Bslash>s', '')<CR>
  onoremap <buffer> [[  :<C-U>call pymode#motion#move('<Bslash>v^(class<bar>def)<Bslash>s', 'b')<CR>
  onoremap <buffer> ]C  :<C-U>call pymode#motion#move('<Bslash>v^(class<bar>def)<Bslash>s', '')<CR>
  onoremap <buffer> [C  :<C-U>call pymode#motion#move('<Bslash>v^(class<bar>def)<Bslash>s', 'b')<CR>
  onoremap <buffer> ]M  :<C-U>call pymode#motion#move('^<Bslash>s*def<Bslash>s', '')<CR>
  onoremap <buffer> [M  :<C-U>call pymode#motion#move('^<Bslash>s*def<Bslash>s', 'b')<CR>

  vnoremap <buffer> ]]  :call pymode#motion#vmove('<Bslash>v^(class<bar>def)<Bslash>s', '')<CR>
  vnoremap <buffer> [[  :call pymode#motion#vmove('<Bslash>v^(class<bar>def)<Bslash>s', 'b')<CR>
  vnoremap <buffer> ]M  :call pymode#motion#vmove('^<Bslash>s*def<Bslash>s', '')<CR>
  vnoremap <buffer> [M  :call pymode#motion#vmove('^<Bslash>s*def<Bslash>s', 'b')<CR>

  onoremap <buffer> C  :<C-U>call pymode#motion#select('^<Bslash>s*class<Bslash>s', 0)<CR>
  onoremap <buffer> aC :<C-U>call pymode#motion#select('^<Bslash>s*class<Bslash>s', 0)<CR>
  onoremap <buffer> iC :<C-U>call pymode#motion#select('^<Bslash>s*class<Bslash>s', 1)<CR>
  vnoremap <buffer> aC :<C-U>call pymode#motion#select('^<Bslash>s*class<Bslash>s', 0)<CR>
  vnoremap <buffer> iC :<C-U>call pymode#motion#select('^<Bslash>s*class<Bslash>s', 1)<CR>

  onoremap <buffer> M  :<C-U>call pymode#motion#select('^<Bslash>s*def<Bslash>s', 0)<CR>
  onoremap <buffer> aM :<C-U>call pymode#motion#select('^<Bslash>s*def<Bslash>s', 0)<CR>
  onoremap <buffer> iM :<C-U>call pymode#motion#select('^<Bslash>s*def<Bslash>s', 1)<CR>
  vnoremap <buffer> aM :<C-U>call pymode#motion#select('^<Bslash>s*def<Bslash>s', 0)<CR>
  vnoremap <buffer> iM :<C-U>call pymode#motion#select('^<Bslash>s*def<Bslash>s', 1)<CR>

  let g:pymode_motion = 1
endif

" Python folding
if !exists("g:pymode_folding") || g:pymode_folding == 1
  setlocal foldmethod=expr
  setlocal foldexpr=pymode#folding#expr(v:lnum)
  setlocal foldtext=pymode#folding#text()

  let g:pymode_folding = 1
endif
