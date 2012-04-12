#!/bin/bash

bamFile=$1
bedFile=$2
outFile=$3
tempFile=`mktemp`

basesInExome=`awk '{tot+=($3-$2)}END{print tot}' $2`

samtools depth -q 10 -b $2 $1 | \
awk -v total=$basesInExome 'BEGIN{max=0;lineCount=0};{if($3>0)bin[$3]++ ; if(max<$3) max=$3; lineCount++;};END{bin[0]=total-lineCount; for(x=0;x<=max;x++)print x"\t"bin[x]}' > $tempFile

#convert blanks to 0s and write to temp file
awk '{if ($2 ~ /^ *$/)print $1"\t"0; else print $0}' $tempFile > $outFile.freq

#cumulative freq
total=`awk '{tot+=$2} END{print tot}' $tempFile`
awk -v total=$total 'BEGIN{constTotal=total};{print $1"\t"total/constTotal; total=total-$2}' $tempFile > $outFile.cumulative

rm $tempFile

#Draw!

python PlotFrequencyFullExome.py -f $outFile.freq -c $outFile.cumulative -o $outFile

 




