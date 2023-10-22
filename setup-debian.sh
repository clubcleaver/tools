#! /bin/bash
if [ $EUID -ne 0 ]; then
	echo "ERROR: Need Sudo Permissions"
	exit
else
	clear
	echo -e "\n\n\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n\nHELLO ${SUDO_USER}\n\n\nLETS SETUP OUR DEBIAN LINUX\n\n\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n\n"
	userHome=$(eval echo ~${SUDO_USER})
	#	echo $userHome

	# Spinner Function
	spinner() {
		spin='-\|/'
		pid=$!
		i=0
		while kill -0 $pid 2>/dev/null; do
			i=$(((i + 1) % 4))
			printf "\r${spin:$i:1}"
			sleep 0.1
		done
	}

	main() {

		# Setup TMUX Environment
		tmux_setup() {
			echo -e "Setting Up TMUX\n"
			cd $userHome
			touch .tmux.conf
			echo -e "set -g status-style bg=Black\nset -g base-index 1\nbind-key -n M-w select-pane -U\nbind-key -n M-a select-pane -L\nbind-key -n M-s select-pane -D\nbind-key -n M-d select-pane -R" >.tmux.conf
		}
		tmux_setup

		# Setting Up Debian Linux
		echo -e "UPDATING APT: \n"
		sudo apt-get update -y 1>/dev/null &
		spinner
		sudo apt-get upgrade -y 1>/dev/null &
		spinner

		# Setting Up Microsoft Repo for VS Code.
		sudo apt-get install wget gpg -y 1>/dev/null
		wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
		sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
		sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
		rm -f packages.microsoft.gpg

		# Setting Up Google Chrome Repos
		wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub >linux_signing_key.pub
		sudo install -D -o root -g root -m 644 linux_signing_key.pub /etc/apt/keyrings/linux_signing_key.pub
		sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/linux_signing_key.pub] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
		sudo apt-get update -y 1>/dev/null &
		spinner

		# List of Packages to install
		LIST=("plocate" "gcc-multilib" "golang-go" "flameshot" "rclone" "terminator" "nodejs" "npm" "code" "python3-pip" "google-chrome-stable" "net-tools" "openssh-client" "openssh-server" "font-manager")
		echo -e "Installing Packages: \n"

		# Installing Package List including VS CODE.

		# Looping Over Array to install
		for p in ${LIST[@]}; 
		do
			sudo apt-get install -y $p 1>/dev/null & 
			spinner
			if [ ${?} -eq 0 ]
			then
				echo -e "\ninstalled ${p} Successfully"
			else
				echo -e "\nERROR: Could Not install the Package ${p}"
			fi
		done

		echo -e "\n\n\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n\nALL DONE !!!\n\n\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n\n"

	}
	main

fi
