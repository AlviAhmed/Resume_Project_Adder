#!/bin/bash 
userinp=C++

awk_func(){
    awk -v var="$userinp" 'index($0,var)' RS="\n\n" ORS="\n\n" projects_list.tex > buffer.tex 
}

awk_func

numLines=$(grep $userinp buffer.tex | wc -l) 

if [ "${numLines}" -eq "0" ];
then
    echo "no projects exist for skill: $userinp"
else
    echo "${numLines} projects for skill: $userinp  "
fi






