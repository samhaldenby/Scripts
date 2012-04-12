#!/usr/bin/perl
use Getopt::Std;

#grab command line options
# -i depth file
# -o out name
# -g gene name
# -c min coverage
getopt('iogc', \%opts);
my $inFileName = $opts{"i"};
my $bedFileName = $opts{"o"};
my $geneName = $opts{"g"};
my $minCov = $opts{"c"};

my $tempBedFileName = "$bedFileName.temp";
open($depthFile,"< $inFileName") or die $!;
open($tempBedFile,"> $tempBedFileName") or die $!;

while(<$depthFile>){
	chomp($_);
	my($chr,$pos,$depth)=split(/\t/,$_);
	if($depth gt $minCov){
	    print $tempBedFile "$chr\t$pos\t".($pos+1),"\n";
	 #   print "$depth vs $minCov\n";
	}
}

close $depthFile;
close $tempBedFile;

#parse temp bed file with mergeBed
`mergeBed -i $tempBedFileName > $bedFileName`;
#`rm $tempBedFileName`;
