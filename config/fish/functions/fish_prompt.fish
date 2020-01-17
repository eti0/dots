function fish_prompt
    set -l last_status "$status"

    set -l red (set_color "red")
    set -l normal (set_color "normal")
    set -l brblack (set_color "brblack")

    set -l cwd (basename (pwd | sed "s:^$HOME:घर:"))

    if test "$last_status" = "0"
        set prompt_color "$brblack"
    else
        set prompt_color "$red"
    end

    printf "$brblack($normal$cwd$normal$brblack)$normal $prompt_color%%$normal "
end