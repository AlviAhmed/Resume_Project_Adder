#!/bin/awk -f


BEGIN{
    lines=0;
    RS=ORS="\n\n";
    FS="\n";
}
{
    print $4;
    lines++
    
    # if (NF > 0){
    #     var=$(NF - 1);
    # }
    # else{
                                #     var=$NF;
    # }
    # if ( ((index(var,"Control"))) ){
    #     print $0;
    #     # print $0 >> "buffer.tex";
    # }
}
END{
    print lines
}

