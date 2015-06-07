" @see [全角和半角 - wikipedia](http://zh.wikipedia.org/wiki/%E5%85%A8%E5%BD%A2%E5%92%8C%E5%8D%8A%E5%BD%A2)
" @see [中文文案排版指北](https://github.com/sparanoid/chinese-copywriting-guidelines)

if exists("load_pangu_space")
  finish
endif
let load_pangu_space=1

let g:pangu_enabled=1


" Default Options: {{{

function! s:set_default(name, value)
  if !exists(a:name)
    execute "let " . a:name . " = " . string(a:value)
  endif
endfunction

call s:set_default('g:pangu_full_ending_punct',      1)
call s:set_default('g:pangu_full_surrounding_punct', 1)
call s:set_default('g:pangu_half_alpha',             1)
call s:set_default('g:pangu_half_digit',             1)
call s:set_default('g:pangu_half_non_cjk_punct',     1)
call s:set_default('g:pangu_squeeze_cjk_punct',      1)
call s:set_default('g:pangu_trim_spaces',            1)

" }}} Default Options


function! PanGuSpacingCore()
  let text = join(
        \   getline(1, '$'),
        \   "\n"
        \ )
  let text = pangu#spacing(text)
  call setline(1, split(text, '\n'))
endfunction


function! PanGuSpacing()
  if g:pangu_enabled == 1
    call PanGuSpacingCore()
  endif
endfunction

command! -nargs=0 Pangu call PanGuSpacingCore()
command! -nargs=0 PanguDisable let g:pangu_enabled=0
command! -nargs=0 PanguEnable let g:pangu_enabled=1
