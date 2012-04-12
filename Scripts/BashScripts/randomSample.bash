paste f1.fastq f2.fastq |\ #merge the two fastqs
awk '{ printf("%s",$0); n++; if(n%4==0) { printf("\n");} else { printf("\t\t");} }' |\ #merge by group of 4 lines
shuf  |\ #shuffle
head |\ #only 10 records
sed 's/\t\t/\n/g' |\ #restore the delimiters
awk '{print $1 > "file1.fastq"; print $2 > "file2.fatsq"}' #split in two files.
