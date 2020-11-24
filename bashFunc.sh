#!/bin/bash

direcFunc(){
    comp=$(echo $comp | sed -e "s/ /\_/g")
    pos=$(echo $pos | sed -e "s/ /\_/g")
    name=$(echo $name | sed -e "s/ /\_/g")
    dirname=$comp\_$pos
    mkdir $dirname
    filename=$dirname\/$name\_$comp\_$pos.tex
    touch $filename
    cat resume.tex > $filename
}

awkFunc(){
    tmpFile=$(mktemp) || exitFunc
    awk -v var="$userinp" 'index($0,var)' RS="\n\n" ORS="\n\n" projects_list.tex > buffer.tex 
}

# var=$(echo $pos | sed -e "s/ /\_/g")



lvlFunc(){
    arrayLvl=(A B C)
    for i in ${arrayLvl[@]}; do
        lvlVal="Pr:"$i
        fileVal="buffer"$i".tex"
        awk -v var="$lvlVal" 'index($0,var)' RS="\n\n" ORS="\n\n" buffer.tex >> $fileVal
    done
}

lvlCleaner(){
    sed -i '/Pr:/d' $filename
}

sedFunc(){
    arrayLvl=(C B A)
    for i in ${arrayLvl[@]}; do
        fileVal="buffer"$i".tex"
        sed -i "/Projects Start/r $fileVal" $filename
        echo "" > $fileVal
        done
}

cleanupFunc(){
    echo "Adding to $filename file"
    sedFunc
     echo "Removing tmp file"
    rm -f $tmpFile

}
exitFunc() {
    echo "Couldn't make temp file"
    exit 1    
}

