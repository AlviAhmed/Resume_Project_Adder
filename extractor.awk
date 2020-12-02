#!/bin/awk -f


BEGIN{
    printf ("\n BEGINNING of Script \n");
    lines=0;
    RS=ORS="\n\n";
    FS="\n";
    userinput=userinp;
}
{
    printf ("\n Line Number %d \n", NR);
    if (NF > 0){
        var=$(NF - 1);
    }
    else{
        var=$NF;
    }
    if ( ((index(var,"userinput"))) ){
        print $0;
        # print $0 >> "buffer.tex";
    }
}
END{
    printf ("\n END of Script \n");
}

