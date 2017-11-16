#!/bin/bash
#
# H A N G M A N - A GAME WRITTEN FOR EDUCATIONAL PURPOSES DURING MY LINUX LEARNING PERIOD
#
# To play the game type ./game in the terminal.
#
# This game reads a dictionary.txt and a highscores.txt in the same directory as the game script.
#
# Author: Chris Tzatzakis
# Date: Winter 2008
# 
# Make a new high score 
function makenewhighscore { 
	HIGHSCORE_FILE="highscores.txt"
	declare -a HIGHSCORE_ARRAY #set up high score array
	#read the contents of the highscore file into array
	#removing carriage returns
	HIGHSCORE_ARRAY=(`cat "$HIGHSCORE_FILE" | tr -d '\015'`) 

	count=0
	count1=0
	for i in "${HIGHSCORE_ARRAY[@]}" #find and compare the streaks
	do
		a=`expr "$count" % 2`
		if [ ! "$a" -eq "0" ]; then #second, 4th, 6th...lines
			if [ "$streak" -ge "$i" ]; then #if streak is greater than filestreak
				count1=$((count1+1))
			fi
		fi
		count=$((count+1)) #increment count
	done
	if [ "$count1" -ge 1 ]; then #have the user enter their name
		userlen=0
		while [ "$userlen" -le 0 ] || [ "$username" == "" ] || [ "$username" == " " ]; 
		do
			echo "Enter your name:"
			read username
			clear
			userlen=${#username}
		done
		
		count2=0
		count3=0
		place=2
		while [ "$count2" -lt "$count1" ]; 
		do
			HIGHSCORE_ARRAY[$count3]="${HIGHSCORE_ARRAY[$place]}"
			count3=$((count3+1))
			place=$((place+1))
			HIGHSCORE_ARRAY[$count3]="${HIGHSCORE_ARRAY[$place]}"
			count3=$((count3+1))
			place=$((place+1))
			
			count2=$((count2+1))
		done
		place=$((count1-1))
		place=`expr "$place" \* 2`
		HIGHSCORE_ARRAY[$place]="$username"
		place=$((place+1))
		HIGHSCORE_ARRAY[$place]="$streak"
		
		rm highscores.txt #clear the high scores file
	
		for i in "${HIGHSCORE_ARRAY[@]}" #read the contents of high scores array to file
		do
			echo "$i" >> highscores.txt
		done
	fi
	
	displayhighscores #return to display high scores
}

# Display the high scores
function displayhighscores {
	HIGHSCORE_FILE="highscores.txt"
	declare -a HIGHSCORE_ARRAY #set new array
	HIGHSCORE_ARRAY=(`cat "$HIGHSCORE_FILE"`) #load the words into array
	
	if [ "$mainmenu" == "true" ]; then #if coming from the start menu
		echo "Highscores"
		echo "----------"
		for (( i=9; i>=0; i-- )); #set up for loop
		do
			back=$((i-1))
			echo "${HIGHSCORE_ARRAY[$back]}" #show the last entry then the next to last entry
			echo "${HIGHSCORE_ARRAY[$i]}"
			i=$((i-1)) #decrement i twice
		done #finish for loop
		echo " "
		echo "Press Enter to continue"
		read response
		
		mainmenu="false"
		startmenu #return to the start menu
	else #else if coming from anywhere else; same as above but now reset $streak; then return to the start menu
		clear
		echo "Highscores"
		echo "----------"
		for (( i=9; i>=0; i-- )); #set up for loop
		do
			back=$((i-1))
			echo "${HIGHSCORE_ARRAY[$back]}"
			echo "${HIGHSCORE_ARRAY[$i]}"
			i=$((i-1)) #decrement i twice
		done
		echo " "
		read -t 10 #wait for a bit

		streak=0 #reset streak
		startmenu #return to the start menu
	fi
}

# Make the hangman image 
function makehangmanimage {
	
	#hangman case switch
	case $guesses in
		8) hangmanimage="
               __________
               |        |
                        |
                        |
                        |
                        |
                        |
                        |
                        |
                        |
                        |
                        |
                        |
                        |
                        |
                        |
 ________________________
";;
		7) hangmanimage="
               __________
               |        |
             ,,,,,      |
            /     \     |
 YOU CAN   C| @ U |D    |
   WIN!!    \  |  /     |
              ---       |
                        |
                        |
                        |
                        |
                        |
                        |
                        |
                        |
                        |
 ________________________
";;
		6) hangmanimage="
               __________
               |        |
             ,,,,,      |
            /     \     |
           C| @ @ |D    |
            \  |  /     |
              ---       |
               |        |
               |        |
               |        |
               |        |
               |        |
                        |
                        |
                        |
                        |
 ________________________
";;
		5) hangmanimage="
               __________
               |        |
             ,,,,,      |
            /     \     |
           C| @ @ |D    |
            \  |  /     |
              ---       |
               |        |
               |\       |
               | \      |
               |  \     |
               |        |
                        |
                        |
                        |
                        |
 ________________________
";;
		4) hangmanimage="
               __________
               |        |
             ,,,,,      |
            /     \     |
           C| @ @ |D    |
            \  |  /     |
              ---       |
               |        |
              /|\       |
             / | \      |
            /  |  \     |
               |        |
                        |
                        |
                        |
                        |
 ________________________
";;
		3) hangmanimage="
               __________
               |        |
             ,,,,,      |
            /     \     |
           C| @ @ |D    |
            \  |  /     |
              ---       |
               |        |
              /|\       |
             / | \      |
            /  |  \     |
               |        |
              /         |
             /          |
            /           |
                        |
 ________________________
";;
		2) hangmanimage="
               __________
               |        |
             ,,,,,      |
            /     \     |
 COME ON   C| U U |D    |
 THINK!!    \  |  /     |
              ---       |
               |        |
              /|\       |
             / | \      |
            /  |  \     |
               |        |
              /         |
             /          |
            /           |
          _|            |
 ________________________
";;
		1) hangmanimage="
               __________
               |        |
             ,,,,,      |
            /     \     |
           C| θ θ |D    |
            \  |  /     |
              ---       |
               |        |
              /|\       |
             / | \      |
            /  |  \     |
               |        |
              / \       |
             /   \      |
            /     \     |
          _|            |
 ________________________
";;
		0) hangmanimage="
               __________
               |        |
             %%%%%      |
   YOU      /     \     |
 SHOULD    C| X X |D    |
    BE      \  |  /     |
 -IN-         ###       |
    MY         |        |
  PLACE!!!    /|\       |
            \/ | \/     |
               |        |
               |        |
              / \       |
             /   \      |
            /     \     |
          _|       |_   |
 ________________________
";;
		*) echo "error";;
	esac
}

# Ask user to play again
function playagain {
	clear #clear the screen
	playagain=""

	echo "Play Again? (Y/N):"
	read playagain #read user response
	
	if [ "$playagain" == "Y" ] || [ "$playagain" == "y" ]; then
		clear
		playgame
	elif [ "$playagain" == "N" ] || [ "$playagain" == "n" ]; then
		clear
		if [ "$gamewon" == "true" ]; then
			makenewhighscore
		elif [ "$gamewon" == "false" ]; then
			echo "Thanks for playing!"
			read -t 2
			streak=0
			displayhighscores
		fi
	else
		playagain #redisplay the screen
	fi
}

# Show end of game result 
function endgame {
	if [ "$gamewon" == "true" ]; then
		clear
		streak=$((streak+1)) #increment streak
                

 echo "                        __________     "
 echo "                        |        |     "
 echo "                    ,,,,,        |     "
 echo "                   / _ %%        |     "
 echo "      THANKS      /_ 0  ?        |     "
 echo "                   |_  /         |     "
 echo "                 \  \_/|         |     "
 echo "                  \    |         |     "
 echo "                   \___|-\       |     "
 echo "                       |  \      |     "
 echo "                       |   |     |     "
 echo "                    ___|   |     |     "
 echo "                   /    |        |     "
 echo "                  /     |        |     "
 echo "                 /      |_____   |     "
 echo "              __/             |  |     "
 echo "               __________________|_____"


		echo "Congratulations! You Won!"
		echo "The word was $newword"
		echo "The guesses you made were: ${totalguessed[@]}"
		echo ""
		echo "Your streak is now $streak"
		read -t 10
		echo " "
		echo "Press Enter to continue"
		#goto playagain
		playagain	
	else
		streakpos=$((streak+1)) #increment streak
		makehangmanimage
		echo "$hangmanimage"
		echo ""
		echo "Sorry, you are a l-o-s-e-r, A LOSER"
		echo "The word was $newword"
		echo ""
		echo "The guesses you made were: ${totalguessed[@]}"
		echo ""
		echo "Your streak would have been $streakpos"
		read -t 10
		echo " "
		echo "Press Enter to continue"
		read response

		makenewhighscore
	fi
}

# Parse user guesses
function user_guess {
	# if guess length = 1 (it's a letter guess)
	# if guess length >= 2 (it's a word guess)
	guess=$( printf "%s\n" "$guess" | tr '[A-Z]' '[a-z]' ) #convert guess to lowercase

	if [ "$guessLength" -eq 1 ]; then #its a single character
		
		verifycount=0
		
		#write guess to totalguessed array if it doesn't already exist in array
		for i in "${totalguessed[@]}" 
		do
			verifycount=0
			if [ "$i" == "$guess" ]; then
				verifycount=-1 #letter already exists
			fi
		done
		
		#letter hasn't been guessed
		if [ ! "$verifycount" == -1 ]; then #count is not -1
			totalguessed=("${totalguessed[@]}" "$guess")
		fi
		
		#letters has been guessed
		if [ "$verifycount" == -1 ]; then 
			guesses=$((guesses-1))
		else
			pos=`expr index $newword $guess` #search word for the letter guessed 
			#vars
			count=0
			globalpos=0
			if [ "$pos" == 0 ]; then
				guesses=$((guesses-1))
			else
				while [ ! $pos == 0 ]; #find all instances of guess and add to array
				do
					globalpos=$((globalpos + $pos))
					convert=$((globalpos - 1))
					convertplacement=`expr $convert \* 2`
					userguessed[$convertplacement]=$guess
					chopped=${newword:$globalpos} #make new string containing the letters after guess
					choppedLen=${#chopped}
					if [ "$choppedLen" -ge 1 ]; then
						pos=`expr index $chopped $guess` #search chopped for guess
					else 
						pos=0
					fi
				done
			fi
		fi			
	elif [ "$guessLength" -ge 2 ]; then #it's a word being guessed
		if [ "$guess" == "$newword" ]; then #guess is right
			for i in "${totalguessed[@]}"
			do
				count=0
				if [ "$i" == "$guess" ]; then #array already contains the guess
					count=-1
				fi
			done
			if [ ! "$count" == -1 ]; then #array doesn't contain the guess
				totalguessed=("${totalguessed[@]}" "$guess") #add this guess to total guessed
			fi
			#end the game
			gamewon="true" 
			endgame
		else #guess is wrong
			for i in "${totalguessed[@]}"
			do
				count=0
				if [ "$i" == "$guess" ]; then #array already contains the guess
					count=-1
				fi
			done
			if [ ! "$count" == -1 ]; then #array doesn't contain the guess
				totalguessed=("${totalguessed[@]}" "$guess") #add this guess to total guessed
			fi
			#decrement amount of guesses
			guesses=$((guesses-1))
			#return to the game
			gamescreen
		fi
	fi
	
	#check if word is guessed (no more underscores remain)
	containsspace="false"
	for i in "${userguessed[@]}"
	do
		if [ "$i" == "_" ]; then
			containsspace="true"
		fi
	done
	if [ "$containsspace" == "false" ]; then #end the game
		gamewon="true"
		endgame
	else #else, continue playing
		gamescreen
	fi
}

# In-game menu
function gamescreen {
	clear #clear the screen
	#vars
	ingame_usage="Usage: gameMenu a_word OR a_letter OR a_number:1"	
	
	if [ "$show_usage" == "true" ]; then #echo usage clause
		echo "$ingame_usage"
		show_usage="false"
	fi
	
	if [ "$guesses" -ge 1 ]; then # In game menu
		#make a current hangman image
		makehangmanimage
		echo "$hangmanimage"
		echo ""
		echo ""
		echo ${userguessed[@]} #show the current guesses
		if [ "$showtotalguessed" == "true" ]; then
			echo ""
			echo "Guesses so far: ${totalguessed[@]}"
		fi
		echo ""
		echo "You have $guesses guesses remaining"
		echo ""
		echo "(Word, Letter, OR select \"1\" to exit):"
		echo "Make a selection and hit Enter: "
		#for debugging
		#echo $newword
		read guess
		
		guessLength=${#guess}
		
		# Check guess for errors
		#contains a space
		pos=`expr index "$guess" " "`
		if [ ! "$pos" = 0 ]; then
			#show_usage="true"
			gamescreen
		fi
		
		#contains numbers besides 1
		pos=`expr match "$guess" '[0 2-9]'`
		if [ ! "$pos" = 0 ]; then
			#show_usage="true"
			gamescreen 
		fi
		
		#contains a 1 but not as the first character
		pos=`expr match "$guess" 1`
		if [ ! "$pos" = 0 ] && [ ! "$pos" = 1 ] || [ "$pos" = 1 ] && [ "$guessLength" -ge 2 ]; then
			#show_usage="true"
			gamescreen 
		fi
		
		#guess is empty
		if [ "$guessLength" = 0 ]; then
			#show_usage="true"
			gamescreen 
		fi
		
		#if user selected 1
		if [ "$guess" = 1 ]; then #exit
			clear #clear the screen
			echo "Thanks for playing"
			read -t 2
			#return to the start menu
			startmenu 
		fi
		
		#run the guess function
		user_guess 
	
	elif [ "$guesses" -le 0 ]; then # else, go to end of game
		gamewon="false"
		endgame
	fi
}

# Start a new game
function playgame {
	#vars
	totalguessed=()
	show_usage="false"
	guesses=8 #reset guesses
	
	#display loading message
	echo "Loading"

	# Select a word
	RandomDevice=/dev/urandom #generate a random number using /dev/urandom. Max value is the size of the words array
	MaxRand=61173	#count of text file
	[ $# -lt 1 ] && set -- $MaxRand
	hex=`dd if=/dev/urandom bs=1 count=8 2>/dev/null |
		od -tx1 | head -1 | cut -d' ' -f2- |
		tr -d ' ' | tr '[a-f]' '[A-F]'`
	dec=`echo "ibase=16; $hex" | bc`
	number=`echo "$dec % $1 + 1" | bc`

	newword=${WORDS_ARRAY[$number]} #set newword as the word variable
	
	# Make initial guess string
	userguessed=()
	userguessed[0]="_"
	count=0
	count2=0
	thisWORDLENGTH=${#newword}
	
	#make the guess-array loop
	while [ $count -lt $thisWORDLENGTH ]; do
		userguessed[$count2]="_"
		count2=$((count2+1))
		userguessed[$count2]=" "
		count2=$((count2+1))
		count=$((count+1))
	done

	#start game
	gamescreen
}

# Game intro
function intro {
	#vars
	harr=( H a n g m a n ) 
	count=0
	hstring=""
	ustring=""
	showtotalguessed="false" #set show guessed string to false
	WORD_FILE="dictionary.txt"
	count1=0
	
	clear #clear the screen
	echo "Loading" #show a loading message while the dictionary file is being loaded

	WORDS_ARRAY=(`cat "$WORD_FILE"`) # load the dictionary words into array
	
	clear
	
	# intro movie
	while [ "$count" -le 12 ];
	do
		a=`expr "$count" % 2`
		if [ "$a" -eq 0 ]; then
			hstring="$hstring${harr[$count1]}"
			ustring="$ustring-"
			clear
			echo "$hstring"
			echo "$ustring"
			count1=$((count1+1))
		fi
		count=$((count+1)) #increment and repeat
	done
	
	#start the game
	read -t 3 #pause 3 seconds
	startmenu #go to the start menu
}

# Options menu
function options {
	clear #clear the screen
	
	echo "Options Menu:"
	echo "1) Show letters guessed On"
	echo "2) Show letters guessed Off"
	read response #read users choice
	
	if [ "$response" = 1 ]; then
		showtotalguessed="true"
		clear
		echo "Show letter guessed (ON)"
		read -t 2
		startmenu #return to start menu
	elif [ "$response" = 2 ]; then
		showtotalguessed="false"
		clear
		echo "Show letter guessed (OFF)"
		read -t 2
		startmenu #return to start menu
	else #response is not 1 or 2
		options #return to options menu
	fi
}

# Main menu
function startmenu {
	### User interface
	#
	#menu selection
	#usage: 4 choices; if user selects outside the boundaries, reset the screen/ menu - display usage clause
	#
	#
	clear #clear the screen
	
	#vars
	nextstage=0
	menuSelect_usage=1
	streak=0 #reset streak
	mainMenu_usage="Usage: Main Menu: \"1\" OR \"2\" OR \"3\""

	### Menu choices
	# 1) Start
	# 2) Highscore
	# 3) Options
	# 4) Exit
	while [ "$nextstage" -lt 1 ]; #main menu loop
	do
		echo "Main Menu:"
		echo "1) New Game" 
		echo "2) View Highscores"
		echo "3) Options"
		echo "4) Exit"
		if [ "$menuSelect_usage" = -1 ]; then #if error display usage
			echo "$mainMenu_usage"
			menuSelect_usage=1 #reset menuSelect
		fi
		read menuchoice #read users menuchoice
		
		if [ "$menuchoice" = 1 ]; then #startgame
			clear
			nextstage=1
			playgame #start a new game
		elif [ "$menuchoice" = 2 ]; then #highscores
			clear
			nextstage=1
			mainmenu="true"
			displayhighscores
		elif [ "$menuchoice" = 3 ]; then #options
			clear
			nextstage=1
			options
		elif [ "$menuchoice" = 4 ]; then #exit
			clear
			nextstage=1
			echo "Thanks for playing!"
			exit
		else #show usage
			clear
			menuSelect_usage=-1
		fi
	done
}

#-------------------------------------
#program start
#-------------------------------------
intro
