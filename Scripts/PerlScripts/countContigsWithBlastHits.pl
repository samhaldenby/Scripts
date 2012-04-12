#!/usr/bin/perl

my $totalContigs =0;
my $hits = 0;
while(<STDIN>){
    if(substr($_,0,1) eq ">"){
	++$totalContigs;
	if (index ($_,"noSignificantHit")==-1){
	 #   print $_;
	    ++$hits;
	}
    }
}

print "Total: $totalContigs \t Hits: $hits \n";


