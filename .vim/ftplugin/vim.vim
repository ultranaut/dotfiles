" --- ALE -------------------------------------------------------------
let b:ale_linters = []
let b:ale_echo_msg_format = '[%linter%] %code%: %s [%severity%]'
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']
let b:ale_fix_on_save = 1
