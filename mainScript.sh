#!/bin/bash 
. bashFunc.sh                   # header files that contains the awk function

trap cleanupFunc EXIT


while :

do      
    read -p "Enter Skill: " userinp
    echo ""
    awkFunc
    # lvlFunc
    # sedFunc
    
    numLines=$(grep $userinp buffer.tex | wc -l) 

    if [ "${numLines}" -eq "0" ];
    then
        echo "no projects exist for skill: $userinp"
    else
        echo "${numLines} projects for skill: $userinp  "
    fi

    echo "To exit script press <CTRL+C>"

done

