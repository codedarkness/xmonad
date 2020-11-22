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

install-xmonad() {
	echo ""
	echo " Installing xmonad, xmobar and dependencies"
	echo " Arch, Debian Based systems"
	echo ""
	echo " All needed programs are in the repos"
	echo ""
	sleep 2

	while true; do
		read -p " Install Xmonad [y - n] : " yn
		case $yn in
			[Yy]* )
				if ! location="$(type -p "xmonad")" || [ -z "xmonad" ]; then

					# check if pacman is installed
					if which pacman > /dev/null; then

						sudo pacman -S --noconfirm xmonad xmonad-contrib xmobar ghc

					# check if apt is installed
					elif which apt > /dev/null; then

						sudo apt install -y xmonad libghc-xmonad-contrib-dev libghc-xmonad-dev xmobar xdotool ghc

					else

						echo " Your system is not Arch or Debian Based System"
					fi

					else
						echo " Nothing to do! Xmonad is installed in your System"
				fi ; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done

	echo ""
}

install-xterm-dmenu() {
	echo ""
	echo " Installing xterm and dmenu"
	echo " Arch, Debian Based systems"
	echo ""
	echo " xterm and dmenu are in the repos"
	echo " this two programs are necessary for xmonad"
	echo " if you don't want to install xterm you can change you terminal"
	echo " before copy the custom file for xmonad in this menu then install dmenu"
	echo " manualy when you start the xmonad session"
	echo ""
	sleep 2

	while true; do
		read -p " Install Xterm [y - n] : " yn
		case $yn in
			[Yy]* )
				if ! location="$(type -p "xterm")" || [ -z "xterm" ]; then

					# check if pacman is installed
					if which pacman > /dev/null; then

						sudo pacman -S --noconfirm xterm

					# check if apt is installed
					elif which apt > /dev/null; then

						sudo apt install -y xterm

					else

						echo " Your system is not Arch or Debian Based System"
					fi

					else
						echo " Nothing to do! Xterm is installed in your System"
				fi ; break ;;
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
				if ! location="$(type -p "dmenu")" || [ -z "dmenu" ]; then

					# check if pacman is installed
					if which pacman > /dev/null; then

						sudo pacman -S --noconfirm dmenu

					# check if apt is installed
					elif which apt > /dev/null; then

						sudo apt install -y dmenu

					else

						echo " Your system is not Arch or Debian Based System"
					fi

					else
						echo " Nothing to do! dmenu is installed in your System"
				fi ; break ;;
			[Nn]* )
				break ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done

	echo ""
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
				read -p " Whitch is the terminal : " choice;
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
	echo " 1 - Xmonad and Xmobar"
	echo " 2 - Xterm and dmenu (if aren't installed)"
	echo ""
	echo " 3 - Change terminal in xmonad.sh file"
	echo ""
	echo " 0 - Back"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; install-xmonad      ; press_enter ;;
		2) clear; install-xterm-dmenu ; press_enter ;;
		3) clear; change-terminal     ; press_enter ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
