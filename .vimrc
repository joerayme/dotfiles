set nocompatible

set encoding=utf8
set termencoding=utf8

source ~/.vim-bundle

" Set the <leader> key to ,
let mapleader=","

" Used in order to maintain the line ending style at the end of files
set binary

" Search incrementally and highlight
set hlsearch incsearch

" For new files, make sure there's no EOL at the end of the file
au BufNewFile * set noeol

" Set mouse integration
set mouse=a
set ttymouse=xterm2

" When writing git commits, back them up in case GPG bombs out
au BufWritePost COMMIT_EDITMSG write! ~/.GIT_COMMITMSG.bak

" Syntax
au BufNewFile,BufRead *.twig set filetype=html
au BufNewFile,BufRead Vagrantfile set filetype=ruby
au BufNewFile,BufRead .vim-bundle set filetype=vim
au BufNewFile,BufRead riemann.config set filetype=clojure
au BufNewFile,BufRead *.tfstate set filetype=json
au BufNewFile,BufRead **/etc/nginx/**/* set ft=nginx

" Use 2 spaces in puppet and ruby files
autocmd FileType puppet,ruby set shiftwidth=2 tabstop=2 softtabstop=2 expandtab

" Ensure the colours are always reported as 256
set t_Co=256

" Lines above/below cursor
set scrolloff=4
" Default is 4 spaces to a tab
set tabstop=4
set shiftwidth=4
set expandtab

set nofoldenable

" Always show a status bar
set laststatus=2

" Allow backspace to work over autoindent, line breaks and the start of insert
set backspace=indent,eol,start

" Set airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
let g:airline_theme = 'powerlineish'

" deoplete settings {
    " Disable AutoComplPop
    let g:acp_enableAtStartup = 0
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_smart_case = 1
    let g:deoplete#enable_auto_delimiter = 1
    let g:deoplete#max_list = 15
    let g:deoplete#force_overwrite_completefunc = 1
    " Set minimum syntax keyword length.
    let g:deoplete#sources#syntax#min_keyword_length = 3

    " Define dictionary.
    let g:deoplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

    " Define keyword.
    if !exists('g:deoplete#keyword_patterns')
        let g:deoplete#keyword_patterns = {}
    endif
    let g:deoplete#keyword_patterns['default'] = '\h\w*'

    " Allow omnicompletion
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown,mkd setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

    " Enable heavy omni completion.
    if !exists('g:deoplete#sources#omni#input_patterns')
      let g:deoplete#sources#omni#input_patterns = {}
    endif
    let g:deoplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

    inoremap <expr><C-g> deoplete#undo_completion()
    inoremap <expr><C-l> deoplete#complete_common_string()

    function! CleverCr()
        if pumvisible()
            return deoplete#close_popup()
        else
            return "\<CR>"
        endif
    endfunction

    " <CR> close popup and save indent or expand snippet
    imap <expr> <CR> CleverCr()

    " <CR>: close popup
    " <s-CR>: close popup and save indent.
    inoremap <expr><s-CR> pumvisible() ? deoplete#close_popup()"\<CR>" : "\<CR>"

    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y> deoplete#close_popup()

     " <TAB>: completion.
    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
" } deoplete

" ultisnips {
    let g:UltiSnipsEditSplit="vertical"
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
    let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips', $HOME.'/.vim/plugged/vim-snippets/UltiSnips']
" } ultisnips

" Highlight lines over 100 characters in PHP files
autocmd FileType php let w:m1=matchadd('ErrorMsg', '\%>100v.\+', -1)

if &t_Co > 2 || has("gui_running")
   " switch syntax highlighting on, when the terminal has colors
   syntax on
endif

set background=dark
if &t_Co >= 256 || has("gui_running")
   colorscheme solarized
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

" CtrlP {
    " keymaps
    " let g:ctrlp_map = '<TAB>'

    " Search for files from the current path as well as ancestors in version
    " control
    let g:ctrlp_working_path_mode = 'ra'

    " exclude certain files
    let g:ctrlp_custom_ignore = {
        \ 'dir': '\.git$\|\.hg$\|\.svn$',
        \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

    " Set find and fallback commands
    if executable('ag')
        let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
    elseif executable('ack')
        let s:ctrlp_fallback = 'ack %s --nocolor -f'
    else
        let s:ctrlp_fallback = 'find %s -type f'
    endif

    let g:ctrlp_user_command = {
        \ 'types': {
            \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
            \ 2: ['.hg', 'hg --cwd %s locate -I .'],
        \ },
        \ 'fallback': s:ctrlp_fallback
    \ }
" }

" tabularize {
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a$ :Tabularize /\$<CR>
    vmap <Leader>a$ :Tabularize /\$<CR>
" }

" Set up xterm keys in screen terms
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

"Quicker pane navigation (using Shift+arrow keys, courtesy of oholiab)
nmap <silent> <S-Up> :wincmd k<CR>
nmap <silent> <S-Down> :wincmd j<CR>
nmap <silent> <S-Left> :wincmd h<CR>
nmap <silent> <S-Right> :wincmd l<CR>

" Quick resizing
nnoremap <silent> <Leader>+ :resize +5<CR>
nnoremap <silent> <Leader>- :resize -5<CR>
nnoremap <silent> <Leader>] :vertical resize +5<CR>
nnoremap <silent> <Leader>[ :vertical resize -5<CR>

" Toggle GitGutter
nmap <silent> <Leader>g :GitGutterToggle<CR>

" Toggle paste mode
nmap <silent> <Leader>p :set invpaste<CR>:set paste?<CR>

" Toggle line numbers
nmap <silent> <Leader>n :set invnumber<CR>

" Toggle NERDTree
nmap <Leader>e :NERDTreeToggle<CR>
nmap <Leader>f :NERDTreeFind<CR>

" Expand/contract selection from character to word etc.
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Edit UltiSnips
nnoremap <leader>sn :UltiSnipsEdit<cr>

nmap <F8> :TagbarToggle<CR>
