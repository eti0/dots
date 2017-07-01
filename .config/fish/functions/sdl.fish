# simple function to download music to ~/Music without having to cd into it
#

# exec
function sdl
    set cdir (pwd)

    cd ~/Music/soundcloud

    scdl -l $argv

    cd $cdir
end