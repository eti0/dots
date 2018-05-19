function fish_prompt
    set -l last_status $status

    set -l red (set_color red)
    set -l normal (set_color normal)

    set -l cwd $normal(basename (pwd | sed "s:^$HOME:%%:"))

    printf $cwd$normal

    if test $last_status = 0
        set prompt_color $normal
    else
        set prompt_color $red
    end

    printf "$prompt_color ; $normal"
end