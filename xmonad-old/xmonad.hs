import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.Magnifier
import XMonad.Layout.ThreeColumns
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab

myTerminal = "kitty"

myModMask = mod4Mask

myKeys =
  [ ("M-<Return>", spawn "kitty -1 /bin/bash -c \"tmux attach || tmux\""),
    ("M-<Tab>", sendMessage NextLayout),
    -- ("M-S-r", spawn "xmonad --recompile; xmonad --restart"),
    ("M-d", spawn "rofi -combi-modi window,drun -theme sidebar -show-icons -font \"JetBrains Mono 15\" -show combi"),
    ("M-S-<Return>", spawn "kitty"),
    -- should look for keybinding modes to implement these well
    ("M-z <Left>", spawn "playerctl previous"),
    ("M-z <Right>", spawn "playerctl next"),
    ("M-z <Space>", spawn "playerctl play-pause"),
    ("M-z <Up>", spawn "playerctl volume 0.1+"),
    ("M-z <Down>", spawn "playerctl volume 0.1-"),
    ("M-z s", spawn "playerctl shuffle Toggle"),
    ("M-z S-<Left>", spawn "playerctl position 15-"),
    ("M-z S-<Right>", spawn "playerctl position 15+"),
    ("M-z n", spawn "playerctl loop None"),
    ("M-z t", spawn "playerctl loop Track"),
    ("M-z p", spawn "playerctl loop Playlist"),
    -- with these as well
    ("M-0 e", spawn "playerctl "),
    ("M-0 r", spawn "playerctl play-pause"),
    ("M-0 s", spawn "playerctl volume 0.1+")
  ]

myStartupHook = do
  spawn "setxkbmap -option caps:swapescape"

myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol
  where
    threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 1 / 2
    delta = 3 / 100

myConfig =
  def
    { modMask = myModMask,
      startupHook = myStartupHook,
      layoutHook = myLayout,
      borderWidth = 0,
      terminal = myTerminal
    }
    `additionalKeysP` myKeys

main :: IO ()
main = xmonad $ ewmhFullscreen $ ewmh $ xmobarProp $ myConfig
