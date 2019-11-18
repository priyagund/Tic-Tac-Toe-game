function winAtRows()
{
	local count=1;
	playerCount=1
	computerCount=1
	while [ $winCount -eq true ]
	for (( i=1; i<=3; i++ ))
	do
	if [[ $computerCount -eq 1 ]] || [[ $playerCount -eq 1 ]]
	then
        	if [[ ${boardOfGame[$count]} == ${boardOfGame[$count+1]} ]] 
		&& [[ ${boardOfGame[$count+1]} == ${boardOfGame[$count+2]} ]]  
		&& [[ ${boardOfGame[$count+2]} == $PlayerLetter ]]
        	then
            	winCount=true;
            	echo"Player Win"
            	break;
        	else
           	count=$(($count+3))
        	fi
    		fi
  	done
	done
}

