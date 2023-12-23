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

" Use spelling in markdown files
autocmd FileType markdown set spell spelllang=en_gb

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

" Disable concealing of double quotes
let g:vim_json_syntax_conceal = 0

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

" coc setup {
    " Some servers have issues with backup files, see #649
    set nobackup
    set nowritebackup

    " Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
    " delays and poor user experience
    set updatetime=300

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved
    set signcolumn=yes

    " Use tab for trigger completion with characters ahead and navigate
    " NOTE: There's always complete item selected by default, you may want to enable
    " no select by `"suggest.noselect": true` in your configuration file
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config
    inoremap <silent><expr> <TAB>
          \ coc#pum#visible() ? coc#pum#next(1) :
          \ CheckBackspace() ? "\<Tab>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

    " Make <CR> to accept selected completion item or notify coc.nvim to format
    " <C-g>u breaks current undo, please make your own choice
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    function! CheckBackspace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion
    if has('nvim')
      inoremap <silent><expr> <c-space> coc#refresh()
    else
      inoremap <silent><expr> <c-@> coc#refresh()
    endif

    " GoTo code navigation
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window
    nnoremap <silent> K :call ShowDocumentation()<CR>

    function! ShowDocumentation()
      if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
      else
        call feedkeys('K', 'in')
      endif
    endfunction

    " Symbol renaming
    nmap <leader>rn <Plug>(coc-rename)
" } coc

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
