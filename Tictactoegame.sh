#!/bin/bash -x
echo "welcome"
flag=0
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
	result=$1
	for((count=1; count<=3 ; count++ ))
	do
	i=$(($i+1))
	if [[ ${boardOfGame[$i]} -eq ${boardOfGame[$i +1]} ]] && [[ ${boardOfGame[$i]} -eq ${boardOfGame[$i + 2]} ]] && [[ ${boardOfGame[$i +2]} -eq $letter ]]
	then
	echo "player Win"
        break
	flag=1
	fi
	i=$(($i+2))
	done
	
}

function winAtColumnPosition() 
{
	i=0
	letter=$1
	result=$2
	for((count=1; count<=3 ; count++ ))
	do
	i=$(($i+1))
	if [[ ${boardOfGame[$i]} -eq ${boardOfGame[$i +3]} ]] && [[ ${boardOfGame[$i]} -eq ${boardOfGame[$i + 6]} ]] && [[ ${boardOfGame[$i +6]} -eq $letter ]]
	then
	echo "player win"
	break
	fi
	i=$(($i+1))
	done
}

function winAtDiagonal() 
{
	i=0
	letter=$1
	for((count=1 ; count<=2 ; count++))
	do
	i=$(($i+1))
	if [[ ${boardOfGame[$i]} -eq ${boardOfGame[$i +4]} ]] && [[ ${boardOfGame[$i]} -eq ${boardOfGame[$i+8]} ]] && [[ ${boardOfGame[$i +8]} -eq $letter ]]
	then
	echo "player win"
	break
	elif [[ ${boardOfGame[$i]} -eq ${boardOfGame[$i +4]} ]] && [[ ${boardOfGame[$i]} -eq ${boardOfGame[$i+8]} ]] && [[ ${boardOfGame[$i +8]} -eq $letter ]]
	then
	echo "player win"
}


function playGame() 
{	
	playNext=1
	while [ $playNext == 1 ]
	do
		read -p "enter the cell:" position
		echo $position
 	if [[ ${boardOfGame[$position]} == $2 ]] || [[ ${boardOfGame[$position]} == $3 ]]
	then
	echo "player Win"
		playNext=0
	else
		boardOfGame[$position]=$2
		displayBoard
		
		if [[ $flag == 1 ]]
		then 
		echo "player win"
		fi
	fi
	done
 
}

 function checkWinTieOrTurnChange() 
{
	winAtRowsPosition $1
	winAtColumnPosition $1
	winAtDiagonal $1

}

tossWinner


 
