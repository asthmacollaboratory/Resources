fpI=$1

awk '{
    aleles=$5$6
    if (alleles == "AT" || alleles == "TA" || alleles == "CG" || alleles == "GC"){
        print $4
    }
}' $fpI.bim > $fpI.removeATCG.txt

wc -l $fpI.removeATCG.txt