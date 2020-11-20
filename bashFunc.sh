#!/bin/bash 
awkFunc(){
    tmpFile=$(mktemp) || exitFunc
    awk -v var="$userinp" 'index($0,var)' RS="\n\n" ORS="\n\n" projects_list.tex > buffer.tex 
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

