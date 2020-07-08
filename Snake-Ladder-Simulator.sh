#!/bin/bash -x


PlayerOnePosition=0
PlayerTwoPosition=0
WinningPosition=100
Start=0
CountRollDice=0
RollDice(){
	local Roll=$((RANDOM%6+1))
	echo $Roll
}
PlayOptions(){
	local NO_PLAY=0
	local LADDER=1
	local SNAKE=2
	local Roll=$(RollDice)
	local option=$((RANDOM%3))
	local move=-1
	case $option in
		$NO_PLAY) 
			Move=0
			;;

		$LADDER) 
			Move=$Roll
			;;
		   
		$SNAKE)
			Move=-$Roll
			;;
	esac
	echo $Move
}
PlayOptions
MovePlayer(){
	local CurrentPosition=$1
        PreviousValue=$CurrentPosition
	local Move=$(PlayOptions)
	CurrentPosition=$(($CurrentPosition+$Move))
	if [ $CurrentPosition -lt $Start ]
	then
		CurrentPosition=0
        elif [ $CurrentPosition -gt $WinningPosition ]
          then
                CurrentPosition=$PreviousValue
         fi
	echo $CurrentPosition
}
PlayeroneGame(){
	local CurrentPosition=$1
	while [[ $CurrentPosition -lt $WinningPosition ]]
	do  
		CurrentPosition=$(MovePlayer $CurrentPosition)
		echo "CurrentPosition" : $CurrentPosition
                        ((CountRollDice++))
	done
	echo "Player wins!"  "CountRollDice": $CountRollDice
}
TwoPlayerGame(){
        local player1=$1 
	local player2=$2
	while [ $player2 -ne 100 ]
	do  
		player1=$(MovePlayer $player1)
		echo "Player1 position = $player1"
		if [ $player1 -eq 100 ]
		then
			break
		fi
		player2=$(MovePlayer $player2)
		echo "Player2 position = $player2"
	done
	if [ $player1 -eq 100 ]
	then
		echo "Player1 wins"
	else
		echo "Player2 wins"
	fi
}
TwoPlayerGame "PlayerOnePosition" :$PlayerOnePosition   "PlayerTwoPosition": $PlayerTwoPosition
