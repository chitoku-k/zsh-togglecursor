#!/usr/bin/env zsh

autoload -U is-at-least
autoload -U add-zle-hook-widget

_zsh_togglecursor() {
    local ret=$?
    _zsh_togglecursor_supported || return $ret

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

_zsh_togglecursor_supported() {
    [[ $TERM_PROGRAM =~ 'iTerm\.app|Apple_Terminal' ]] || [[ $VTE_VERSION -ge 3900 ]]
}

_zsh_togglecursor_apply_cursor() {
    local format='%b'
    [[ -n $TMUX ]] && format="\ePtmux;\e%b\e\\"

    case $1 in
        'block')
            printf $format "\e[0 q"
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
    add-zle-hook-widget zle-line-finish _zsh_togglecursor
    add-zle-hook-widget zle-keymap-select _zsh_togglecursor
else
    print -r -- >&2 'zsh-togglecursor: add-zle-hook-widget is not supported on this version of zsh.'
fi
