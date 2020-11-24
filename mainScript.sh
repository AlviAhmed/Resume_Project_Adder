#!/bin/bash 
. bashFunc.sh                   

trap cleanupFunc EXIT

resStoreCheckFunc
name="Alvi Ahmed"
read -p "Enter name of company: " comp
read -p "Enter name of position: " pos
resDirFunc
while :
do      
    read -p "Enter Skill: " userinp
    echo ""
    awkFunc
    lvlFunc
    numLines=$(grep $userinp buffer.tex | wc -l) 

    if [ "${numLines}" -eq "0" ];
    then
        echo "No projects exist for skill: $userinp"
    else
        echo "Project(s) exist for this skill: $userinp  "
    fi

    echo "To exit script press <CTRL+C>"

done

