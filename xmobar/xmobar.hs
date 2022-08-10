import Data.List (intercalate)
import Xmobar

type Extension = (Runnable, String)

type Color = String
type Text = String
type Action = String
type Icon = String

myTerminal :: String
myTerminal = "kitty"

wrap :: String -> String -> String -> String
wrap _ _ "" = ""
wrap l r m = l <> m <> r

xmobarColor :: Color -> Color -> Text -> String
xmobarColor fg bg = wrap open "</fc>"
  where
    open :: String
    open = concat ["<fc=", fg, if null bg then "" else "," <> bg, ">"]

xmobarIcon :: Icon -> String
xmobarIcon = wrap "<fn=2>" "</fn>"

separator :: String
separator = wrap "<fn=1> " " </fn>" "|"

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
  [ ( Run $ DynNetwork
        [ "-t", "<dev>: <tx>|<rx>"
	] 10,
      xmobarColor "#E03434" "" $ xmobarIcon "\xf1eb" ++ " %dynnetwork%"
    ),
    ( Run Locks,
      xmobarColor "#3434E0" "" $ xmobarIcon "\xf023" ++ " %locks%"
    ),
    ( Run $ Com ".local/bin/pacupdate" [] "pacupdate" 3000,
      xmobarColor "#689D6A" "" $ xmobarIcon "\xf0f3" ++ " %pacupdate%"
    ),
    ( Run $ Cpu
        [ "-t", "<total>%",
	  "-H", "50",
	  "--high", "red",
	  "-p", "3"
	] 20,
      xmobarColor "#B8BB26" "" $ xmobarIcon "\xf108" ++ " %cpu%"
    ),
    ( Run $ Memory
        [ "-t", "<used>M <usedratio>%",
	  "-p", "3"
	] 20,
      xmobarColor "#458588" "" $ xmobarIcon "\xf233" ++ " %memory%"
    ),
    ( Run $ BatteryP ["BAT0"]
        [ "-t", "<acstatus>",
	  "-p", "3",
	  "--",
	  "-a", "notify-send -u critical 'Battery Low!!'",
	  "-o", xmobarIcon "\xf243" ++ " <left>% <timeleft>",
	  "-O", xmobarIcon "\xf242" ++ " <left>%",
	  "-i", xmobarIcon "\xf240" ++ " 100%"
	] 600,
      xmobarColor "#FB4934" "" "%battery%"
    ),
    ( Run $ Alsa "default" "Master"
        [ "-t", "<status>",
	  "-p", "3",
	  "--",
	  "-O", " <volume>%",
	  "-o", xmobarIcon "\xf6a9" ++ " <volume>%",
	  "-H", "50",
	  "-h", xmobarIcon "\xf028",
	  "-m", xmobarIcon "\xf027",
	  "-L", "1",
	  "-l", xmobarIcon "\xf026"
	],
      xmobarColor "#1CFC03" "" "%alsa:default:Master%"
    ),
    ( Run $ Date "%d.%m.%Y" "date" 36000,
      xmobarColor "#83A598" "" $ xmobarIcon "\xf073" ++ " %date%"
    ),
    ( Run $ Date "%H:%M:%S" "time" 10,
      xmobarColor "#83A598" "" $ xmobarIcon "\xf017" ++ " %time%"
    )
  ]

myTemplate :: String
myTemplate = intercalate separator (map snd leftSide) ++ alignSeparator ++ intercalate separator (map snd rightSide) ++ " "

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
