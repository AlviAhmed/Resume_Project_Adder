#!/bin/bash 
. bashFunc.sh

trap cleanupFunc EXIT

resStoreCheckFunc
name="Alvi Ahmed"
comp="Google"
pos="Engineering"
# read -p "Enter name of company: " comp
# read -p "Enter name of position: " pos
resDirFunc
while :
do      
    read -p "Enter Skill: " userinp
    mainCondFunc
    echo "To exit script press <CTRL+C>"

done

