" --- ALE -------------------------------------------------------------
let b:ale_linters = ['eslint']
let b:ale_echo_msg_format = '[%linter%] %code%: %s [%severity%]'
let b:ale_fixers = ['prettier']
let b:ale_fix_on_save = 1
let b:ale_javascript_prettier_options = '--single-quote --trailing-comma es5'
