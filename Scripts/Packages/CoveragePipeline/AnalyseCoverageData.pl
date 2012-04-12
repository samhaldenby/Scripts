#!/usr/bin/perl

use Getopt::Std;

#grab command line options
# -b bamFile -q minBaseQuality -r regions.bed
getopt('bqr', \%opts);
$bamFileName = $opts{"b"};
$minQuality = $opts{"q"};
$regionsFileName = $opts{"r"};


#generate binary coverage data
`samtools depth -q $minQuality $bamFileName | perl BamToCoverage.pl -b $bamFileName`;

#generate overall coverage graphs in R
@coverageFileNames = `ls -l ${bamFileName}.*.bin`;
foreach $fileNameLine (@coverageFileNames)
{
    @fileNameSplit = split(' ',$fileNameLine);
    $fileName = @fileNameSplit[7];
    
    #obtain chromosomeName
    @chromSplit = split(/\./,$fileName);
    $chr=@chromSplit[-2];

    #generate graph
    `Rscript PlotOverallCoverage.R $fileName $chr ${fileName}.graph.pdf`;
}
