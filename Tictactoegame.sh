#!/bin/bash -x
echo "welcome"

declare -a  boardOfGame
function resetingBoard()
{
	
 	for((position=1 ; position<=9 ; position++ ))
	do
	boardOfGame["$position"]=$position;
        
	done
	displayBoard

     assignedSymbol

}

function assignedSymbol() 
{
	
	read -p "take lettrer (x or 0) for playing:" playerLetter 
	if [ $playerLetter == x ] || [ $playerLetter == X ]
	then 
	computerLetter='0'	
	else
	computerLetter='X'
	fi
      echo "player get:"$playerLetter
	}
 	
	 

function tossWinner() 
{	

	tossCheck=$((RANDOM%2))
	if [ $tossCheck -eq 1 ]
	then 
	tossCheck=$playerLetter
	else
	tossCheck=$computerLetter
	fi
        
        if [ $tossCheck == $playerLetter ]
        then
	read -p "enter the cell position" cellPosition
	boardOfGame[$cellPosition]=$playerLetter
	displayBoard 
	fi
}



function displayBoard()
{	
	
	echo "  |---|---|---| "
	echo "  | "${boardOfGame[1]}" | "${boardOfGame[2]}" | "${boardOfGame[3]}" |"
	echo "  |---|---|---|"
	echo "  | "${boardOfGame[4]}" | "${boardOfGame[5]}" | "${boardOfGame[6]}" |"
	echo "  |---|---|---|"		
	echo "  | "${boardOfGame[7]}" | "${boardOfGame[8]}" | "${boardOfGame[9]}" |"       
        echo "  |---|---|---|"
}



resetingBoard
tossWinner

