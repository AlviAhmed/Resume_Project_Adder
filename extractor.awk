#!/bin/awk -f


BEGIN{
    printf ("\n BEGINNING of Script \n");
    lines=0;
    currLine = 0;
    skillLine[lines];
    RS=ORS="\n\n";
    FS="\n";
}
{
    printf ("\n Line Number %d \n", NR);
    if (NF > 0){
        var=$(NF - 1);
    }
    else{
        var=$NF;
    }
    if ( ((var ~ /Control/)) ){
        print $0;
    }
}
END{
    printf ("\n END of Script \n");
}

