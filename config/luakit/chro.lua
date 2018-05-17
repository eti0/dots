-- mpv
local luakit = require "luakit"
local add_binds = require("modes").add_binds

local _M = {}

--- open a URI in chromium.
function _M.play(url)
    local cmd = string.format("%s --app=\'%s\'", "chromium", url)
    msg.info("Running %s", cmd)
    luakit.spawn(cmd)
end

add_binds("normal", {
    { ",o", "open in chromium.", function (w)
            _M.play(w.view.hovered_uri or w.view.uri)
        end },
})

return _M

-- vim: et:sw=4:ts=8:sts=4:tw=80