-- {{ imports

import Colors.GruvboxDark
import qualified Data.Map as M
import Data.Maybe
import Data.Ratio
import System.IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.DynamicProperty
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.NoBorders
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

-- }}

-- {{ general settings
-- font
myFont :: String
myFont = "xft:JetBrainsMono Nerd Font:regular:size=9"

-- super as mod key
myModMask :: KeyMask
myModMask = mod4Mask

-- terminal
myTerminal :: String
myTerminal = "kitty"

-- browser
myBrowser :: String
myBrowser = "google-chrome-stable"

-- border width
myBorderWidth :: Dimension
myBorderWidth = 2

-- default border color
myNormColor :: String
myNormColor = colorBack

-- focused border color
myFocusColor :: String
myFocusColor = color15

-- }}

windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

-- apps/tasks which should run on start
myStartupHook = do
  -- spawn "killall trayer"
  -- run compositor
  spawnOnce "picom"
  -- swap caps with escape
  spawnOnce "setxkbmap -option caps:swapescape"
  -- enable numlock
  spawnOnce "numlockx on"
  -- set background image
  spawnOnce "feh --randomize --bg-fill $HOME/.config/xmonad/wallpapers/*"
  -- system tray
  -- spawn ("sleep 2 && trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 0 --transparent true --alpha 0 " ++ colorTrayer ++ " --height 22")

-- manage defaults for apps
myManageHook =
  composeAll
    [ className =? "confirm" --> doFloat,
      className =? "dialog" --> doFloat,
      isFullscreen --> doFullFloat
    ]

myDynamicManageHook =
  composeAll
    [ title =? "powermenu" --> doRectFloat (W.RationalRect (1 % 4) (1 % 4) (1 % 2) (1 % 2))
    ]

-- layouts
myLayoutHook = smartBorders $ avoidStruts (tall ||| Full)
  where
    tall = Tall nmaster delta ratio
    nmaster = 1
    ratio = 1 / 2
    delta = 3 / 100

-- workspace names
myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "]

myWorkspaceIndices = M.fromList $ zip myWorkspaces [1 ..]

-- helper function to make xmobar clickable
clickable :: String -> String
clickable ws = "<action=xdotool key super+" ++ show i ++ ">" ++ ws ++ "</action>"
  where
    i = fromJust $ M.lookup ws myWorkspaceIndices

-- keybindings
myKeys =
  [ ("M-<Return>", spawn (myTerminal ++ " -1 /bin/zsh -c \"tmux attach || tmux\"")),
    ("M-d", spawn "rofi -combi-modi window,drun -theme sidebar -show-icons -font \"JetBrainsMono 15\" -show combi"),
    ("M-C-r", spawn "ghc --make -dynamic -threaded $HOME/.config/xmobar/xmobar.hs && xmonad --restart"),
    ("<XF86AudioMute>", spawn "amixer set Master toggle"),
    ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%- unmute"),
    ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+ unmute"),
    ("M-S-q", spawn $ "kitty powermenu")
  ]

main :: IO ()
main = do
  xmproc0 <- spawnPipe "xmobar -x 0"
  xmonad $
    ewmh $
      docks $
        def
          { modMask = myModMask,
            terminal = myTerminal,
            startupHook = myStartupHook,
            borderWidth = myBorderWidth,
            workspaces = myWorkspaces,
            normalBorderColor = myNormColor,
            focusedBorderColor = myFocusColor,
            manageHook = myManageHook <+> manageDocks,
            layoutHook = myLayoutHook,
	    handleEventHook = dynamicPropertyChange "WM_NAME" myDynamicManageHook <+> fullscreenEventHook,
            logHook =
              dynamicLogWithPP $
                xmobarPP
                  { ppOutput = hPutStrLn xmproc0,
                    ppCurrent = xmobarColor color06 "" . wrap ("<box type=Bottom width=2 mb=2 color=" ++ color06 ++ ">") "</box>",
                    ppVisible = xmobarColor color06 "" . clickable,
                    ppHidden = xmobarColor color05 "" . wrap ("<box type=Top width=2 mt=2 color=" ++ color05 ++ ">") "</box>" . clickable,
                    ppHiddenNoWindows = xmobarColor color05 "" . clickable,
                    ppTitle = xmobarColor color16 "" . shorten 60,
                    ppSep = "<fc=" ++ color09 ++ "> <fn=1>|</fn> </fc>",
                    ppUrgent = xmobarColor color02 "" . wrap "!" "!",
                    ppExtras = [windowCount],
                    ppOrder = \(ws : l : t : ex) -> [ws, l] ++ ex ++ [t]
                  }
          }
          `additionalKeysP` myKeys