setlocal foldmethod=syntax

" --- ALE -------------------------------------------------------------
let b:ale_linters = ['solhint']
let b:ale_echo_msg_format = '[%linter%] %code%: %s [%severity%]'
