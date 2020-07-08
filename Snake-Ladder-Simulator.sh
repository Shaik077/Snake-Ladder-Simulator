#!/bin/bash -x


CurrentPositionPlayerOne=0
CurrentPositionPlayerTwo=0
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

TwoPlayers()
{
	while [[ $CurrentPositionPlayerOne -lt $WinningPosition ]] && [[ $CurrentPositionPlayerTwo -lt $WinningPosition ]]
   do
       Chance=$((PlayerChance%2))
	if(($Chance==0))
	then
             CurrentPositionPlayerOne=$(MovePlayer $CurrentPositionPlayerOne)
             echo "CurrentPositionPlayerOne":$CurrentPositionPlayerOne
                     ((CountRollDice++))
         else
             CurrentPositionPlayerTwo=$(MovePlayer $CurrentPositionPlayerTwo)
             echo "CurrentPositionPlayerTwo":$CurrentPositionPlayerTwo
                            ((CountRollDice++))
          fi
        PlayerChance=$((PlayerChance+1))
   done
}

function WhoWin()
{
      TwoPlayers
        if [[ $CurrentPositionPlayerOne -eq $WinningPosition ]]
      then
         echo "PlayerOneWon "
      break
      else
         echo "PlayerTwoWon "
      break
      fi
}
WhoWin
echo "CountRollDice": $CountRollDice
