#!/bin/bash
awkFunc(){
    tmpFile=$(mktemp) || exitFunc
    awk -v var="$userinp" 'index($0,var)' \
        RS="\n\n" ORS="\n\n" \
        projects_list.tex | cat | \
    awk -F':' '/^Pr/{print  $2}'
}
lvlFunc(){
    arrayLvl=(A B C)
    for i in ${arrayLvl[@]}; do
        lvlVal="Pr:"$i
        fileVal="buffer"$i".tex"
        awk -v var="$lvlVal" 'index($0,var)' RS="\n\n" ORS="\n\n" buffer.tex > $fileVal
        done
}

sedFunc(){
    
    sed -i '/Projects Start/r buffer.tex' resume.tex 
}

cleanupFunc(){
    echo "Removing tmp file"
    rm -f $tmpFile

}
exitFunc() {
    echo "Couldn't make temp file"
    exit 1    
}

