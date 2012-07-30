call pathogen#infect()

" Used in order to maintain the line ending style at the end of files
set binary

" For new files, make sure there's no EOL at the end of the file
au BufNewFile * set noeol

" Ensure the colours are always reported as 256
set t_Co=256

" Show line and column information
set ruler
set scrolloff=4
set tabstop=4
set shiftwidth=4
set expandtab
filetype plugin on
filetype indent on

" Allow autocompletion in PHP
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" Use hard tabs in Python files
autocmd FileType python set noexpandtab
" Use 2 spaces in puppet files
autocmd FileType puppet set shiftwidth=2 tabstop=2 softtabstop=2

" Highlight lines over 100 characters in PHP files
autocmd FileType php let w:m1=matchadd('ErrorMsg', '\%>100v.\+', -1)

if &t_Co > 2 || has("gui_running")
   " switch syntax highlighting on, when the terminal has colors
   syntax on
endif

if &t_Co >= 256 || has("gui_running")
   colorscheme mustang
endif

function! <SID>StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
nmap <silent> <Leader><space> :call <SID>StripTrailingWhitespace()<CR>

" PHPDoc enabler
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR>

let Grep_Xargs_Options = '-0'

" XML lint
nmap <Leader>l <Leader>cd:%w !xmllint --valid --noout -<CR>
