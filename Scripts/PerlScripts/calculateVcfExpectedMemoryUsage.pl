#!/usr/bin/perl
#use warnings;

$chrTot = 0;
$infoTot = 0;
$snpTot = 0;
$infoTot = 0;
$filterTot = 0;
$numFieldsTot = 0;

while(<STDIN>){
   # print $_;
    if (length($_)>2 && substr ($_,0,1) ne "#"){
	@tokens = split('\t',$_);

	#do sumz!
	$numFieldsTot+=10;#this includes ref and alt (as 1 byte each)
	$chrTot+=length($tokens[0]);
	$snpTot+=length($tokens[2]);
	$infoTot+=length($tokens[7]);
	$filterTot+=length($tokens[6]);
	
	#print length($tokens[7]),"\n";
#	print $_;
    }
}

$infoTotMb =$infoTot / 1024 / 1024;
$chrTotMb = $chrTot / 1024 /1024;
$snpTotMb = $snpTot / 1024 / 1024;
$filterTotMb = $filterTot / 1024/1024;
$numFieldsTotMb = $numFieldsTot / 1024/1024;
print "Info: $infoTot b\t$infoTotMb Mb\n";
print "Chr : $chrTot b\t$chrTotMb Mb\n";
print "Id  : $snpTot b\t$snpTotMb Mb\n";
print "Fil : $filterTot b\t$filterTotMb Mb \n";
print "Num : $numFieldsTot b\t$numFieldsTotMb Mb \n";

$totalMb = ($infoTot + $chrTot + $snpTot + $filterTot + $numFieldsTot)/1024/1024;

print "\nTotal: $totalMb Mb\n";
