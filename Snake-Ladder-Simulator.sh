#!/bin/bash -x


PlayerOnePosition=0
WinningPosition=100
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
	local Move=$(PlayOptions)
	CurrentPosition=$(($CurrentPosition+$Move))
	if [ $CurrentPosition -lt 0 ]
	then
		CurrentPosition=0
         fi
	echo $CurrentPosition
}
PlayeroneGame(){
	local CurrentPosition=$1
	while [[ $CurrentPosition -ne $WinningPosition ]]
	do  
		CurrentPosition=$(MovePlayer $CurrentPosition)
		echo $CurrentPosition
	done
	echo "Player wins!"

}
PlayeroneGame
