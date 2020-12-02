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
sed -i 's/normalBorderColor   = ".*"/normalBorderColor   = "#383A59"/g' $HOME/.xmonad/xmonad.hs &&
echo " Normal border color has been changed" || echo " Upsss! We have a problems"
echo ""

# Border focus window
sed -i 's/focusedBorderColor  = ".*"/focusedBorderColor  = "#5A5AA4"/g' $HOME/.xmonad/xmonad.hs &&
echo " Focus border color has been changed" || echo " Upssssss! Not again!"
echo ""

# Status bar brackgroun color
sed -i 's/, bgColor = ".*"/, bgColor = "#1E1F29"/g' $HOME/.config/xmobar/xmobarrc &&
echo " Bar background has been changed" || echo " This is not possible!!!"
echo ""

# Status bar fg color
sed -i 's/, fgColor = ".*"/, fgColor = "#383A59"/g' $HOME/.config/xmobar/xmobarrc &&
echo " FG color has been changed" || echo " Not again!!!"
echo ""

## change background color dnustrc
sed -i 's/background\ = .*/background\ = \"#1E1F29"/g' $HOME/.config/dunst/dunstrc &&
echo " dnust color scheme has been applied" || echo " No way!!!!"
echo ""

## change the background color in nitrogen
sed -i 's/bgcolor=.*/bgcolor=#1E1F29/g' $HOME/.config/nitrogen/bg-saved.cfg &&
echo " nitrogen background color has been applied" || echo " Maybe is you!!!!"
echo ""

## change background color in slick-greeter lightdm
sudo sed -i 's/background-color=.*/background-color=#1E1F29/g' /etc/lightdm/slick-greeter.conf &&
sudo sed -i 's/theme-name=.*/theme-name=Ant-Dracula/g' /etc/lightdm/slick-greeter.conf &&
sudo sed -i 's/icon-theme-name=.*/icon-theme-name=Papirus-Dark/g' /etc/lightdm/slick-greeter.conf &&
echo " Slick-Greeter has been changed" || echo " Upsss!!!!"
echo ""

while true; do
	read -p " Do you want to copy Xresources [y - n] : " yn
	case $yn in
		[Yy]* )
			cp -af config-files/themes/xresources/Xresources-dracula $HOME/.Xresources &&
			echo " Xresources has been copy" || echo " Upsss! we have a problem here" ; break ;;
		[Nn]* )
			break ;;
		* ) echo "Please answer yes or no." ;;
	esac
done

echo ""
echo " Restart xmonad (Mod+Shift+r)"
echo " If did you copy xresources do you need to exit and login back."
