#!/bin/bash -x
echo "welcome"

declare -a  boardOfGame
function resetingBoard()
{
	
 	for (( position=1 ; position<=9 ; position++ ))
	do
	boardOfGame[$position]=$position;
        
	done
    	
	echo $playerSymbol
 	
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
	tossCheck1=$playerLetter
	else
	tossCheck1=$computerLetter
	fi
        
        if [ $tossCheck1 == $playerLetter ]
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
	winnerFound=false;
	local rowCount=0
	for (( count=1; count<=3; count++ ))
	do
		rowCount=$(( $rowCount+1 ))
		if [[ ${boardOfGame[$rowCount]} == ${boardOfGame[$rowCount+1]} ]] && [[ ${boardOfGame[$rowCount+1]} == ${boardOfGame[$rowCount+2]} ]]
		then
			winnerFound=true;
			break;
		else
			rowCount=$(( $rowCount+2 ))
		fi
	done
	echo $winnerFound
}



function winAtColumnPosition() 
{
	local columCount=0;
	local winnerFound=false;
	for (( count=1; count<=3; count++ ))
	do
		columCount=$(( $columCount+1 ))
		if [[ ${boardOfGame[$columCount]} == ${boardOfGame[$columCount+3]} ]] && [[ ${boardOfGame[$columCount+3]} == ${boardOfGame[$columCount+6]} ]]
		then
			winnerFound=true;
			break;
		fi
	done
	echo $winnerFound

}

function winAtDiagonalPosition() 
{
	
	local winnerFound=false
	for (( count=1; count<=3; count++ ))
	do
		if [[ ${boardOfGame[$count]} == ${boardOfGame[$count+4]} ]] && [[ ${boardOfGame[$count+4]} == ${boardOfGame[$count+8]} ]]
		then
			winnerFound=true;
			break;
		elif [[ ${boardOfGame[$count+2]} == ${boardOfGame[$count+4]} ]] && [[ ${boardOfGame[$count+4]} == ${boardOfGame[$count+6]} ]]
		then
			winnerFound=true;
			break;
		fi
	done
	echo $winnerFound;
	
}


function playGame() {
	playNext=0
	turn=$2
	computerPlay=play
	playerPlay=play
	winnerFound1=false
	while [ $playNext == 0 ]
	do
		playerPlay="play"
		while [ $playerPlay == play ]
		do
			read -p "Enter the Cell Number" position
			boardOfGame[$position]=$2 
			displayBoard
			winnerFound="$( checkWinTieOrTurnChange $2 )"
			playerPlay=stop				
			if [ $winnerFound == true ]
			then
				echo "PLAYER WON"
				break
			fi
		
		done
		if [ $winnerFound == true ]
		then
			break
		fi
		computerPlay="play"
		while [ $computerPlay == play ] 
		do
			computerPosition="$( possiblityForWinning $1 $2 $3 )"
			winnerFound1=false
			if [ ${boardOfGame[$computerPosition]} == $computerPosition ]
			then
				boardOfGame[$computerPosition]=$3
				displayBoard
				winnerFound1="$( checkWinTieOrTurnChange $3 )"
				computerPlay=stop
			fi
			if [ $winnerFound1 == true ]
			then
				echo "COMPUTER WON"
				break
			fi
		done  
		echo "WinnerFound==================>"$winnerFound1	
		if [ $winnerFound1 == true ]
		then
			break
		fi
	done

}

function possiblityForWinning(){
	rowPosition="$( winnerAtRow $1 $2 $3)"
	columnPosition="$( winnerAtColumn $1 $2 $3 )"
	diagonalPosition="$( winnerAtDiagonal $1 $2 $3 )"
	cornerPosition="$( winnerAtcorner $1 $2 $3 )"
	centerPosition="$( winnerAtCenter $1 $2 $3 )"
	if [[ $rowPosition -gt 0 ]]
	then
		randomPosition=$rowPosition
		replacePosition=0;
	elif [[ $columnPosition -gt 0 ]]
	then

		randomPosition=$columnPosition
		replacePosition=0;
	elif [[ $diagonalPosition -gt 0 ]]
	then

		randomPosition=$diagonalPosition
		replacePosition=0;
	
	else	
		randomPosition=$cornerPosition
		replacePosition=0;	
	fi
	echo $randomPosition
}

 function checkWinTieOrTurnChange() 
{	rowResult="$(winAtRowsPosition $1 $2 $3)"
	columnResult="$(winAtColumnPosition $1 $2 $3)"
	diagonalsResult="$(winAtDiagonalPosition $1 $2 $3)"
	flag=false
	if [[ $rowResult == true ]] || [[ $columnResult == true ]] || [[ $diagonalsResult == true ]]
	then
		flag=true
	#else
		#resultOfTie="$(tieResult)"		
		#if [ $resultOfTie == nextmove ]
		#then
			#flag=false
		#else
			#flag=false
		#fi
	fi
	echo $flag
}

function winnerAtCenter(){
	 if [[ ${boardOfGame[5]} -ne $playerLetter ]] || [[ ${boardOfGame[5]} -ne $computerLetter ]]
         then
		replyPosition=5;
         fi
	echo $replyPosition
}

function winnerAtcorner(){
	local count=1;
	local playerLetter=$2
	local computerLetter=$3
	replyPosition=0
	for (( counter=1; counter<=2; counter++ ))
	do
		if [[ ${boardOfGame[$count]} -ne $computerLetter ]] && [[ ${boardOfGame[$count]} -ne $playerLetter ]]
		then
			replyPosition=$count
		elif [[ ${boardOfGame[$count+2]} -ne $computerLetter ]] && [[ ${boardOfGame[$count+2]} -ne $playerLetter ]]
		then
			replyPosition=$(( $count+2 ))
		fi
			count=$(( $count+6 ))
		
	done
	echo $replyPosition
}


function winnerAtRow(){
	local computerLetter=$3
	local playerLetter=$2
	local row=1;
	local winnerFound=false;
	for (( count=1; count<=3; count++ ))
	do
		
		if [[ ${boardOfGame[$row]} == ${boardOfGame[$row+1]} ]] || [[ ${boardOfGame[$row+1]} == ${boardOfGame[$row+2]} ]] || [[ ${boardOfGame[$row+2]} == ${boardOfGame[$row]} ]]
		then
			for (( counter=$row; counter<=$row+2; counter++ ))
			do
				if [[ ${boardOfGame[$counter]} -ne $computerLetter ]] || [[ ${boardOfGame[$counter]} -ne $playerLetter ]]
				then
					replacePosition=$counter
				fi
			done
		else
			row=$(( $row+1 ))
		fi
	done
	echo $replacePosition
}

function winnerAtColumn(){
	local playerLetter=$2
	local computerLetter=$3
	local column=1;
	local winnerFound=false;
	for (( count=1; count<=3; count++ ))
	do
		
		if [[ ${boardOfGame[$column]} == ${boardOfGame[$column+3]} ]] || [[ ${boardOfGame[$column+3]} == ${boardOfGame[$column+6]} ]] || [[ ${boardOfGame[$column+6]} == ${boardOfGame[$column]} ]] 
		then
			for (( counter=1; counter<=3 ;counter++ ))
			do
				if [[ ${boardOfGame[$column]} -ne $computerLetter ]] || [[ ${boardOfGame[$column]} -ne $playerLetter ]] 
				then
					replacePosition=$counter
				fi
				column=$(( $column+3 ))
			done
		fi
	done
	echo $replacePosition
}

function winnerAtDiagonal() {
	local playerLetter=$2
	local computerLetter=$3
	#local diagCount=1;
	local count=1;
	local winnerFound=false;
	if [[ ${boardOfGame[$count]} == ${boardOfGame[$count+4]} ]] || [[ ${boardOfGame[$count+4]} == ${boardOfGame[$count+8]} ]] || [[ ${boardOfGame[$count+8]} == ${boardOfGame[$count]} ]]
	then
		for (( counter=1; counter<=3; counter++ ))
		do
			if [[ ${boardOfGame[$count]} -ne $computerLetter ]] || [[ ${boardOfGame[$count]} -ne $playerLetter ]]
			then
				replacePosition=$count
			fi
			count=$(( $count+4 ))
		done
	elif [[ ${boardOfGame[$count+2]} == ${boardOfGame[$count+4]} ]] || [[ ${boardOfGame[$count+4]} == ${boardOfGame[$count+6]} ]] || [[ ${boardOfGame[$count+6]} == ${boardOfGame[$count+2]} ]]
	then
		for (( counter=1; counter<=3; counter++ ))
		do
			count=$(( $count+2 ))
			if [[ ${boardOfGame[$count]} -ne $computerLetter ]] || [[ ${boardOfGame[$count]} -ne $playerLetter ]]
			then
				replacePosition=$count
			fi
		done
	fi
	echo $replacePosition
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

