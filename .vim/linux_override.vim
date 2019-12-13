""" clipboard OSC52
vnoremap Y y:call SendViaOSC52(getreg('"'))<CR>
noremap <leader>p :Tput<CR>
