command! Tidy %!tidy5 -q -i --show-errors 0
nnoremap <buffer> ! :w\|!osascript ~/Scripts/shell_utils/refresh_browser.scpt<CR>
" nnoremap <buffer> ! :!open -a FirefoxDeveloperEdition "%"<CR>
nnoremap <buffer> + :!open -a FirefoxDeveloperEdition "%"<CR>
