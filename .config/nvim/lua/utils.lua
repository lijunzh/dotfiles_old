-- hide line numbers , statusline in specific buffers!
vim.api.nvim_exec(
[[
    au TermOpen term://* setlocal nonumber  laststatus=0
    au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
]],
    false
)

-- hybrid line number
vim.api.nvim_exec([[
augroup hybrid_line_number
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END
]], false)


-- reload buffer when file changes on disk and warn user
vim.api.nvim_exec([[
augroup file_change
    autocmd!
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
    autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
augroup END
]], false)

-- remove tailing white space and empty line at the end of file
vim.api.nvim_exec([[
augroup auto_save_remove_white_space
    autocmd!
    autocmd BufWritePre * silent! s/\s\+$//e
    autocmd BufWritePre * silent! %s#\($\n\s*\)\+\%$##
augroup END
]], false)

-- search highlight only when search
vim.api.nvim_exec([[
augroup search_highlighting
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END
]], false)

-- 79 column line exceptions
vim.api.nvim_exec([[
augroup column_width
    autocmd!
    " no text wrap for text files
    autocmd Filetype tex,plaintex,markdown,text setlocal tw=0 wrap
    " 72 columns for git commit
    autocmd Filetype gitcommit setlocal spell textwidth=72
augroup END
]], false)

-- only highlight cursor line for current window
vim.api.nvim_exec([[
augroup cursor_line_current_window
    autocmd!
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END
]], false)
