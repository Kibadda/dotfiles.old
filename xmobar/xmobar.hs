import Data.List (intercalate)
import Xmobar

type Extension = (Runnable, String)

separator :: String
separator = "  "

alignSeparator :: String
alignSeparator = "}{"

leftSide :: [Extension]
leftSide =
  [ ( Run UnsafeStdinReader,
      " %UnsafeStdinReader% "
    )
  ]

rightSide :: [Extension]
rightSide =
  [ ( Run Locks,
      "<box type=Bottom width=2 mb=2 color=#3434e0><fc=#3434e0><fn=2>\xf023</fn> %locks%</fc></box>"
    ),
    ( Run $ Cpu ["-t", "<fn=2>\xf108</fn> cpu: <total>%", "-H", "50", "--high", "red"] 20,
      "<box type=Bottom width=2 mb=2 color=#b8bb26><fc=#b8bb26><action=`kitty htop`>%cpu%</action></fc></box>"
    ),
    ( Run $ Memory ["-t", "<fn=2>\xf233</fn> mem: <used>M <usedratio>%"] 20,
      "<box type=Bottom width=2 mb=2 color=#458588><fc=#458588><action=`kitty htop`>%memory%</action></fc></box>"
    ),
    ( Run $ DynNetwork ["-t", "<fn=2>\xf1eb</fn> <dev>: <tx>|<rx>"] 10,
      "<box type=Bottom width=2 mb=2 color=#e03434><fc=#e03434>%dynnetwork%</fc></box>"
    ),
    ( Run $ Com ".local/bin/pacupdate" [] "pacupdate" 36000,
      "<box type=Bottom width=2 mb=2 color=#689d6a><fc=#689d6a><action=`kitty sudo pacman -Syu`>%pacupdate%</action></fc></box>"
    ),
    ( Run $ BatteryP ["BAT0"] ["-t", "<fn=2>\xf242</fn> <acstatus> <left>%"] 600,
      "<box type=Bottom width=2 mb=2 color=#fb4934><fc=#fb4934>%battery%</fc></box>"
    ),
    ( Run $ Alsa "default" "Master" ["-t", "<fn=2>\xf028</fn> <volumestatus>%"],
      "<box type=Bottom width=2 mb=2 color=#1cfc03><fc=#1cfc03><action=`pavucontrol`>%alsa:default:Master%</action></fc></box>"
    ),
    ( Run $ Date "<fn=2>\xf017</fn> %d.%m.%Y - %H:%M:%S" "date" 10,
      "<box type=Bottom width=2 mb=2 color=#83a598><fc=#83a598><action=`xdg-open https://calendar.google.com`>%date%</action></fc></box>"
    ),
    ( Run $ Com ".local/bin/trayer-padding" [] "trayerpad" 20,
      "%trayerpad%"
    )
  ]

myTemplate :: String
myTemplate = intercalate separator (map snd leftSide) ++ alignSeparator ++ intercalate separator (map snd rightSide)

myCommands :: [Runnable]
myCommands = map fst leftSide ++ map fst rightSide

myFont :: String
myFont = "xft:JetBrainsMono Nerd Font:weight=bold:pixelsize=12:antialias=true:hinting=true"

myAdditionalFonts :: [String]
myAdditionalFonts =
  [ "xft:Mononoki:pixelsize=11:antialias=true:hinting=true",
    "xft:Font Awesome 6 Free Solid:pixelsize=12",
    "xft:Font Awesome 6 Brands:pixelsize=12"
  ]

config :: Config
config =
  defaultConfig
    { font = myFont,
      additionalFonts = myAdditionalFonts,
      bgColor = "#282828",
      fgColor = "#ebdbb2",
      position = TopSize L 100 24,
      lowerOnStart = True,
      hideOnStart = False,
      allDesktops = True,
      persistent = True,
      commands = myCommands,
      sepChar = "%",
      alignSep = alignSeparator,
      template = myTemplate
    }

main :: IO ()
main = xmobar config
