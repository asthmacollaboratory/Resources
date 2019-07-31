popkeyFp=$1
famFp=$2
outFp=`echo $famFp | sed s/.fam/.pop/g`

echo -e "output :$outFp"

awk '{
    if (NR == FNR){
        popArr[$1]=$2
    }else{
        id=$2; 
        if (id in popArr){
            print popArr[id]
        }
    }
}' $popkeyFp $famFp > $outFp