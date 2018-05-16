--------------------------
-- yet another luakit theme --
--------------------------

local theme = {}

-- default settings
theme.font = "cure"
theme.fg   = "#fff"
theme.bg   = "#071d22"

-- genaral colours
theme.success_fg = "#94dba0"
theme.loaded_fg  = "#80bcd6"
theme.error_fg = "#fff"
theme.error_bg = "#eb7070"

-- warning colours
theme.warning_fg = "#eb7070"
theme.warning_bg = "#fff"

-- notification colours
theme.notif_fg = "#fff"
theme.notif_bg = "#071d22"

-- menu colours
theme.menu_fg                   = "#fff"
theme.menu_bg                   = "#071d22"
theme.menu_selected_fg          = "#5389d5"
theme.menu_selected_bg          = "#071d22"
theme.menu_title_bg             = "#071d22"
theme.menu_primary_title_fg     = "#e6e6e6"
theme.menu_secondary_title_fg   = "#e6e6e6"

theme.menu_disabled_fg = "#365359"
theme.menu_disabled_bg = theme.menu_bg
theme.menu_enabled_fg = theme.menu_fg
theme.menu_enabled_bg = theme.menu_bg
theme.menu_active_fg = "#5389d5"
theme.menu_active_bg = theme.menu_bg

-- proxy manager
theme.proxy_active_menu_fg      = '#071d22'
theme.proxy_active_menu_bg      = '#fff'
theme.proxy_inactive_menu_fg    = '#888'
theme.proxy_inactive_menu_bg    = '#fff'

-- statusbar specific
theme.sbar_fg         = "#fff"
theme.sbar_bg         = "#071d22"

-- downloadbar specific
theme.dbar_fg         = "#fff"
theme.dbar_bg         = "#071d22"
theme.dbar_error_fg   = "#eb7070"

-- input bar specific
theme.ibar_fg           = "#fff"
theme.ibar_bg           = "#071d22"

-- tab label
theme.tab_fg            = "#071d22"
theme.tab_bg            = "#fff"
theme.tab_hover_bg      = "#fff"
theme.tab_hover_fg      = "#071d22"
theme.tab_ntheme        = "#fff"
theme.selected_fg       = "#818cee"
theme.selected_bg       = "#fff"
theme.selected_ntheme   = "#fff"
theme.loading_fg        = "#fff"
theme.loading_bg        = "#071d22"

theme.selected_private_tab_bg = "#818cee"
theme.private_tab_bg    = "#606eeb"

-- trusted/untrusted ssl colours
theme.trust_fg          = "#99cd8e"
theme.notrust_fg        = "#e69494"

-- general colour pairings
theme.ok = { fg = "#071d22", bg = "#fff" }
theme.warn = { fg = "#eb7070", bg = "#fff" }
theme.error = { fg = "#fff", bg = "#eb7070" }

-- remove tab numbers
require('lousy.widget.tab').label_format = '{title}'

return theme

-- vim: et:sw=4:ts=8:sts=4:tw=80
