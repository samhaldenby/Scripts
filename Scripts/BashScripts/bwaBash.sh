#!/bin/bash

#Set variables from command line here
#USAGE bwaBash <ref> <fq1> <fq2> <output>

#check correct number of variables
ARGCOUNT=0
NUM=1
for i in $*
do
    ARGCOUNT=$(($ARGCOUNT + $NUM))
done

if [ $ARGCOUNT -ne 4 ]
then
    echo "USAGE: bash bwaBash <ref> <fq1> <fq2> <output>"
    exit
fi

REFERENCE="chr1.fa"
FQ1="A0500000_6.1.fq"
FQ2="A0500000_6.2.fq"
OUTPUT="chr1Sampe.out"


#Simple script to run BWA

#index reference (change from bwtsw to is if small (<10Mb) genome
./bwa index -a bwtsw $1;
#renaming of files due to bwa bug
cp ${1}.amb ${1}.nt.amb;
cp ${1}.ann ${1}.nt.ann;
cp ${1}.pac ${1}.nt.pac;
#create .sai files
./bwa aln -t 2 $1 $2 > C1.sai;
./bwa aln -t 2 $1 $3 > C2.sai;
#generate paired end alignment
./bwa sampe $1 C1.sai C2.sai $2 $3 > $4;
 