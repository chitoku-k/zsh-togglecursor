#!/usr/bin/env zsh

autoload -U is-at-least
autoload -U add-zle-hook-widget

_zsh_togglecursor() {
    local ret=$?

    case $KEYMAP in
        'main')
            _zsh_togglecursor_apply_cursor 'line'
            ;;
        *)
            _zsh_togglecursor_apply_cursor 'block'
            ;;
    esac
    return $ret
}

_zsh_togglecursor_reset() {
    _zsh_togglecursor_apply_cursor 'block'
}

_zsh_togglecursor_supported() {
    [[ $TERM_PROGRAM =~ tmux\|iTerm\.app\|Apple_Terminal ]] ||
        [[ -n $WT_SESSION ]] ||
        [[ $VTE_VERSION -ge 3900 ]] ||
        [[ $TERMINAL_EMULATOR = 'JetBrains-JediTerm' ]]
}

_zsh_togglecursor_apply_cursor() {
    _zsh_togglecursor_supported || return $ret

    local format='%b'

    case "$1" in
        'block')
            printf $format "\e[1 q"
            ;;
        'underline')
            printf $format "\e[3 q"
            ;;
        'line')
            printf $format "\e[5 q"
            ;;
    esac
}

if is-at-least 5.3; then
    add-zle-hook-widget zle-line-init _zsh_togglecursor
    add-zle-hook-widget zle-line-finish _zsh_togglecursor_reset
    add-zle-hook-widget zle-keymap-select _zsh_togglecursor
else
    print -r -- >&2 'zsh-togglecursor: add-zle-hook-widget is not supported on this version of zsh.'
fi
