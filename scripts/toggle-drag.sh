#!/usr/bin/env fish


# vars
set file $HOME/.config/openbox/rc.xml
set active "<mousebind button=\"A-Left\" action=\"Drag\">"
set inactive "<mousebind button=\"\" action=\"Drag\">"


# exec
cat $file | grep "$active"
if test $status -eq 0
	sed -i "s/$active/$inactive/" $file
	openbox --reconfigure
	notify-send "alt-drag off"
else
	sed -i "s/$inactive/$active/" $file
	openbox --reconfigure
	notify-send "alt-drag on"
end
