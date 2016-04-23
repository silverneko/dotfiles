import XMonad
import XMonad.Util.Run
import qualified XMonad.StackSet as W

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook

import XMonad.Layout.ResizableTile
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.Renamed

import System.Exit
import qualified Data.Map as Map

myModMasks :: [KeyMask]
myModMasks = [altMask, winMask]
  where altMask = mod1Mask
        winMask = mod4Mask

myKeys :: XConfig Layout -> Map.Map (KeyMask, KeySym) (X ())
myKeys conf = Map.fromList $ concat $ flip map myModMasks (\modm ->
  [ ((modm,               xK_b     ), sendMessage ToggleStruts) -- %! Toggle struts `aka panel`
  , ((modm,               xK_F10   ), spawn "amixer -D pulse set Master toggle")
  , ((modm,               xK_F11   ), spawn "amixer -D pulse set Master on && amixer -D pulse set Master 3%-")
  , ((modm,               xK_F12   ), spawn "amixer -D pulse set Master on && amixer -D pulse set Master 3%+")
  , ((noModMask,          xK_Print ), spawn "gnome-screenshot") -- %! Screenshot
  , ((modm,               xK_Print ), spawn "gnome-screenshot -i")

  -- launching and killing programs
  , ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf) -- %! Launch terminal
  , ((modm .|. shiftMask, xK_f     ), spawn "nemo") -- %! Launch file manager
  , ((modm .|. shiftMask, xK_g     ), spawn "google-chrome") -- %! Launch web browser
  , ((modm,               xK_p     ), spawn "xfce4-appfinder") -- %! Launch appfinder
  , ((modm .|. shiftMask, xK_p     ), spawn "synapse") -- %! Launch launcher
  , ((modm .|. shiftMask, xK_c     ), kill) -- %! Close the focused window

  , ((modm,               xK_space ), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
  , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) -- %!  Reset the layouts on the current workspace to default

  , ((modm,               xK_n     ), refresh) -- %! Resize viewed windows to the correct size

  -- move focus up or down the window stack
  , ((modm,               xK_Tab   ), windows W.focusDown) -- %! Move focus to the next window
  , ((modm .|. shiftMask, xK_Tab   ), windows W.focusUp  ) -- %! Move focus to the previous window
  , ((modm,               xK_k     ), windows W.focusDown) -- %! Move focus to the next window
  , ((modm,               xK_j     ), windows W.focusUp  ) -- %! Move focus to the previous window
  , ((modm,               xK_m     ), windows W.focusMaster  ) -- %! Move focus to the master window

  -- modifying the window order
  , ((modm,               xK_Return), windows W.swapMaster) -- %! Swap the focused window and the master window
  , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
  , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window

  -- resizing the master/slave ratio
  , ((modm,               xK_h     ), sendMessage Shrink) -- %! Shrink the master area
  , ((modm,               xK_l     ), sendMessage Expand) -- %! Expand the master area
  , ((modm,               xK_i     ), sendMessage MirrorShrink)
  , ((modm,               xK_u     ), sendMessage MirrorExpand)

  -- floating layer support
  , ((modm,               xK_t     ), withFocused $ windows . W.sink) -- %! Push window back into tiling

  -- increase or decrease number of windows in the master area
  , ((modm              , xK_comma ), sendMessage (IncMasterN 1)) -- %! Increment the number of windows in the master area
  , ((modm              , xK_period), sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area

  -- quit, or restart
  , ((modm .|. shiftMask, xK_q     ), io exitSuccess) -- %! Quit xmonad
  , ((modm              , xK_q     ), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi") -- %! Restart xmonad
  ]
  ++
  -- mod-[1..9] %! Switch to workspace N
  -- mod-shift-[1..9] %! Move client to workspace N
  do
    let workspaceKeys = [xK_1 .. xK_9] ++ [xK_0, xK_minus, xK_equal]
    (i, k) <- zip (XMonad.workspaces conf) workspaceKeys
    (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    pure ((modm .|. m, k), windows $ f i)
  ++
  -- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
  [((modm .|. m, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
  )

myWorkspaces :: [String]
myWorkspaces =
  ["1:Browser", "2:Dev", "3:Alpha", "4:Beta", "5:Gamma", "6:Delta", "7:Epsilon", "8:Zeta", "9:Eta", "0", "-", "="]

myLayoutHook = renamed [CutWordsLeft 1] $
  fullscreenFocus . smartBorders . avoidStruts $
  onWorkspaces (take 1 myWorkspaces) full $
  deco tile ||| deco (Mirror tile) ||| full -- ||| deco Accordion
  where
    tile = renamed [Replace "Tall"] $ ResizableTall 1 (3/100) (1/2) []
    full = renamed [PrependWords "Full"] $ noBorders Full
    deco = noFrillsDeco shrinkText Theme
      { activeColor         = "#000000"
      , inactiveColor       = "#000000"
      , urgentColor         = "#FF0000"

      , activeBorderColor   = "#ffffff"
      , inactiveBorderColor = "#ffffff"
      , urgentBorderColor   = "#FF0000"

      , activeTextColor     = "#00FF00"
      , inactiveTextColor   = "#BFBFBF"
      , urgentTextColor     = "#FFFF00"
      , fontName  = "xft:Noto Sans CJK:size=12:antialias=true"
      , decoWidth           = 200
      , decoHeight          = 27
      , windowTitleAddons   = []
      , windowTitleIcons    = []
      }

myManageHook = composeAll
  [ className =? "Gimp"         --> doFloat
  , className =? "Xmessage"     --> doFloat
  , appName   =? "vlc"          --> doFloat
  , appName   =? "xfrun4"       --> doFloat
  , appName   =? "xfce4-appfinder" --> doFloat
  , appName   =? "synapse"      --> doIgnore
  , appName   =? "stalonetray"  --> doIgnore
  ]

myTerminal = "xfce4-terminal"

main :: IO ()
main = do
  xmobar <- spawnPipe "xmobar"
  xmonad $ withUrgencyHook NoUrgencyHook $ def
    { terminal            = myTerminal
    , focusFollowsMouse   = True
    , keys                = myKeys
    , workspaces          = myWorkspaces

    , manageHook          = manageDocks <+> myManageHook
    , layoutHook          = myLayoutHook
    , borderWidth         = 1
    , normalBorderColor   = "#FFFFFF"
    , focusedBorderColor  = "#FFFFFF"

    , logHook             = dynamicLogWithPP def
                              { ppOutput  = hPutStrLn xmobar
                              , ppCurrent = xmobarColor "yellow" "" . wrap "[ " " ]"
                              , ppTitle   = xmobarColor "green"  "" . shorten 80
                              , ppVisible = wrap "(" ")"
                              , ppUrgent  = xmobarColor "red" "" . wrap "[ " " ]"
                              , ppSep     = "   "
                              }

    , handleEventHook     = fullscreenEventHook
    }

