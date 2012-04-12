#!/bin/bash

usage()
{
cat << EOF
usage: $0 options

This script takes a bam file along with a gene name (and gene coordinates file) and generates coverage data across that region and graphs it. Also takes the exon coordinate file and reports exonic bases that fall below a coverage threshold (100x depth)
REQUIREMENTS: samtools must be installed. zeroPad.pl, DrawGraph.pl, GenerateStats.pl and PlotOverallCoverage.R must all be in the same directory as this script.

OPTIONS:
   -h      Show this message
   -i      input file
   -r      gene/regions coordinate file
   -q      minimum mapQ for samtools depth
   -g      gene name
   -e      exon file name
   -o	   output tag


EOF
}

BAMNAME=
COORDSFILENAME=
GENENAME=
EXONFILE=
while getopts “hi:r:g:e:o:q:” OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         r)
             COORDSFILENAME=$OPTARG
             ;;
		 i)
			 BAMNAME=$OPTARG
			 ;;
		 g)
			 GENENAME=$OPTARG
			 ;;
		 q)
			 MINQUAL=$OPTARG
		     ;;
		 e)
		 	 EXONFILE=$OPTARG
		 	 ;;
		 o)
		 	 OUTPUTTAG=$OPTARG
		 	 ;;
		        
		 ?)
             usage
             exit
             ;;
     esac
done

if [[ -z $BAMNAME ]] || [[ -z $COORDSFILENAME ]] || [[ -z $GENENAME ]] || [[ -z $MINQUAL ]] || [[ -z $EXONFILE ]] || [[ -z $OUTPUTTAG ]]
then
     usage
     exit 1
fi

#run
# 1 - Get raw depth
samtools depth -q $MINQUAL $BAMNAME | \

# 2 - Pad with zeroes and restrict output to region of gene
./zeroPad.pl -r $COORDSFILENAME -g $GENENAME > $OUTPUTTAG.depth 

# 3 - Draw graph in R
./DrawGraph.pl -r $COORDSFILENAME -g $GENENAME < $OUTPUTTAG.depth

# 4 - Create bed file with 4th column being 1/0. 1 means within an exon, 0 means outside an exon. Allows easy operations to get stats out
./GenerateStats.pl -e $EXONFILE -g $GENENAME -o statsTest -r $COORDSFILENAME < $OUTPUTTAG.depth > $OUTPUTTAG.depth.masked

# 5 - Generates list of positions that have less than 100 depth
awk '{if($4==1)print $0}' $OUTPUTTAG.depth.masked | awk '{if($3<100){print$0; ++low;}{++total}}END{print low"\t"total"\t"low*100/total"%"}'

# 6 - As above but generates ranges instead
awk '{if($4==1)print $0}' $OUTPUTTAG.depth.masked | awk '{if($3<100){print $1"\t"$2"\t"$2+1"\t"$3; ++low;}{++total}}' | mergeBed | awk '{print $0"\t"$3-$2; tot+=$3-$2;}END{print "TOT:"tot}'
 
