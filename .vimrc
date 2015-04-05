set nocompatible

set encoding=utf8
set termencoding=utf8

source ~/.vim-bundle

" Set the <leader> key to ,
let mapleader=","

" Used in order to maintain the line ending style at the end of files
set binary

" For new files, make sure there's no EOL at the end of the file
au BufNewFile * set noeol

" Syntax
au BufNewFile,BufRead *.twig set filetype=html
au BufNewFile,BufRead Vagrantfile set filetype=ruby
au BufNewFile,BufRead .vim-bundle set filetype=vim

" Use 2 spaces in puppet, ruby and xml files
autocmd FileType puppet,xml,ruby set shiftwidth=2 tabstop=2 softtabstop=2 expandtab

" Ensure the colours are always reported as 256
if (&term =~ "-256color")
    set t_Co=256
endif

" Lines above/below cursor
set scrolloff=4
" Default is 4 spaces to a tab
set tabstop=4
set shiftwidth=4
set expandtab

set nofoldenable

" Always show a status bar
set laststatus=2

" Set fancy symbols for airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline_theme = 'powerlineish'

" neocomplcache settings {
    let g:acp_enableAtStartup = 0
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_camel_case_completion = 1
    let g:neocomplcache_enable_smart_case = 1
    let g:neocomplcache_enable_underbar_completion = 1
    let g:neocomplcache_enable_auto_delimiter = 1
    let g:neocomplcache_max_list = 15
    let g:neocomplcache_force_overwrite_completefunc = 1

    " Define dictionary.
    let g:neocomplcache_dictionary_filetype_lists = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

    " Define keyword.
    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

    " Allow omnicompletion
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

    " Enable heavy omni completion.
    if !exists('g:neocomplcache_omni_patterns')
      let g:neocomplcache_omni_patterns = {}
    endif
    let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

    imap <silent><expr><C-k> neosnippet#expandable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
                \ "\<C-e>" : "\<Plug>(neosnippet_expand_or_jump)")
    smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

    inoremap <expr><C-g> neocomplcache#undo_completion()
    inoremap <expr><C-l> neocomplcache#complete_common_string()

    function! CleverCr()
        if pumvisible()
            if neosnippet#expandable()
                let exp = "\<Plug>(neosnippet_expand)"
                return exp . neocomplcache#close_popup()
            else
                return neocomplcache#close_popup()
            endif
        else
            return "\<CR>"
        endif
    endfunction

    " <CR> close popup and save indent or expand snippet
    imap <expr> <CR> CleverCr()

    " <CR>: close popup
    " <s-CR>: close popup and save indent.
    inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup()"\<CR>" : "\<CR>"

    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y> neocomplcache#close_popup()

     " <TAB>: completion.
    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
" } neocomplcache

" Highlight lines over 100 characters in PHP files
autocmd FileType php let w:m1=matchadd('ErrorMsg', '\%>100v.\+', -1)

if &t_Co > 2 || has("gui_running")
   " switch syntax highlighting on, when the terminal has colors
   syntax on
endif

" nginx config syntax highlighting
au BufRead,BufNewFile /etc/nginx/**/* set ft=nginx

set background=dark
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

" CtrlP {
    " keymaps
    let g:ctrlp_map = '<C-i>'

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

" Toggle paste mode
nmap <silent> <Leader>p :set invpaste<CR>:set paste?<CR>

" Toggle NERDTree
nmap <Leader>e :NERDTreeToggle<CR>

nmap <F8> :TagbarToggle<CR>
