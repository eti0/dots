-- mpv
local luakit = require "luakit"
local add_binds = require("modes").add_binds

local _M = {}

--- Open a URI in mpv.
-- @tparam string url The URI to play.
function _M.play(url)
    local cmd = string.format("%s -g 100x18 -e mpv \'%s\'", "urxvt", url)
    msg.info("Running %s", cmd)
    luakit.spawn(cmd)
end

add_binds("normal", {
    { ",p", "Play in mpv.", function (w)
            _M.play(w.view.hovered_uri or w.view.uri)
        end },
})

return _M

-- vim: et:sw=4:ts=8:sts=4:tw=80