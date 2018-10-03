" 1) Execute:
" ln -s ~/wc/technotes/editors/vim.vimrc ~/.vimrc

" Handle arrow keys as arrow keys in edit mode
set nocompatible
" Support backspace as backspace
set backspace=2

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

