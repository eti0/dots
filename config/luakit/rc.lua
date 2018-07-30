--		                __
--		   __________  / /_  ______ _
--		  / ___/ ___/ / / / / / __ `/
--		 / /  / /___ / / /_/ / /_/ /
--		/_/   \___(_)_/\__,_/\__,_/
--


require "lfs"


-- check for lua configuration files that will never be loaded because they are shadowed by builtin modules.
table.insert(package.loaders, 2, function (modname)
    if not package.searchpath then return end
    local f = package.searchpath(modname, package.path)
    if not f or f:find(luakit.install_paths.install_dir .. "/", 0, true) ~= 1 then
        return
    end
    local lf = luakit.config_dir .. "/" .. modname:gsub("%.","/") .. ".lua"
    if f == lf then
        msg.warn("Loading local version of '" .. modname .. "' module: " .. lf)
    elseif lfs.attributes(lf) then
        msg.warn("Found local version " .. lf
            .. " for core module '" .. modname
            .. "', but it won't be used, unless you update 'package.path' accordingly.")
    end
end)

require "unique_instance"


-- set the number of web processes to use. a value of 0 means 'no limit'.
luakit.process_limit = 0


-- set the cookie storage location
soup.cookies_storage = luakit.data_dir .. "/cookies.db"


-- load library of useful functions for luakit
local lousy = require "lousy"


-- load users theme
lousy.theme.init(lousy.util.find_config("theme.lua"))
assert(lousy.theme.get(), "failed to load theme")


-- load users window class
local window = require "window"


-- load users webview class
local webview = require "webview"


-- add luakit;//log/ chrome page
local log_chrome = require "log_chrome"


-- load luakit binds and modes
local modes = require "modes"
local binds = require "binds"


-- load luakit settings
local settings = require "settings"
require "settings_chrome"


-- window.lua overwrites (margins, etc.)
window.add_signal("build", function (w)
    local widgets, l, r = require "lousy.widget", w.sbar.l, w.sbar.r

    -- Left-aligned status bar widgets
    l.layout:pack(widgets.uri())
    l.layout:pack(widgets.hist())
    l.layout:pack(widgets.progress())

    -- Right-aligned status bar widgets
    r.layout:pack(widgets.buf())
    r.layout:pack(log_chrome.widget())
    r.layout:pack(widgets.ssl())
    r.layout:pack(widgets.tabi())
    r.layout:pack(widgets.scroll())

	-- margins
    w.sbar.layout.margin = 13
    
    w.ibar.layout.margin_top = 4
    w.ibar.layout.margin_bottom = 5
    w.ibar.layout.margin_left = 10

    w.mbar.label.margin = 10
end)



----------------------------------
-- optional user script loading --
----------------------------------

-- add adblock
local adblock = require "adblock"
local adblock_chrome = require "adblock_chrome"


-- add inspector
local webinspector = require "webinspector"


-- add uzbl-like form filling
local formfiller = require "formfiller"


-- add proxy support & manager
local proxy = require "proxy"


-- add session saving/loading support
local session = require "session"


-- add command to list closed tabs & bind to open closed tabs
local undoclose = require "undoclose"


-- add command to list tab history items
local tabhistory = require "tabhistory"


-- add greasemonkey-like javascript userscript support
local userscripts = require "userscripts"


-- add bookmarks support
local bookmarks = require "bookmarks"
local bookmarks_chrome = require "bookmarks_chrome"


-- add download support
local downloads = require "downloads"
local downloads_chrome = require "downloads_chrome"


-- add automatic PDF downloading and opening
local viewpdf = require "viewpdf"


-- example using xdg-open for opening downloads / showing download folders
downloads.add_signal("open-file", function (file)
    luakit.spawn(string.format("xdg-open %q", file))
    return true
end)


-- add vimperator-like link hinting & following
local follow = require "follow"


-- add command history
local cmdhist = require "cmdhist"


-- add search mode & binds
local search = require "search"


-- add ordering of new tabs
local taborder = require "taborder"


-- save web history
local history = require "history"
local history_chrome = require "history_chrome"


-- add help & binds
local help_chrome = require "help_chrome"
local binds_chrome = require "binds_chrome"


-- add command completion
local completion = require "completion"


local follow_selected = require "follow_selected"
local go_input = require "go_input"
local go_next_prev = require "go_next_prev"
local go_up = require "go_up"


-- filter referer HTTP header if page domain does not match Referer domain
require_web_module("referer_control_wm")


local error_page = require "error_page"


-- add userstyles loader
local styles = require "styles"


-- hide scrollbars on all pages
local hide_scrollbars = require "hide_scrollbars"


-- add a stylesheet when showing images
local image_css = require "image_css"


-- add a new tab page
local newtab_chrome = require "newtab_chrome"


-- add :view-source command
local view_source = require "view_source"


-- put "userconf.lua" in your luakit config dir with your own tweaks; if this is permanent, no need to copy/paste/modify the default rc.lua whenever you update luakit.
if pcall(function () lousy.util.find_config("userconf.lua") end) then
    require "userconf"
end

-----------------------------
-- end user script loading --
-----------------------------



-- unbind middle mouse
-- modes.remove_binds("all", { "<Mouse2>" })


-- restore last saved session
local w = (not luakit.nounique) and (session and session.restore())
if w then
    for i, uri in ipairs(uris) do
        w:new_tab(uri, { switch = i == 1 })
    end
else
    -- or open new window
    window.new(uris)
end

-- vim: et:sw=4:ts=8:sts=4:tw=80
