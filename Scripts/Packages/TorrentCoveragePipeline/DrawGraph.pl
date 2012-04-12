#!/usr/bin/perl
use Getopt::Std;

print "$ARGV[0] $ARGV[1] $ARGV[2] $ARGV[3] $ARGV[4] $ARGV[5] $ARGV[6]\n";
#grab command line options
# -r region file
# -g gene name
getopt('irg', \%opts);
my $regionFileName = $opts{"r"};
my $geneName = $opts{"g"};



my ($regionChr, $regionStart, $regionEnd)=grabRegion($regionFileName, $geneName);

open ($binFile, '>:raw', 'temp.bin') or die $!;

#parse out to binary temp file (Allows for much faster loading in R); #TODO: Does the time it takes matter too much though....?
while(<STDIN>){
   # print $_;
    chomp ($_);
    @spl = split (/\t/,$_,3);
    $depth =$spl[2]; 
    print $binFile  pack('S<',$depth); 
}

#plot
`Rscript PlotOverallCoverage.R temp.bin $geneName ${geneName}.graph.pdf $regionStart $regionEnd`;
 
#clean up
system("rm temp.bin");


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
