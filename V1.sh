#!/bin/bash 
userinp=C++
awk_func(){
    awk -v var="$userinp" 'index($0,var)' RS="\n\n" ORS="\n\n" projects_list.tex > buffer.tex 
}
numLines=$(grep $userinp projects_list.tex | wc -l) 

if [ "${numLines}" -eq "0" ];
then
    echo "no projects exist for skill: $userinp"
else
    echo "${numLines} projects for skill: $userinp  "
    awk_func # Running the function
fi






