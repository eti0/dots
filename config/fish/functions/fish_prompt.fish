function fish_prompt
    set -l last_status $status

    set -l cyan (set_color cyan)
    set -l yellow (set_color yellow)
    set -l red (set_color red)
    set -l blue (set_color blue)
    set -l green (set_color green)
    set -l brgreen (set_color brgreen)
    set -l white (set_color white)
    set -l brwhite (set_color brwhite)
    set -l normal (set_color normal)

    set -l cwd $normal(basename (pwd | sed "s:^$HOME:~:"))

    # Print pwd or full path
    echo -n -s $cwd $normal

    set -l prompt_color $brgreen
    if test $last_status = 0
        set prompt_color $brwhite
    end

    # Terminate with a nice prompt char
    echo -e -n -s $prompt_color ' - ' $normal
end
