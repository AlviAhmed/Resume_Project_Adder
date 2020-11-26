#!/bin/bash


resStoreCheckFunc(){            # this function is in charge of creating the main resume storage and checking its existence
    
    DIR="resume_storage"        # creating a generic directory to store all generated resumes
    if [ -d "$DIR" ];           # if directory exists
    then
        printf "Directory already exists....clear \n"
    else                        # if directory doesn't exist, make one
        printf "Directory DOES NOT exist making one right now... \n"
        mkdir $DIR
    fi
}

resDirFunc(){                   # this function deals with making the directories and files for the new resumes
    
    comp=$(echo $comp | sed -e "s/ /\_/g") # replacing spaces with underscores in the variables comp, pos, and name
    pos=$(echo $pos | sed -e "s/ /\_/g")
    name=$(echo $name | sed -e "s/ /\_/g")
    dirname=$DIR\/$comp\_$pos   # creating the directory that houses the tex document, it is resume_storage/companyname_positionname
    mkdir $dirname              # make the directory
    filename=$dirname\/$name\_$comp\_$pos.tex # defining filename which is name_company_position and the a .tex
    touch $filename                           # create the blank file
    cat resume.tex > $filename                # copy a blank template of the resume into the newly created file
}

skillCheckerFunc(){             # this function deals with checking if same skill inputted twice
    skillExist=$(grep $userinp skills | wc -l) # checking the skills the user inputted against skills list
    if [ "${skillExist}" -eq 0 ];              # checks how many matches between user input and file
    then                                       # if no matches, then unique skill, proceed to next function
        echo "Inputting: $userinp into skills buffer \n"
        echo "$userinp" >> skills
        awkFunc
    else                        # if there are matches, then that means user inputted skill twice, will make userinp equal to null so
        printf "Skill: $userinp, already inputted \n"
        return                  # return and loop back to read prompt
    fi
}

mainCondFunc(){     # this function deals with whether or not to run the skill checker functions based on user input
    
    printf "Making tmp file"    # Tmp file and tmp file functions for testing, will later implement
    tmpFile=$(mktemp) || exitFunc
    if [ -z "$userinp" ];       # if user input is empty
    then
        printf "Empty or Repeated Input Please Try Again \n"
        return                  # return and loop back to prompt
    else
        skillCheckerFunc        # else if not empty go on to the next function
    fi
}

awkFunc(){                      # This is the main function that deals with selecting the projects from list that match with user input

    # using awk to find paragraphs with matching patterns
    # later inputting them into placehold.tex, NOTE: will change this soon, placehold will not be needed in the future
    
    awk -v var="$userinp" 'index($0,"Skills Used:") && index($0,var)' RS="\n\n" ORS="\n\n" projects_list.tex > placehold.tex
    nameFunc < placehold.tex    # making placehold.tex an input to another function, nameFunc
    
    if [ "${boolVar}" -eq "0" ]; # if the boolVar from nameFunc is 0, means no projects of the same name
    then
        printf "\n Inputting project into buffer \n"
        cat placehold.tex > buffer.tex
        echo "" > placehold.tex
        echo "$placeholdVar" >> name_list
        lvlFunc
    else
        printf "\n Project already exists in resume \n"
        echo "" > placehold.tex
    fi
    # numSkill=$(cat name_list | wc -l) 
    # printf " \n Number of projects in resume: $numSkill \n"
}

nameFunc(){                     # This function makes sure that projects of the same name are not inputted into resume
    
    while read -r data; do      # while reading data from inputted file (i.e. placehold.tex)
        placeholdVar=$(sed -n '/^\\textbf/p' $data | cut -d'{' -f2 | cut -d':' -f1) # extracting names from each project in placehold
        echo "$placeholdVar"
        echo "$placeholdVar" | wc -l
        echo cat name_list | grep "$placeholdVar"
        boolVar=$(cat name_list | grep  "$placeholdVar" | wc -l) # searching for projects of same name in resume
        echo "hello"
        echo $boolVar
        
    done
}


lvlFunc(){                      # This function deals organizing priority projects into correct file
    arrayLvl=(A B C)            # Priority A, B, C
    for i in ${arrayLvl[@]}; do 
        lvlVal="Pr:"$i          # Pr:A, Pr:B, Pr:C
        fileVal="buffer"$i".tex" # bufferA.tex, bufferB.tex, bufferC.tex
        awk -v var="$lvlVal" 'index($0,var)' RS="\n\n" ORS="\n\n" buffer.tex >> $fileVal # getting priority projects and putting in its corresponding buffer
    done
}

lvlCleaner(){                   # gets rid of the priority tags in the final resume
    sed -i '/Pr:/d' $filename
}

sedFunc(){                      # this function deals with inputting the accumulated projects from each priority buffer and inputting them into the resume
    arrayLvl=(C B A)            # reversed since sed inputs below the specified line, therefore C projects will go first, then B above and finally A above 
    for i in ${arrayLvl[@]}; do
        fileVal="buffer"$i".tex"
        printf "Inserting project into file"
        sed -i "/Projects Start/r $fileVal" $filename # this line inputs them below the line Projects Start in the resume
        echo "" > $fileVal                            # clear the buffer once done
    done
    # Clearing all the buffer files 
    echo "" > buffer.tex
    echo "" > skills 
    echo "" > placehold.tex
    echo "" > name_list
}

cleanupFunc(){                  # Function deals with final process when user done with script
    echo "Adding to $filename file" 
    sedFunc                     # Runs the sed function 
    echo "Removing tmp file"    
    rm -f $tmpFile              # removes temp file

}
exitFunc() {                    # exit function for tmp file if it could not be created
    echo "Couldn't make temp file"
    exit 1    
}


