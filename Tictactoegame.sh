#!/bin/bash -x
echo "welcome"

declare -a  boardOfGame
function resetingBoard()
{
 	for((position=1 ; position<=9 ; position++ ))
	do
	boardOfGame["$position"]=$position;
        
	done
echo :${boardOfGame[@]}


}

function assignedSymbol() 
{
	resetingBoard
	read -p "take lettrer (x or 0) for playing:" playerLetter 
	if [ $playerLetter == x ] || [ $playerLetter == X ]
	then 
	computerLetter=0	
	else
	computerLetter=X
	fi
	}
 	
	assignedSymbol   
