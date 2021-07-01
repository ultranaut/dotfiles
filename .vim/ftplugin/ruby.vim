setlocal foldmethod=syntax

" --- ALE -------------------------------------------------------------
let b:ale_linters = ['rubocop']
let b:ale_echo_msg_format = '[%linter%] %code%: %s [%severity%]'
let b:ale_fixers = ['prettier', 'rubocop']
let b:ale_fix_on_save = 1
