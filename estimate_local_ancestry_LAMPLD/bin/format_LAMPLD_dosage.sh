fpI=$1

for refPop in ceu yri nam;
do
    cat $fpI.xATCG.ref.phased.allele.22.txt | awk 'BEGIN{printf "SAMPLE"}{printf "\t"$1}END{printf "\n"}' > $fpI.dosage.$refPop.txt
    awk 'BEGIN{i=1;sampleCount=1}{
        if (NR == FNR){
            sampleA[FNR]=$1
        }else{
            if (FNR == i){
                hap1=$1
                n1=split(hap1,a1,"")
                # print hap1,a1[1]
            }else if (FNR == i+1){
                hap2=$1
                n2=split(hap2,a2,"")
                if ( n1 == n2){
                    sample=sampleA[sampleCount]
                    printf sample
                    for (j=1;j<=n1;j++){
                        sum=a1[j]+a2[j]
                        printf "\t"sum
                    }
                    printf "\n"
                }else{
                    exit 1
                }
                i=i+2
                sampleCount++
            }
        }
    }' $fpI.xATCG.sample.s.22.txt $fpI.xATCG.LAMPLD.$refPop.22.txt >> $fpI.dosage.$refPop.txt
    
    echo -e "output : $fpI.dosage.$refPop.txt"
done