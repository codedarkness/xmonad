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
#        FILE: themes.sh
#       USAGE: ./themes.sh - sub menu (script) of
#              spectrwm_install.sh
#
# DESCRIPTION: change the color of spectrwm and colors
#	       for Xresources to match terminal colors
#
#      AUTHOR: DarknessCode
#       EMAIL: admin@darknesscode.com
#
#     CREATED: 04-15-2020
#
# -----------------------------------------------------------------

dark-theme() {
	config-files/themes/xmonad-dark-theme.sh
}

dracula-theme() {
	config-files/themes/xmonad-dracula-theme.sh
}

green-theme() {
	config-files/themes/xmonad-green-theme.sh
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
	echo "                                       _           _                 "
	echo "                                      | |         | |                "
	echo " __  ___ __ ___   ___  _ __   __ _  __| | ___ ___ | | ___  _ __ ___  "
	echo " \ \/ / '_ ' _ \ / _ \| '_ \ / _' |/ _' |/ __/ _ \| |/ _ \| '__/ __| "
	echo "  >  <| | | | | | (_) | | | | (_| | (_| | (_| (_) | | (_) | |  \__ \ "
	echo " /_/\_\_| |_| |_|\___/|_| |_|\__,_|\__,_|\___\___/|_|\___/|_|  |___/ "
	echo ""
	echo " change color for xmonad"
	echo ""
	echo " 1 - Dark Color Scheme"
	echo " 2 - Dracula Color Scheme"
	echo " 3 - Green Color Scheme"
	echo ""
	echo " 0 - Back"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; dark-theme      ; press_enter ;;
		2) clear; dracula-theme   ; press_enter ;;
		3) clear; green-theme     ; press_enter ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
