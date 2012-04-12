#!/bin/bash
inFile=$1
samtools view $inFile | awk '{if (NR % 2==0) {print "@" $1 "/1\n" $10 "\n+\n" $11 > "file1"} else {print "@" $1 "/2\n" $10 "\n+\n" $11 > "file2"} }'

#rename

outName1=${inFile/bam/1.fq}
outName2=${inFile/bam/2.fq}
mv file1 $outName1
mv file2 $outName2
