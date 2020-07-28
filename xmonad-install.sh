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
#        FILE: xmonad-install.sh
#       USAGE: ./xmonad-install.sh
#
# DESCRIPTION: install xmonad and xmobar in linux systems
#
#      AUTHOR: DarknessCode
#       EMAIL: admin@darknesscode.com
#
#     CREATED: 07-26-20 6:12
#
# -----------------------------------------------------------------

install-xmonad() {
	config-files/systems/install-xmonad.sh
}

copy-files() {
	echo ""
	echo " Copy new config (custom) files"
	echo " xmonad and xmobar"
	sleep 2


	## Xmonad directory
	### Check for dir, if not found create it using the mkdir ###
	dldir="$HOME/.xmonad"
	[ ! -d "$dldir" ] && mkdir -p "$dldir" &&
	echo " xmonad directory was created" || echo "Shhhh! not again"

	cp -af config-files/configs/xmonad.hs $HOME/.xmonad/ &&
	echo " new xmonad.sh has been copied" || echo " Hooooooo!"
	echo ""

	cp -af config-files/configs/xmonadctl.sh $HOME/.xmonad/ &&
	echo " xmonadctl.sh file has been copied" || echo " Not again!!"
	echo ""

	cp -af config-files/configs/sysact.sh $HOME/.xmonad/ &&
	echo " system account file has been copied" || echo " Not again!!"
	echo ""

	## Xmobar directory
	### Check for dir, if not found create it using the mkdir ###
	dldir="$HOME/.config/xmobar"
	[ ! -d "$dldir" ] && mkdir -p "$dldir" &&
	echo " xmobar directory was created" || echo "Shhhh! not again"
	echo ""

	cp -af config-files/configs/xmobarrc $HOME/.config/xmobar/ &&
	echo " new xmobarrc has been copied" || echo " Uppssss!"
	echo ""

	cp -af config-files/configs/haskell_20.xpm $HOME/.config/xmobar/ &&
	echo " xmonad icon has been copied" || echo " Did you brake something!"
	echo ""
}

themes() {
	config-files/themes/themes.sh
}

keybindings() {
	less config-files/configs/keybindings
}

press_enter() {
	echo ""
	echo -n " Press Enter To Continue"
	read
	clear
}

incorrect_selection() {
	echo " Incorrect selection! try again"
}

until [ "$selection" = "0" ]; do
	clear
	echo ""
	echo " DarknessCode"
	echo "                                       _ "
	echo "                                      | |"
	echo " __  ___ __ ___   ___  _ __   __ _  __| |"
	echo " \ \/ / '_ ' _ \ / _ \| '_ \ / _' |/ _' |"
	echo "  >  <| | | | | | (_) | | | | (_| | (_| |"
	echo " /_/\_\_| |_| |_|\___/|_| |_|\__,_|\__,_|"
	echo ""
	echo " a dynamically tiling window manager, written and configured in Haskell"
	echo ""
	echo " 1 - Install xmonad and xmobar"
	echo " 2 - Copy (custom) config files"
	echo " 3 - Themes"
	echo " 4 - Keybindings"
	echo ""
	echo " 0 - Exit"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; install-xmonad ;;
		2) clear; copy-files     ;;
		3) clear; themes         ;;
		4) clear; keybindings    ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
