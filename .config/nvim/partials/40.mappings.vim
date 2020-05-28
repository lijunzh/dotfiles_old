" getting out of terminal mode
tnoremap <Esc> <C-\><C-n>
tnoremap <A-[> <Esc>

" terminal panel
noremap <A-t> :sp<CR>:resize 10<CR>:term<CR>

" resize
noremap <A-=> :resize +5<CR>
noremap <A--> :resize -5<CR>

" quick save
noremap <Leader>s :update<CR>
