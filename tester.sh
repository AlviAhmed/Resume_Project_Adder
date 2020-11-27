#!/bin/bash



sameProj="Bank"
nameFunc(){                     
    printf "\n Starting Name Function \n \n"
    name="ProjC"
    while read -r line; do
        numLeft=$(grep $line placehold.tex | wc -l)
        if [ "$numLeft" -gt "1" ];
        then
            printf "\n $line IS REPEATING \n"
            repeatDelete
        else
            printf "\n $line is not repeating \n"
        fi
    done < name_list

}

repeatDelete(){
    while [ "$numLeft" -gt "1" ];do
        echo "$(awk -v var="$line" '!index($0,var) || f++'  placehold.tex)" > placehold.tex # deleting projects 1 by 1
        numLeft=$(grep $line placehold.tex | wc -l)
    done 
}

nameFunc



# nameFunc(){                     
#     printf "\n Starting Name Function \n \n"
#     placeholdVar=$(sed -n '/^\\textbf/p' placehold.tex | cut -d'{' -f2 | cut -d':' -f1)
#     while read -r line; do
#         printf "\n Line: $line \n"
#         echo "$(awk -v var="$line" '!index($0,var)' RS="\n\n" ORS="\n\n" placehold.tex)" > placehold.tex # deleting paragraphs in place
#     done < name_list
# }


# userinp=""
# validateSkillFunc(){
#     printf "\n start valid func \n"
#     while read -r data; do
#         skillLine=$(sed -n '/Skills Used:/p' $data | cut -d'}' -f2) # extracting skills from each  project
#         printf " \n $skillLine \n "
#         if [[ "$skillLine" =~ .*"$userinp".* ]];
#         then
#             printf " \n Skill: $userinp found! \n"
#             $data > placehold.tex 
#         else
#             printf "\n Your input: $userinp, is not a skill please try again \n"
#             return
#         fi

#     done
# }

# awkFunc(){
#     echo "" > placehold.tex
#     printf "\n start awk func \n"
#     awk -v var="$userinp" 'index($0,"Skills Used:") && index($0,var)' RS="\n\n" ORS="\n\n" projects_list.tex > placehold.tex
#     validateSkillFunc < placehold.tex 
# }


# awkFunc
