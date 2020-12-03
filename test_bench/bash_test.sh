# repeatProj(){
#     awk 'BEGIN{ 
#     RS=ORS="\n\n";
#     FS="\n";
# } 
#  NR==FNR{ a[$4]++; print "buffer",$4,"a val", a[$4]; next} 
# {print "placeholder",$4; if (a[$4] >= 1);else{print $0;}}' buffer_test.tex placeholder_test.tex

# }

repeatProj(){
    awk 'BEGIN{  
    RS=ORS="\n\n";
    FS="\n";
}  
 NR==FNR{a[$4]++; print "file1",$4,"a val", a[$4]; next}  {if (a[$4] > 1){printf ("\n Match \n"); a[$4]--;}else{printf ("\n No Match \n"); print $0}}' placeholder_test.tex placeholder_test.tex 
}

repeatProj
