#!/bin/bash 
echo "welcome"

declare -a  boardOfGame
function resetingBoard()
{
	
 	for (( position=1 ; position<=9 ; position++ ))
	do
	boardOfGame[$position]=$position;
        
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
	i=0
	for (( counter=1 ; counter<=3 ; counter++ ))
	do
	echo "  |---|---|---| "
	echo "  | "${boardOfGame[$((counter+i))]}" | "${boardOfGame[$((counter+i+1))]}" | "${boardOfGame[$((counter+i+2))]}" |"
	echo "  |---|---|---|"
        i=$(($i+2))
	done
	
}



resetingBoard
tossWinner


 





































































