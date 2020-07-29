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
	echo " All needed programs are in the repos"
	echo ""
	sleep 2

	while true; do
		read -p " Install software [y - n] : " yn
		case $yn in
			[Yy]* )
				sudo pacman -S --noconfirm --needed xmonad xmonad-contrib xmobar; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done
}

arch-xterm-dmenu() {
	echo ""
	echo " Installing xterm and dmenu"
	echo " Arch-Based systems"
	echo ""
	echo " xterm and dmenu are in the repos"
	echo " this two programs are necessary for xmonad"
	echo " if you don't want to install xterm you can change you terminal"
	echo " before copy the custom file for xmonad in this menu then install dmenu"
	echo " manualy when you start the xmonad session"
	echo ""
	sleep 2

	while true; do
		read -p " Install xterm (terminal) [y - n] : " yn
		case $yn in
			[Yy]* )
				sudo pacman -S --noconfirm --needed xterm; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done

	echo ""

	while true; do
		read -p " Install dmenu [y - n] : " yn
		case $yn in
			[Yy]* )
				sudo pacman -S --noconfirm --needed dmenu; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done
}

debian-based() {
	echo ""
	echo " Installing xmonad, xmobar and dependencies"
	echo " Debian-Based systems"
	echo ""
	echo " All needed programs are in the repos"
	echo ""
	echo ""
	sleep 2

	while true; do
		read -p "Install Software [y - n] : " yn
		case $yn in
			[Yy]* )
				sudo apt install -y xmonad libghc-xmonad-contrib-dev xmobar; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done
}

debian-xterm-dmenu() {
	echo ""
	echo " Installing xterm and dmenu"
	echo " Debian-Based systems"
	echo ""
	echo " xterm and dmenu are in the repos"
	echo " this two programs are necessary for xmonad"
	echo " if you don't want to install xterm you can change you terminal"
	echo " before copy the custom file for xmonad in this menu then install dmenu"
	echo " manualy when you start the xmonad session"
	echo ""
	sleep 2

	while true; do
		read -p " Install xterm (terminal) [y - n] : " yn
		case $yn in
			[Yy]* )
				sudo apt install -y xterm; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done

	echo ""

	while true; do
		read -p " Install dmenu [y - n] : " yn
		case $yn in
			[Yy]* )
				sudo apt install -y demnu; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done
}

change-terminal() {
	echo ""
	echo " Change terminal in xmonad.sh custom file"
	echo ""
	echo " If you want to change the terminal you can do it here"
	echo ""
	sleep 2

	while true; do
		read -p " Change Terminal [y - n] : " yn
		case $yn in
			[Yy]* )
				read -p " Server user name for samba : " choice;
				sed -i 's+myTerminal = ".*"+myTerminal = "'$choice'"+g' config-files/configs/xmonad.hs &&
				echo " Your terminal ($choice) has been changed" || echo " Upsss!"; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done
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
	echo " 5 - Change terminal in xmonad.sh file"
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
		5) clear; change-terminal     ; press_enter ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
