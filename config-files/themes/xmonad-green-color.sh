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
#        FILE: green-color.sh
#       USAGE: ./green-color.sh | sub file of themes.sh
#
# DESCRIPTION: change xmonad color to a green color
#
#      AUTHOR: DarknessCode
#       EMAIL: admin@darknesscode.com
#
#     CREATED: 07-27-20 4:30
#
# -----------------------------------------------------------------

echo " Changing xmonad and xmobar colors (Green theme)"
echo ""
sleep 2

# Border unfocus window
sed -i 's/normalBorderColor   = ".*"/normalBorderColor   = "#2F3D44"/g' $HOME/.xmonad/xmonad.hs &&
echo " Normal border color has been changed" || echo " Upsss! We have a problems"
echo ""

# Border focus window
sed -i 's/focusedBorderColor  = ".*"/focusedBorderColor  = "#556064"/g' $HOME/.xmonad/xmonad.hs &&
echo " Focus border color has been changed" || echo " Upssssss! Not again!"
echo ""

# Status bar brackgroun color
sed -i 's/, bgColor = ".*"/, bgColor = "#222D31"/g' $HOME/.config/xmobar/xmobarrc &&
echo " Bar background has been changed" || echo " This is not possible!!!"
echo ""

# Status bar fg color
sed -i 's/, fgColor = ".*"/, fgColor = "#556064"/g' $HOME/.config/xmobar/xmobarrc &&
echo " FG color has been changed" || echo " Not again!!!"
echo ""

## dmenu custom
sed -i 's/nb="-nb #.*"/nb="-nb #222D31"/g' $HOME/.xmonad/sysact.sh &&
sed -i 's/sb="-sb #.*"/sb="-sb #222D31"/g' $HOME/.xmonad/sysact.sh &&
sed -i 's/nf="-nf #.*"/nf="-nf #4D5656"/g' $HOME/.xmonad/sysact.sh &&
echo " dmenu (sysact) colors has canged"
echo ""

while true; do
	read -p " Do you want to copy Xresources [y - n] : " yn
	case $yn in
		[Yy]* )
			cp -af config-files/themes/xresources/Xresources-green $HOME/.Xresources &&
			echo " Xresources has been copy" || echo " Upsss! we have a problem here" ; break ;;
		[Nn]* )
			break ;;
		* ) echo "Please answer yes or no." ;;
	esac
done

echo ""
echo " Restart xmonad (Mod+Shift+r)"
echo " If did you copy xresources do you need to exit and login back."
