#!/bin/bash -x

PlayerOnePosition=0
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
