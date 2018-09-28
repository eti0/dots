function chopnscrew
    set tempo "0.5"
    set pitch "-1200"

    set filename (echo $argv[1] | sed "s/\..*//")

    set extension (echo $argv[1] | sed "s/.*\.//")

    sox --show-progress $argv[1] $filename.cns.$extension tempo $tempo pitch $pitch
end