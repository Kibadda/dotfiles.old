-- Xmobar (http://projects.haskell.org/xmobar/)
-- This is one of the xmobar configurations for DTOS.
-- This config is packaged in the DTOS repo as 'dtos-xmobar'
-- Color scheme: Gruvbox Dark
-- Dependencies: 
   -- otf-font-awesome 
   -- ttf-mononoki 
   -- ttf-ubuntu-font-family
   -- htop
   -- emacs
   -- pacman (Arch Linux)
   -- trayer
   -- 'dtos-local-bin' (from dtos-core-repo)

Config { font            = "xft:JetBrainsMono Nerd Font:weight=bold:pixelsize=12:antialias=true:hinting=true"
       , additionalFonts = [ "xft:Mononoki:pixelsize=11:antialias=true:hinting=true"
                           , "xft:Font Awesome 6 Free Solid:pixelsize=12"
                           , "xft:Font Awesome 6 Brands:pixelsize=12"
                           ]
       , bgColor      = "#282828"
       , fgColor      = "#ebdbb2"
       -- Position TopSize and BottomSize take 3 arguments:
       --   an alignment parameter (L/R/C) for Left, Right or Center.
       --   an integer for the percentage width, so 100 would be 100%.
       --   an integer for the minimum pixel height for xmobar, so 24 would force a height of at least 24 pixels.
       --   NOTE: The height should be the same as the trayer (system tray) height.
       , position       = TopSize L 100 24
       , lowerOnStart = True
       , hideOnStart  = False
       , allDesktops  = True
       , persistent   = True
       , commands = [
                        -- Cpu usage in percent
                      Run Cpu ["-t", "<fn=2>\xf108</fn>  cpu: (<total>%)","-H","50","--high","red"] 20
                        -- Ram used number and percent
                    , Run Memory ["-t", "<fn=2>\xf233</fn>  mem: <used>M (<usedratio>%)"] 20
                        -- Echos a "bell" icon in front of the pacman updates.
                    , Run Com "echo" ["<fn=2>\xf0f3</fn>"] "bell" 3600
                        -- Check for pacman updates (script found in .local/bin)
                    , Run Com ".local/bin/pacupdate" [] "pacupdate" 36000
                        -- Echos a "battery" icon in front of the pacman updates.
                    , Run Com "echo" ["<fn=2>\xf242</fn>"] "baticon" 3600
                        -- Battery
                    , Run BatteryP ["BAT0"] ["-t", "<acstatus><watts> (<left>%)"] 360
                        -- Time and date
                    , Run Date "<fn=2>\xf017</fn>  %d.%m.%Y - (%H:%M) " "date" 50
                        -- Script that dynamically adjusts xmobar padding depending on number of trayer icons.
                    , Run Com ".local/bin/trayer-padding" [] "trayerpad" 20
                        -- Prints out the left side items such as workspaces, layout, etc.
                    , Run UnsafeStdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " %UnsafeStdinReader% }{ <box type=Bottom width=2 mb=2 color=#b8bb26><fc=#b8bb26><action=`kitty htop`>%cpu%</action></fc></box>    <box type=Bottom width=2 mb=2 color=#458588><fc=#458588><action=`kitty htop`>%memory%</action></fc></box>    <box type=Bottom width=2 mb=2 color=#689d6a><fc=#689d6a>%bell%  <action=`kitty sudo pacman -Syu`>%pacupdate%</action></fc></box>   <box type=Bottom width=2 mb=2 color=#fb4934><fc=#fb4934>%baticon%  %battery%</fc></box>    <box type=Bottom width=2 mb=2 color=#83a598><fc=#83a598>%date%</fc></box> %trayerpad%"
       }
