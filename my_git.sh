#!/bin/bash



# flag checks for first push, Value changes if a .git is not found in pwd.

network_status=$(ping -c 1 google.com | grep -w 0%);

if [ ! -z "$network_status" ]
then

cat <<'EOF'
	   Git Choice Menu
-------------------------------------------------------
     Press 1 - For Cloning the Repo
     Press 2 - For Pushing to Repo
-------------------------------------------------------
EOF

read user_choice;



case $user_choice in 
	1)
		echo "Enter the git repo URL";
		read git_url;

		git clone $git_url;

		if [ $? -eq 0 ];
		then
			echo -e "\nClone was successful, Enjoy your Day. \n";
		else
			echo -e "\nEither URL is invalid, or you've already cloned it here. \n";
		fi
		;;
	2)



flag=0

#Checking whether .git file exist in the current directory or not. To decide whether or not to initialize the current directory.
#And to check whether add remote git url.

dir="./.git";

if [ ! -d "$dir" ] 
then
	echo -e "No Version Control History Found. Initializing the Current Directory \n";
	git init;
	flag=1;
else
	echo -e "\nVersion control history found. \n";
fi


echo -e "\nAdding Files to Push\n";
git add -A;



echo -e "\nPrinting Git Status \n";
git status;


echo -e "\nConfirm push ? (y/n) ?";
read user_input;
echo;

echo -e "\nBranch name: \n";
read branch;

if [ `echo $user_input | grep -iw y` ]
then
	echo -e "\nCommit message: ";
	read commit_message;
	echo;

	git commit -m "$commit_message";

	if [ $flag -eq 1 ]
	then
		echo -e "\nEnter the remote git url";
		read git_url;
		
		git remote add origin $git_url;
	fi 

	git pull origin main;

	echo -e "\npushing to branch main \n";

	git push origin main;

      	if [ $? -eq 0 ];
	then
  		echo -e "\nGit push was successful\n";
	else
		echo -e "\nGit push failed!.\n";
	fi

	
else
	echo -e "\nWrong command. Git push stopped. \n";
fi
	;;

 *)
	 echo -e "\nInvalid choice \n";
	;;

esac

else
	echo -e "\nYou're Offline\n";
fi
