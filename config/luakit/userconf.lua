--		                                         ____   __
--		  __  __________  ______________  ____  / __/  / /_  ______ _
--		 / / / / ___/ _ \/ ___/ ___/ __ \/ __ \/ /_   / / / / / __ `/
--		/ /_/ (__  )  __/ /  / /__/ /_/ / / / / __/_ / / /_/ / /_/ /
--		\__,_/____/\___/_/   \___/\____/_/ /_/_/  (_)_/\__,_/\__,_/ 
--

-- load the mpv module
require "mpv"


-- load the chromium module
require "chro"


-- load library of useful functions for luakit (eg.: allow for tab margins)
local lousy = require "lousy"


-- tab margins
lousy.widget.tab.add_signal("build", function (w) w.widget.child.margin = 20 end)
