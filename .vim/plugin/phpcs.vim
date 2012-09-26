function! RunPhpcs()
    let l:filename=@%
    let l:phpcs_output=system('phpcs --report=emacs --standard=Future '.l:filename)
    let l:phpcs_list=split(l:phpcs_output, "\n")
    unlet l:phpcs_list[0]
    cexpr l:phpcs_list
    copen
endfunction

set errorformat+="%f:%l:%c %m"
command! Phpcs execute RunPhpcs()