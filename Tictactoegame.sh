#!/bin/bash -x
echo "welcome"

declare -a  boardOfGame
function resetingBoard()
{
	
 	for (( position=1 ; position<=9 ; position++ ))
	do
	boardOfGame[$position]=$position;
        
	done
    	
	echo $playerSym
 	
}

function tossWinner() 
{	resetingBoard
	read -p "take letter (x or 0) for playing:" playerLetter 
	if [ $playerLetter == x ] || [ $playerLetter == X ]
	then 
	computerLetter="0"	
	else
	computerLetter="X"
	fi
	displayBoard
        echo $playerLetter

	tossCheck=$((RANDOM%2))
	if [ $tossCheck == 1 ]
	then 
	tossCheck1=$pLetter
	else
	tossCheck1=$comLetter
	fi
        
        if [ $tossCheck1 == $pLetter ]
        then
		displayBoard 
		playGame $tossCheck1 $playerLetter $computerLetter
	else
		tossWin="Computer win Toss"
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

function winAtRowsPosition() 
{
	
	i=0
	letter=$1
	resultRow=nextmove
	for((count=1; count<=3 ; count++ ))
	do
	i=$(($i+1))
	if [[ ${boardOfGame[$i]} -eq ${boardOfGame[$i +1]} ]] && [[ ${boardOfGame[$i]} -eq ${boardOfGame[$i + 2]} ]] && [[ ${boardOfGame[$i +2]} -eq $letter ]]
	then
	resultRow="win"
        break
	
	fi
	i=$(($i+2))
	done
	
}

function winAtColumnPosition() 
{
	i=0
	letter=$1
	resultColumn=nextmove
	for((count=1; count<=3 ; count++ ))
	do
	i=$(($i+1))
	if [[ ${boardOfGame[$i]} -eq ${boardOfGame[$i +3]} ]] && [[ ${boardOfGame[$i]} -eq ${boardOfGame[$i + 6]} ]] && [[ ${boardOfGame[$i +6]} -eq $letter ]]
	then
	resultColumn="win"
	break
	fi
	i=$(($i+1))
	echo $resultColumn
	done
}

function winAtDiagonal() 
{
	
	letter=$1
	resultDiagonal=nextmove
	i=1
	if [[ ${boardOfGame[$i]} -eq ${boardOfGame[$i +4]} ]] && [[ ${boardOfGame[$i]} -eq ${boardOfGame[$i+8]} ]] && [[ ${boardOfGame[$i +8]} -eq $letter ]]
	then
	resultDiagonal="win"
	break
	elif [[ ${boardOfGame[$i+2]} -eq ${boardOfGame[$i +4]} ]] && [[ ${boardOfGame[$i+2]} -eq ${boardOfGame[$i+6]} ]] && [[ ${boardOfGame[$i +6]} -eq $letter ]]
	then
	resultDiagonal="win"
	fi
	echo $resultDiagonal
}


function playGame() 
{	turn=$2
	playNext=nextmove
	
	while [ $playNext == nextmove ]
	do
		read -p "enter the cell:" position
		echo $position
 	if [[ ${boardOfGame[$position]} == $2 ]] || [[ ${boardOfGame[$position]} == $3 ]]
	then
	echo "player Win"
		playNext=nextmove
	else
		boardOfGame[$position]=$2
		displayBoard
		
		playNext="$( checkWinTieOrTurnChange $turn )"
	fi
	done
 
}

 function checkWinTieOrTurnChange() 
{	resulTurn=$1
	rowResult="$(winAtRowsPosition $2)"
	columnResult="$(winAtColumnPosition $2)"
	diagonalsResult="$(winAtDiagonal $2)"
	if [[ $rowResult == "win" ]] || [[ $columnResult == "win" ]] || [[ $diagonalsResult == "win" ]]
	then
		flag="win"
	else
		resultOfTie="$(tieResult)"		
		if [ $resultOfTie == nextmove ]
		then
			flag=nextmove
		fi
	fi
	echo $flag
}

 function tieResult() 
{
	i=1
	resultOfTie=tie
	if [ ${boardOfGame[$i]} == 1 ] || [ ${boardOfGame[$i+1]} == 2 ] ||  [ ${boardOfGame[$i+2]} == 3 ] || [ ${boardOfGame[$i+3]} == 4 ] || [ ${boardOfGame[$i+4]} == 5 ] || [ ${boardOfGame[$i+5]} == 6 ] || [ ${boardOfGame[$i+6]} == 7 ] || [ ${boardOfGame[$i+7]} == 8 ] || [ ${boardOfGame[$i+8]} == 9 ]
	then
	resultOfTie=nextmove
	fi
	 echo $resultOfTie
}



tossWinner


 
