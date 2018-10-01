function arte
    # vars
    set quality "best"

    # exec
    streamlink "https://www.arte.tv/fr/direct/" "$quality"
end