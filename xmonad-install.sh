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
	echo ""
	sleep 2


	## Xmonad directory
	### Check for dir, if not found create it using the mkdir ###
	dldir="$HOME/.xmonad"
	[ ! -d "$dldir" ] && mkdir -p "$dldir" &&
	echo " xmonad directory was created" || echo " $dldir already exist!"

	cp -af config-files/configs/xmonad.hs $HOME/.xmonad/ &&
	echo " new xmonad.sh has been copied" || echo " Hooooooo!"
	echo ""

	cp -af config-files/configs/xmonadctl.hs $HOME/.xmonad/ &&
	echo " xmonadctl.sh file has been copied" || echo " Not again!!"
	echo ""

	cp -af config-files/configs/autostart.sh $HOME/.xmonad/ &&
	echo " autostart file has been copied" || echo " No way!!! somting is not good!"
	echo ""

	cp -af config-files/configs/sysact.sh $HOME/.xmonad/ &&
	echo " system account file has been copied" || echo " Not again!!"
	echo ""

	cp -af config-files/congis/dmenu-programs.sh $HOME/.xmonad/ &&
	echo " dmenu custom file has been copied" || echo " No Wayyyyyy!!!"
	echo ""

	## Xmobar directory
	### Check for dir, if not found create it using the mkdir ###
	dldir2="$HOME/.config/xmobar"
	[ ! -d "$dldir2" ] && mkdir -p "$dldir2" &&
	echo " xmobar directory was created" || echo " $dldir2 already exist!"
	echo ""

	cp -af config-files/configs/xmobarrc $HOME/.config/xmobar/ &&
	echo " new xmobarrc has been copied" || echo " Uppssss!"
	echo ""

	cp -af config-files/configs/haskell_20.xpm $HOME/.config/xmobar/ &&
	echo " xmonad icon has been copied" || echo " Did you brake something!"
	echo ""

	while true; do
		read -p " Copy (custome) Xresources [y - n] : " yn
		case $yn in
			[Yy]* )
				cp -af config-files/configs/Xresources $HOME/.Xresources &&
				echo " Xresourses has been copied" || echo " Something is not well!" ; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done

	echo ""

}

themes() {
	config-files/themes/themes.sh
}

change-terminal() {
	echo ""
	echo " Change terminal in xmonad.sh custom file"
	echo ""
	echo " change to your preffer terminal here before copy"
	echo " the custom xmonad.sh file"
	echo ""
	sleep 2

	while true; do
		read -p " Change Terminal [y - n] : " yn
		case $yn in
			[Yy]* )
				read -p " Which is your preffer termianl : " choice;
				sed -i 's+myTerminal = ".*"+myTerminal = "'$choice'"+g' config-files/configs/xmonad.hs &&
				echo " Your terminal ($choice) has been changed" || echo " Upsss!"; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done
}

keybindings() {
	less config-files/keybindings
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
	echo " 4 - Change Terminal"
	echo " 5 - Keybindings"
	echo ""
	echo " 0 - Exit"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; install-xmonad  ;;
		2) clear; copy-files       ; press_enter ;;
		3) clear; themes          ;;
		4) clear; change-terminal  ; press_enter ;;
		5) clear; keybindings     ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
