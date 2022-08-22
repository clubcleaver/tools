#! /bin/bash
# script sets up the environment for ease of use
# and sets handy alias to reduce command typing

# BANNER
banner(){
echo "-------------------------------------------------"
echo "||                                             ||"
echo "|| SETTING ENVIRONMENT - PLEASE FOLLOW PROMPTS ||"
echo "||                                             ||"
echo "-------------------------------------------------"
echo -e "\nCLUBCLEAVER - GITHUB.COM/CLUBCLEAVER/TOOLS - ENJOY :)"
echo "              ----------------------------     "
}
banner # comment this out for less noise

#
# Check current login shell
#

d=5
current_shell=$(echo $SHELL | cut -d / -f $d)
if [ -z $current_shell ]
then 
	d=$(($d-1))
	current_shell=$(echo $SHELL | cut -d / -f $d)
else
	continue
fi

echo -e "\n** changes only login shell .*rc file **"
echo -e "\n\nLogin SHELL => '$current_shell'"

# GET rc file
rcfile="."$(echo $current_shell)"rc"

#
# set environment
#

echo -e "\n LETS SET THE ENVIRONMENT! ..."

select yn in "Set_Path_Alias:" "Set_Command_Alias:" "Done:" ; do
    case $yn in
        "Set_Path_Alias:" ) 
		read -p "enter the path: " pth
		read -p "enter alias:" alis 
		echo -e "alias $alis='cd $pth'" >> $rcfile
		echo "alias '$alis' set to path: $pth"
		echo "you can un-set the alias by editing the $rcfile file"
		;;
        "Set_Command_Alias:" ) 
		read -p "enter alias: " vname
		read -p "enter command: " vval
		echo "alias $vname='$vval'" >> $rcfile
		echo "variable $vname is set to: $vval"
		echo "you can uset this alias by editing the $rcfile file"
		;;

	"Done:" )
		clear
		echo -e "\n********\nALL DONE\n********"
		break;;
    esac
done

echo -e "\n** If env changes are not available **"
echo -e "\n ...  run ' source $rcfile ' ... "

exit
