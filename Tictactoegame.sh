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
resetingBoard
