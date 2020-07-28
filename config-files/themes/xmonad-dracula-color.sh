#!/bin/bash
#  ____             _                         ____          _
# |  _ \  __ _ _ __| | ___ __   ___  ___ ___ / ___|___   __| | ___
# | | | |/ _' | '__| |/ / '_ \ / _ \/ __/ __| |   / _ \ / _' |/ _ \
# | |_| | (_| | |  |   <| | | |  __/\__ \__ \ |__| (_) | (_| |  __/
# |____/ \__,_|_|  |_|\_\_| |_|\___||___/___/\____\___/ \__,_|\___|
# -----------------------------------------------------------------
# https://darkncesscode.com
# https://github.com/codedarkness
# -----------------------------------------------------------------
#
#        FILE: dracula-color.sh
#       USAGE: ./dracula-color.sh | sub file of themes.sh
#
# DESCRIPTION: change xmonad color to a dracula scheme
#
#      AUTHOR: DarknessCode
#       EMAIL: admin@darknesscode.com
#
#     CREATED: 07-27-20 4:56
#
# -----------------------------------------------------------------

echo " Changing xmonad and xmobar colors (Dracula theme)"
echo ""
sleep 2

# Border unfocus window
sed -i 's/myNormColor =  ".*"/nyNormColor = "#383A59"/g' $HOME/.xmonad/xmonad.hs &&
echo " Normal border color has been changed" || echo " Upsss! We have a problems"
echo ""

# Border focus window
sed -i 's/myFocusColor = ".*"/myFocusColor = "#5A5AA4"/g' $HOME/.xmonad/xmonad.hs &&
echo " Focus border color has been changed" || echo " Upssssss! Not again!"
echo ""

# TreeTab layout colors
sed -i 's/, activeColor         = ".*"/, activeColor         = "#1E1F29"/g' $HOME/.xmonad/xmonad.hs &&
sed -i 's/, inactiveColor       = ".*"/, inactiveColor       = "#85929E"/g' $HOME/.xmonad/xmonad.hs &&
sed -i 's/, activeBorderColor   = ".*"/, activeBorderColor   = "#1E1F29"/g' $HOME/.xmonad/xmonad.hs &&
sed -i 's/, inactiveBorderColor = ".*"/, inactiveBorderColor = "#1E1F29"/g' $HOME/.xmonad/xmonad.hs &&
sed -i 's/, activeTextColor     = ".*"/, activeTextColor     = "#ffffff"/g' $HOME/.xmonad/xmonad.hs &&
sed -i 's/, inactiveTextColor   = ".*"/, inactiveTextColor   = "#d0d0d0"/g' $HOME/.xmonad/xmonad.hs &&
echo " TreeTab layout colors had been change" || echo " Someting is wrong with you!"
echo ""

# Status bar brackgroun color
sed -i 's/, bgColor = ".*"/, bgColor = "#1E1F29"/g' $HOME/.config/xmobar/xmobarrc &&
echo " Bar background has been changed" || echo " This is not possible!!!"
echo ""

# Status bar fg color
sed -i 's/, fgColor = ".*"/, fgColor = "#383A59"/g' $HOME/.config/xmobar/xmobarrc &&
echo " FG color has been changed" || echo " Not again!!!"
echo ""

## dmenu custom
sed -i 's/nb="-nb #.*"/nb="-nb #1E1F29"/g' $HOME/.xmonad/sysact.sh &&
sed -i 's/sb="-sb #.*"/sb="-sb #1E1F29"/g' $HOME/.xmonad/sysact.sh &&
sed -i 's/nf="-nf #.*"/nf="-nf #383A59"/g' $HOME/.xmonad/sysact.sh &&
echo " dmenu (sysact) colors has canged"
echo ""
