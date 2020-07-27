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
#        FILE: install-xmonad.sh
#       USAGE: ./install-xmonad.sh | sub menu of xmonad-install.sh
#
# DESCRIPTION: install xmonad and xmobar in arch and debian systems
#
#      AUTHOR: DarknessCode
#       EMAIL: admin@darknesscode.om
#
#     CREATED: 07-26-20 6:30
#
# -----------------------------------------------------------------

arch-based() {
	echo ""
	echo " Installing xmonad, xmobar and dependencies"
	echo " Arch-Based systems"
	echo ""
	sleep 2

	sudo pacman -S --noconfirm --needed xmonad xmonad-contrib xmobar

}

arch-xterm-dmenu() {
	echo ""
	echo " Installing xterm and dmenu"
	echo " Arch-Based systems"
	echo ""
	sleep 2

	sudo pacman -S --noconfirm --needed xterm dmenu
}

debian-based() {
	echo ""
	echo " Installing xmonad, xmobar and dependencies"
	echo " Debian-Based systems"
	echo ""
	sleep 2

	sudo apt install -y xmonad libghc-xmonad-contrib-dev xmobar
}

debian-xterm-demnu() {
	echo ""
	echo " Installing xterm and dmenu"
	echo " Debian-Based systems"
	echo ""
	sleep 2

	sudo apt install -y xterm demnu
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
	echo "  _           _        _ _                                      _ "
	echo " (_)         | |      | | |                                    | |"
	echo "  _ _ __  ___| |_ __ _| | |_  ___ __ ___   ___  _ __   __ _  __| |"
	echo " | | '_ \/ __| __/ _' | | \ \/ / '_ ' _ \ / _ \| '_ \ / _' |/ _' |"
	echo " | | | | \__ \ || (_| | | |>  <| | | | | | (_) | | | | (_| | (_| |"
	echo " |_|_| |_|___/\__\__,_|_|_/_/\_\_| |_| |_|\___/|_| |_|\__,_|\__,_|"
	echo ""
	echo " install xmonad and xmobar in arch and debian systems"
	echo ""
	echo " Arch-Based"
	echo " 1 - Xmonad and Xmobar"
	echo " 2 - Xterm and dmenu (if aren't installed)"
	echo ""
	echo " Debian-Based"
	echo " 3 - Xmonad and Xmobar"
	echo " 4 - Xterm and dmenu (if aren't installed)"
	echo ""
	echo " 0 - Back"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; arch-based          ; press_enter ;;
		2) clear; arch-xterm-dmenu    ; press_enter ;;
		3) clear; debian-based        ; press_enter ;;
		4) clear; debian-xterm-dmenu  ; press_enter ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
