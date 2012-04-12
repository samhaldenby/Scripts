#!/usr/bin/perl
use Getopt::Std;

use strict;
use warnings;

#grab command line options
# -r region file
# -g gene name
# -e exon file
# -o output file prefix
my %opts;
getopt('ergo', \%opts);
my $regionFileName = $opts{"r"};
my $geneName = $opts{"g"};
my $exonFileName = $opts{"e"}; 
my $outFileTag = $opts{"o"};
my ($regionChr, $regionStart, $regionEnd)=grabRegion($regionFileName, $geneName);
my ($exonChr, $exonStart, $exonEnd) = grabExonCoords($exonFileName);


exportBinaryMaskAndCoverageFiles($outFileTag, $regionChr, $regionStart, $regionEnd, $exonChr, $exonStart, $exonEnd);

open (my $binFile, '>:raw', 'temp.bin') or die $!;

#parse out to binary temp file (Allows for much faster loading in R); #TODO: Does the time it takes matter too much though....?
while(<STDIN>){
   # print $_;
    chomp ($_);
    my @spl = split (/\t/,$_,3);
    my $depth =$spl[2]; 
    print $binFile  pack('S<',$depth); 
}

#plot
`Rscript PlotOverallCoverage.R temp.bin $geneName ${geneName}.graph.pdf $regionStart $regionEnd`;
 
#clean up
system("rm temp.bin");


######FUNCTIONS

#Grabs a region from a single entry bed file. This defines boundaries
sub grabRegion{
    
    my ($fn,$gn) = @_;
    open (my $regionFile, '<', $fn) or die $!;
    while(<$regionFile>){
        chomp($_);
        my($chr,$start,$end,$gene)=split(/\t/,$_,10);
        if($gene eq $gn){
            close $regionFile;
            return ($chr,$start,$end);
        }
    }
    
    #if not found
    close $regionFile;
    die "Can't find gene $gn in $fn: $!\n";
}

#Grabs exon coordinates from a bed file. Provide with fileName
sub grabExonCoords{
    my($fn) = @_;
    open FILE,"<",$fn or die $!;
    my (@exonChr, @exonStart, @exonEnd);
    while(<FILE>){
        chomp($_);
        my($chr,$start,$end)=split(/\t/,$_,10);
		push @exonChr,$chr ;
		push @exonStart,$start ;
		push @exonEnd,$end ;
		
    }
    
    return (\@exonChr,\@exonStart,\@exonEnd);
}

#write binary files. File 1 is coverage data across entire region. File 2 is a mask for non-exonic regions
sub exportBinaryMaskAndCoverageFiles{
	#print "Exporting Binary Files\n";
	my($outputFileTag, $regionChr, $regionStart, $regionEnd, $exonChr, $exonStart, $exonEnd) = @_;
	#print "$outputFileTag $regionChr $regionStart, $regionEnd, [$exonChr], [$exonStart], [$exonEnd]\n";

	#prepare mask array
		my @mask = (0) x ($regionEnd-$regionStart+1);
		#write mask file
		#change offsets of global exon coords to match defined region
		for(my $e=0;$e<@$exonChr;++$e){
			#check same exon as $region
			if($exonChr->[$e] eq $regionChr){
				#print $exonStart->[$e],"<-\n";
				$exonStart->[$e]=$exonStart->[$e] - $regionStart;
				$exonEnd->[$e]=$exonEnd->[$e] - $regionStart;
				#print $exonChr->[$e],"\t",$exonStart->[$e],"\t",$exonEnd->[$e],"\n"; 
				#add to array
				foreach($exonStart->[$e]..$exonEnd->[$e]){
					@mask[$_]=1;

				}
			
			}
		}


	#write cov array
	my @cov=();
	my $iterator=0;
	while(<STDIN>){
	   # print $_;
		chomp ($_);
		my @spl = split (/\t/,$_,3);
		my $depth =$spl[2]; 
		push @cov,$depth; 
		print "$_\t",$mask[$iterator++],"\n";
	}
	
		
	
	

	die;
	
	
	
	
}
	
