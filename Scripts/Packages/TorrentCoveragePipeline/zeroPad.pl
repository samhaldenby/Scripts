#!/usr/bin/perl
use Getopt::Std;

#grab command line options
# -i bed file
# -r region file
# -g gene name
getopt('irg', \%opts);
my $inFileName = $opts{"i"};
my $regionFileName = $opts{"r"};
my $geneName = $opts{"g"};


my ($regionChr, $regionStart, $regionEnd)=grabRegion($regionFileName, $geneName);

#export file for raw unpadded coverage and one for padded coverage too
open ($unpaddedFile, '>', "$geneName.raw.depth") or die $!;
open ($paddedFile, '>', "$geneName.padded.depth") or die $!;
my $prevChr="";
my $prevPos=$regionStart;
while(<STDIN>){
    #export raw
    print $unpaddedFile $_;

    chomp($_);
    ($chr,$pos,$cov)=split (/\t/,$_);

    #check that info is in range
    if($chr eq $regionChr && $pos >= $regionStart && $pos <= $regionEnd){

	if($pos ne $prevPos+1){
	    for($x=$prevPos+1;$x<$pos;$x++){
		print "$chr\t$x\t0\n";
		print $paddedFile "$chr\t$x\t0\n";
	    }
	}
	$prevChr=$chr;
	$prevPos=$pos;
	print "$chr\t$pos\t$cov\n";
	print $paddedFile "$chr\t$pos\t$cov\n";
    }
    else{
	$pos=$prevPos;
    }
}

#fill out last chunk
while($pos<$regionEnd){
    ++$pos;
    print "$chr\t$pos\t0\n";
    print $paddedFile "$chr\t$pos\t0\n";

}

######FUNCTIONS

#Grabs a region from a single entry bed file. This defines boundaries
sub grabRegion{
    my($fileName, $geneName) = @_;
    open FILE,"<",$fileName or die $!;
    while(<FILE>){
	chomp($_);
	my($chr,$start,$end,$gene)=split(/\t/,$_,10);
	if($gene eq $geneName){
	    close FILE;
	    return ($chr,$start,$end);
	}
    }
    
    #if not found
    close FILE;
    die "Can't find gene $geneName in $fileName: $!\n";
}
