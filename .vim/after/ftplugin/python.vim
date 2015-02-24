set tabstop=4
set shiftwidth=4
set expandtab

let g:pymode_rope_regenerate_on_write = 0

" Ignore line length warnings
let g:pymode_lint_ignore = "E501"

let g:pymode_options_max_line_length = 120

" Ignore pyc files in NERDTree
let NERDTreeIgnore = ['\.pyc$']
