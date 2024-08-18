#The script move all files from the ~Home to the theirs respective locations based on the type of Data.
#!bin/bash

clear

# Set some colors
green="\033[32m"
green_bg="\033[42m"
yellow="\033[33m"
red="\033[31m"
red_bg="\033[41m"
blue="\033[34m"
reset="\033[0m"

# Prints the Logo, title, function, version and owner
echo -e "${green}
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⡰⠉⠀⠀⠉⠻⢦⡀⠀⡀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣰⠁⠀⠀⠀⠀⠈⣶⣝⣺⢷⡀⠀⠀⠀   ____ _     _         __    __ _                  _   
⠀⠀⠀⠀⠀⠀⢠⡗⠂⠀⠀⠀⠁⠐⠺⡌⠁⠈⠛⠂⠀⠀  /__  (_) __| |_   _  / / /\ \ (_)______ _ _ __ __| |
⠀⠀⠀⢀⣠⠴⠚⠊⠉⠉⠁⠈⠉⠉⠑⠓⠦⣄⡀⠀⠀⠀   / /\/ |/ _  | | | | \ \/  \/ / |_  / _  |  __/ _  |
⢀⣴⣾⣭⡤⢤⣤⣄⣀⣀⣀⣀⣀⣀⣠⣤⡤⢤⣭⣷⣦⡀  / /  | | (_| | |_| |  \  /\  /| |/ / (_| | | | (_| |
⠈⢯⣿⡿⣁⡜⣨⠀⠷⣲⡞⢻⣖⠾⠀⡅⢳⣈⢿⣟⡽⠁  \/   |_|\__,_|\__, |   \/  \/ |_/___\__,_|_|  \__,_|
⠀⠀⠈⠙⡟⡜⣸⡀⠀⡅⠇⠘⠢⠀⢀⣇⢣⢻⠋⠁⠀⠀                 |___/                                        
⠀⠀⠀⠰⡾⡰⡏⠛⠚⠋⣉⣍⠙⠓⠛⢹⢆⢷⠆⠀⠀⠀
⠀⠀⠀⠀⢷⠡⢹⠒⢖⡬⠄⠀⢭⡲⠒⡏⠈⡾⠀⠀⠀          TidyWizard! (folder organizer) v1.0
⠀⠀⠀⠀⠸⢇⣏⣦⠀⠀⠀⠀⠀⠀⣴⣽⡼⠇⠀⠀⠀⠀                      by cr0n1x
⠀⠀⠀⠀⠀⠈⠈⠉⠻⣴⠀⠀⣤⠟⠁⠁⠁⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⠞⠉⠀⠀⠀⠀⠀
⠀⠀⠀⠀
${green}${reset}"

# Set some comand lines as variables
user=$(whoami)
OSTYPE=$(uname)
strt_path=/home/$user

# Check if the OS is Linux. If don't, finish the script.
echo
if [[ "$OSTYPE" != "linux-gnu" && "$OSTYPE" != "Linux" ]]; then
	echo
	echo -e "   ${reset}${red_bg} [X] Sorry, the script is for Linux only. Windows version coming soon... Maybe ${reset}"
	echo
	exit
fi

# Change the directory for a default path
cd $strt_path

# Define all folders(paths) that will be cleaned, and all file extensions that will be availed.  
paths=("Desktop" "Documents" "Pictures" "Downloads" "Videos" "Music")
extensions=(".txt" ".pdf" ".doc" ".gif" ".jpg" ".png" ".deb" ".exe" ".zip" ".mp4" ".mpg" ".avi" ".mp3" ".ogg" ".wav")

echo -e "${reset}${yellow}   [!]${reset} The deafault folders structure that will be passed is...${reset}"
echo -e "${reset}${yellow}       /home/user ${blue} ${reset}"
echo -e "${reset}${yellow}	    |_____${reset} Desktop${yellow} .................................[none]${reset}"
echo -e "${reset}${yellow}	    |_____${reset} Documents${yellow} ...................[.txt][.pdf][.doc]${reset}"
echo -e "${reset}${yellow}	    |_____${reset} Downloads${yellow} ...................[.deb][.exe][.zip]${reset}"
echo -e "${reset}${yellow}	    |_____${reset} Music${yellow} .......................[.mp3][.mpg][.wav]${reset}"
echo -e "${reset}${yellow}	    |_____${reset} Pictures${yellow} ....................[.png][.jpg][.doc]${reset}"
echo -e "${reset}${yellow}	    |_____${reset} Videos${yellow}.......................[.txt][.pdf][.doc]${reset}"


echo
echo -e "${reset}${green}   [+]${reset}  To include more folders to be scanned, type ${green}\"add\"${reset}"
echo -e "${reset}${red}   [-]${reset}  To delete a folder (for not be scanned), type ${red}\"del\"${reset}"
echo -e "${reset}${blue}   [o]${reset}  If everythig is good, type ${blue}\"done\"${reset}"
sleep 1

echo
echo -n -e "${reset}   >> "
read input

# Based on the user choose (add, del or done) do the respective action
while [ $input != "done" ]
do
	# add -> Will append the typed folder into paths array to be avail with the others later
	if [ $input == "add" ]; then
    		echo -n -e "${reset}${green}   >>>>>>> "
    		read add
    		paths+=("$add")
  	fi
  	
  	# del -> Will access the paths array, looks if the typed folder is there, and unset from the array.
  	if [ $input == "del" ]; then
    		echo -n -e "${reset}${red}   >>>>>>> "
    		read del
    		cnt=0
    		for path in "${paths[@]}"; do
			if [ $path == "$del" ]; then
    				unset 'paths[cnt]'
    				break
  			fi
  			((cnt++))
		done
  	fi
  	
  	# Prints a ERROR message.
  	if [ $input != "add" -a $input != "del" ]; then
    		echo -e "     ${reset}${red_bg}Invalid command${reset}"
  	fi
	
	# Ok, the comand was a sucess. Ask to user if wants to (add) or (del) more folders, or wants proceed (done).
	echo -n -e "${reset}   >> "
	read input
done
echo

# For each path in paths
for path in "${paths[@]}"; do
	# For each extension in extensions
	for extension in "${extensions[@]}"; do
		
		# At this point, we are with a element of paths, and a element of extensions.
		# Will check if has some file with this extension in this path
		if find "/home/$user/$path" -type f -name "*$extension" -print -quit | grep -q . ; then
	  		cd /home/$user/$path/
	  		
			case "$extension" in
				
				".txt"|".doc"|".pdf") # Checks if have Document files in actual folder
			        	if [ "/home/$user/$path/" != "/home/$user/Documents/" ]; then
			    	  		mv *$extension /home/$user/Documents/  2>/dev/null
			    	  		echo -e "   /home/$user/$path [$extension] --> ${reset}${green}MOVED${reset}"
			    	  		sleep 0.5
			      		fi
			      		;;

				".gif"|".jpg"|".png") # Checks if have Picture files in actual folder
			        	if [ "/home/$user/$path" != "/home/$user/Pictures" ]; then
					    	mv *$extension /home/$user/Pictures/  2>/dev/null
					    	echo -e "   /home/$user/$path [$extension] --> ${reset}${green}MOVED${reset}"
					    	sleep 0.5
    			      		fi
			      		;;
			  
			  	".deb"|".exe"|".zip") # Checks if have Download files in actual folder
			      		if [ "/home/$user/$path" != "/home/$user/Downloads" ]; then
			    	  		mv *$extension /home/$user/Downloads/  2>/dev/null
			    	  		echo -e "   /home/$user/$path [$extension] --> ${reset}${green}MOVED${reset}"
			    	  		sleep 0.5
    			      		fi
			      		;;
			    
			  	".mp4"|".mpg"|".avi") # Checks if have Video files in actual folder
			      		if [ "/home/$user/$path" != "/home/$user/Videos" ]; then
			    	  		mv *$extension /home/$user/Videos/  2>/dev/null
			    	  		echo -e "   /home/$user/$path [$extension] --> ${reset}${green}MOVED${reset}"
			    	  		sleep 0.5
    			      		fi
			      		;; 
			    
			  	".mp3"|".ogg"|".wav") # Checks if have Music files in actual folder
			      		if [ "/home/$user/$path" != "/home/$user/Music" ]; then
			    	  		mv *$extension /home/$user/Music/  2>/dev/null
			    	  		echo -e "   /home/$user/$path [$extension] --> ${reset}${green}MOVED${reset}"
			    	  		sleep 0.5
    			      		fi
			      		;;  
			esac
		fi
	done
done

echo ""  
echo ""  
echo -e "   ${reset}${green}[+]${reset} ALL CHANGES HAVEN BE ${reset}${green_bg} DONE ${reset}" 
echo ""  
echo ""  

sleep(5)