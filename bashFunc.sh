#!/bin/bash


resStoreCheckFunc(){            # this function is in charge of creating the main resume storage and checking its existence
    
    DIR="resume_storage"        
    if [ -d "$DIR" ];           
    then
        printf "Directory already exists....clear \n"
    else                        
        printf "Directory DOES NOT exist making one right now... \n"
        mkdir $DIR
    fi
}

resDirFunc(){                   
    comp=$(echo $comp | sed -e "s/ /\_/g") 
    pos=$(echo $pos | sed -e "s/ /\_/g")
    name=$(echo $name | sed -e "s/ /\_/g")
    dirname=$DIR\/$comp\_$pos   
    mkdir $dirname              
    filename=$dirname\/$name\_$comp\_$pos.tex 
    touch $filename                           
    cat resume.tex > $filename                
}





mainCondFunc(){     # this function deals with whether or not to run the skill checker functions based on user input
    printf "\n Creating tmp file \n"    
    tmpFile=$(mktemp) || exitFunc
    if [ -z "$userinp" ];       
    then
        printf "\n Empty or Repeated Input Please Try Again \n"
        return                  
    else
        repeatSkillCheck
    fi
    
}

awkFunc(){
    printf "\n Starting Awk Function \n"
    awk -v varinp="$userinp" ' BEGIN{
    lines=0; 
    RS=ORS="\n\n"; 
    FS="\n"; 
    a=0; 
} 
{ 
    if (NF > 0){ 
        var=$(NF - 1); 
    } 
    else{ 
        var=$NF; 
    } 
    if ( (index(var,varinp)) ) {   
          print $0;
    }  
}' projects_list.tex >> placeholder.tex
}

repeatProj(){
    awk 'BEGIN{  
    RS=ORS="\n\n";
    FS="\n";
}  
 NR==FNR{a[$4]++; next} {if (a[$4] > 1){a[$4]--;} else{print $0;} }' placeholder.tex placeholder.tex 
}

repeatSkillCheck(){             
    printf "\n Starting Skill Repeater Checker Function \n"
    skillExist=$(grep $userinp skills | wc -l)
    if [ "${skillExist}" -eq 0 ];              
    then                                       
        printf "\n Inputting: $userinp into skills buffer \n"
        echo "$userinp" >> skills
        awkFunc
    else                       
        printf "Skill: $userinp, already inputted \n"
        return                  
    fi
}


lvlFunc(){                      # This function deals organizing priority projects into correct file
    arrayLvl=(A B C)            # Priority A, B, C
    for i in ${arrayLvl[@]}; do 
        lvlVal="Pr:"$i          
        fileVal="buffer"$i".tex" 
        awk -v var="$lvlVal" 'index($0,var)' RS="\n\n" ORS="\n\n" buffer.tex >> $fileVal # getting 
    done
}

lvlCleaner(){                   # gets rid of the priority tags in the final resume
    sed -i '/Pr:/d' $filename
}

# emptyCheck(){
#     var=$(grep textbf buffer.tex | wc -l)
#     if [ "$var" -eq "0" ];
#     then
#         cat placeholder.tex > buffer.tex
#     else
#         repeatProj > buffer.tex
#     fi
# }

sedFunc(){
    arrayLvl=(C B A)            
    for i in ${arrayLvl[@]}; do
        fileVal="buffer"$i".tex"
        printf "Inserting project into file"
        sed -i "/Projects Start/r $fileVal" $filename 
        echo " " > $fileVal                            
    done
    cat /dev/null > skills 
    cat /dev/null > placeholder.tex
    # cat /dev/null > buffer.tex

}

cleanupFunc(){                  # Function deals with final process when user done with script
    echo "Checking for Repeat Projects in Placeholder"
    repeatProj > buffer.tex
    echo "Adding projects to File"
    lvlFunc
    echo "Adding to $filename file" 
    sedFunc                     # Runs the sed function 
    echo "Removing tmp file"    
    rm -f $tmpFile              # removes temp file

}
exitFunc() {                    # exit function for tmp file if it could not be created
    echo "Couldn't make temp file"
    exit 1    
}


