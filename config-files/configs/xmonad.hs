--  ____             _                         ____          _
-- |  _ \  __ _ _ __| | ___ __   ___  ___ ___ / ___|___   __| | ___
-- | | | |/ _' | '__| |/ / '_ \ / _ \/ __/ __| |   / _ \ / _' |/ _ \
-- | |_| | (_| | |  |   <| | | |  __/\__ \__ \ |__| (_) | (_| |  __/
-- |____/ \__,_|_|  |_|\_\_| |_|\___||___/___/\____\___/ \__,_|\___|
-- -----------------------------------------------------------------
-- https://darkncesscode.com
-- https://github.com/codedarkness
-- -----------------------------------------------------------------

-- Base
import XMonad
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

-- Actions
import XMonad.Actions.CopyWindow (kill1, killAllOtherCopies)
import XMonad.Actions.CycleWS (moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import qualified XMonad.Actions.TreeSelect as TS
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (sinkAll, killAll)
import qualified XMonad.Actions.Search as S

-- Data
import Data.Char (isSpace)
import Data.Monoid
import Data.Maybe (isJust)
import Data.Tree
import qualified Data.Map as M

-- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WorkspaceHistory

-- Layouts
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns

-- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed (renamed, Rename(Replace))
import XMonad.Layout.ShowWName
import XMonad.Layout.Spacing
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

-- Prompt
import XMonad.Prompt
import XMonad.Prompt.Input
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Man
import XMonad.Prompt.Pass
import XMonad.Prompt.Shell (shellPrompt)
import XMonad.Prompt.Ssh
import XMonad.Prompt.XMonad
import Control.Arrow (first)

-- Utilities
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce

myFont :: String
myFont = "xft:Noto:size=11:antialias=true:hinting=true"

-- Sets modkey to super/windows key
myModMask :: KeyMask
myModMask = mod4Mask

-- Sets default terminal
myTerminal :: String
myTerminal = "terminal"

-- Sets firefox as browser for tree select
myBrowser :: String
myBrowser = "brave"

-- Sets vim as editor for tree select
myEditor :: String
myEditor = myTerminal ++ " -e vim "

-- Sets border width for windows
myBorderWidth :: Dimension
myBorderWidth = 1

-- Border color of normal windows
myNormColor :: String
myNormColor   = "#2F3D44"

-- Border color of focused windows
myFocusColor :: String
myFocusColor  = "#556064"

-- Setting this for use in xprompts
altMask :: KeyMask
altMask = mod1Mask

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

-- Auto start
myStartupHook :: X ()
myStartupHook = do
          spawnOnce "compton &"
          spawnOnce "nitrogen --restore &"
          spawnOnce "volumeicon &"
          spawnOnce "nm-applet &"
          spawnOnce "xfce4-power-manager &"
          spawnOnce "pamac-tray &"
          spawnOnce "xautolock -time 10 -locker blurlock &"
          spawnOnce "ff-theme-util &"
          spawnOnce "fix_xcursor &"
          spawnOnce "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &"
          setWMName "LG3D"

mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Defining layouts
tall     = renamed [Replace "tall"]
           $ limitWindows 12
           $ mySpacing 6
           $ ResizableTall 1 (3/100) (1/2) []
magnify  = renamed [Replace "magnify"]
           $ magnifier
           $ limitWindows 12
           $ mySpacing 6
           $ ResizableTall 1 (3/100) (1/2) []
monocle  = renamed [Replace "monocle"]
           $ limitWindows 20 Full
floats   = renamed [Replace "floats"]
           $ limitWindows 20 simplestFloat
grid     = renamed [Replace "grid"]
           $ limitWindows 12
           $ mySpacing 6
           $ mkToggle (single MIRROR)
           $ Grid (16/10)
tabs     = renamed [Replace "tabs"]
           $ tabbed shrinkText myTabConfig
  where
    myTabConfig = def { fontName            = "xft:Noto:regular:pixelsize=11"
                      , activeColor         = "#222D31"
                      , inactiveColor       = "#839192"
                      , activeBorderColor   = "#222D31"
                      , inactiveBorderColor = "#222D31"
                      , activeTextColor     = "#ffffff"
                      , inactiveTextColor   = "#d0d0d0"
                      }

-- The layout hook
myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats $
               mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where
               -- I've commented out the layouts I don't use.
               myDefaultLayout =     tall
                                 ||| magnify
                                 ||| noBorders monocle
                                 ||| floats
                                 ||| noBorders tabs

xmobarEscape :: String -> String
xmobarEscape = concatMap doubleLts
  where
        doubleLts '<' = "<<"
        doubleLts x   = [x]

myWorkspaces :: [String]
myWorkspaces = clickable . (map xmobarEscape)
               -- $ ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
               $ ["DEV", "WWW", "SYS", "GFX", "DOC", "CHT", "EDT", "TXT", "CLI"]
  where
        clickable l = [ "<action=xdotool key super+" ++ show (n) ++ "> " ++ ws ++ "</action>" |
                      (i,ws) <- zip [1..9] l,
                      let n = i ]

myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount
    where fadeAmount = 1.0

myKeys :: [(String, X ())]
myKeys =
     -- Xmonad
        [ ("M-C-r", spawn "xmonad --recompile")      -- Recompiles xmonad
        , ("M-S-r", spawn "xmonad --restart")        -- Restarts xmonad
        , ("M-S-q", io exitSuccess)                  -- Quits xmonad

     -- Open my preferred terminal
        , ("M-<Return>", spawn myTerminal)

     -- Windows
        , ("M-q", kill1)                           -- Kill the currently focused client

     -- Floating windows
        , ("M-f", sendMessage (T.Toggle "floats"))       -- Toggles my 'floats' layout
        , ("M-<Delete>", withFocused $ windows . W.sink) -- Push floating window back to tile
        , ("M-S-<Delete>", sinkAll)                      -- Push ALL floating windows to tile

     -- Windows navigation
        , ("M-m", windows W.focusMaster)     -- Move focus to the master window
        , ("M-j", windows W.focusDown)       -- Move focus to the next window
        , ("M-k", windows W.focusUp)         -- Move focus to the prev window
        , ("M-S-j", windows W.swapDown)      -- Swap focused window with next window
        , ("M-S-k", windows W.swapUp)        -- Swap focused window with prev window
        , ("M-<Backspace>", promote)         -- Moves focused window to master, others maintain order

     -- Layouts
        , ("M-<Tab>", sendMessage NextLayout)               -- Switch to next layout
        , ("M-<Space>", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggles noborder/full
        , ("M-S-<Space>", sendMessage ToggleStruts)         -- Toggles struts
        , ("M-S-n", sendMessage $ MT.Toggle NOBORDERS)      -- Toggles noborder

        , ("M-h", sendMessage Shrink)                       -- Shrink horiz window width
        , ("M-l", sendMessage Expand)                       -- Expand horiz window width
        , ("M-C-j", sendMessage MirrorShrink)               -- Shrink vert window width
        , ("M-C-k", sendMessage MirrorExpand)               -- Exoand vert window width

     -- Multimedia Keys
        , ("<XF86AudioPlay>", spawn "cmus toggle")
        , ("<XF86AudioPrev>", spawn "cmus prev")
        , ("<XF86AudioNext>", spawn "cmus next")
        , ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%- unmute")
        , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+ unmute")
        , ("<XF86HomePage>", spawn "brave")
        , ("<XF86Search>", safeSpawn "brave" ["https://www.google.com/"])
        , ("<XF86Mail>", runOrRaise "geary" (resource =? "thunderbird"))
        , ("<XF86Calculator>", runOrRaise "gcalctool" (resource =? "gcalctool"))
        , ("<XF86Eject>", spawn "toggleeject")
        , ("<Print>", spawn "i3-scrot")

     -- My Applications
        , ("M-M1-c", spawn (myTerminal ++ " -e calcurse"))
        , ("M-M1-m", spawn (myTerminal ++ " -e cmus"))
        , ("M-M1-n", spawn (myTerminal ++ " -e newsboat"))
        , ("M-0", spawn "./.xmonad/sysact.sh")
        , ("M-o", spawn "./Documents/scripts/dmenu-programs.sh")
        , ("M-S-o", spawn ("dmenu_recency"))
        , ("M-r", spawn (myTerminal ++ " -e ranger"))
        , ("M-v", spawn (myEditor))
        , ("M-F2", spawn "brave")

        ]

-- MAIN --
main :: IO ()
main = do
    xmproc <- spawnPipe "xmobar -x 0 /home/achim/.config/xmobar/xmobarrc"
    xmonad $ ewmh def
        { manageHook = ( isFullscreen --> doFullFloat ) <+> manageDocks
        , handleEventHook    = serverModeEventHookCmd
                               <+> serverModeEventHook
                               <+> serverModeEventHookF "XMONAD_PRINT" (io . putStrLn)
                               <+> docksEventHook
        , modMask            = myModMask
        , terminal           = myTerminal
        , startupHook        = myStartupHook
        , layoutHook         = myLayoutHook
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormColor
        , focusedBorderColor = myFocusColor
        , logHook = workspaceHistoryHook <+> myLogHook <+> dynamicLogWithPP xmobarPP
                        { ppOutput = \x -> hPutStrLn xmproc x
                        , ppCurrent = xmobarColor "#1F618D" ""                -- Current workspace in xmobar
                        , ppVisible = xmobarColor "#839192" ""                -- Visible but not current workspace
                        , ppHidden = xmobarColor  "#81A1C1" ""                -- Hidden workspaces in xmobar (with windows)
                        , ppHiddenNoWindows = xmobarColor "#839192" ""        -- Hidden workspaces (no windows)
                        , ppTitle = xmobarColor "#81A1C1" "" . shorten 60     -- Title of active window in xmobar
                        , ppSep =  "<fc=#666666> <fn=2>:</fn> </fc>"          -- Separators in xmobar
                        , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"  -- Urgent workspace
                        , ppOrder  = \(ws:l:t:ex) -> [ws]++ex++[t]
                        }
        } `additionalKeysP` myKeys
