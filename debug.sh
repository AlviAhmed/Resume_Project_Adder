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


checkBlank(){
    if [ -z "$userinp" ];       # if user input is empty
    then
        printf "\n Empty or Repeated Input Please Try Again \n"
        return 1                  # return and loop back to prompt
    else
        printf "\n NON BLANK INPUT: $userinp \n"
        return 0
    fi
}



skillCheck(){
    var="$(checkBlank)"
    if [[ $var && "0" ]];
    then
        printf "\n Condition passed for input:  $userinp \n"
        validateSkillFunc < projects_list.tex 
        return 0
    else
        printf "\n Condition doesn't pass \n"
        return 1
    fi
    
}




validateSkillFunc(){
    printf "\n Start validateSkillFunc \n"
    while read -r data; do
        skillLine=$(awk -v var="$userinp" 'index($0,"Skills Used:") && index($0,var)' $data)
        if [[ "$skillLine" == *'C++'* ]];
        then
            printf " \n Skill: $userinp found! \n"
            echo " Skills line: "
            echo " $skillLine  "
            awk -v var="$skillLine" 'index($0,"Skills Used:") && index($0,"var")' RS="\n\n" ORS="\n\n" projects_list.tex
            # awk -v var="C++" 'BEGIN{print "\n Start \n"; RS="\n\n"; ORS="\n\n";}{/$var/; print $0;}{print "\n DONE \n";}'  projects_list.tex 
        else
            printf "\n Your input: $userinp, is not a valid/listed skill please try again \n"
            return
        fi
    done
}


# validateSkillFunc(){
#     printf "\n Start validateSkillFunc \n"
#     while read -r data; do
#         skillLine=$(sed -n '/Skills Used:/p' projects_list.tex | cut -d'}' -f2) # extracting skills line from each  project
#     done

# }


#  need to be able to escape use sequence





