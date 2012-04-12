
#!/usr/bin/perl
use warnings;

$binSize = 20;
$currLength = 0;
while (<STDIN>){
    #check line size
    if (length($_) > 0 && substr ($_ , 0 ,1) eq '>' && $currLength>0){
	@sizes[int($currLength/$binSize)]+=1;
	$currLength =0;
    }
    else{
	$currLength+=length($_);
    }
}

$count=0;
print "ContigSize\tFrequency\n";
while($count < @sizes){
    $midBin = ($count * $binSize) + $binSize/2;
    $binStart = $count * $binSize;
    $binEnd = (($count +1 ) * $binSize) -1;
    if(defined($sizes[$count])){
	print "${binStart}-${binEnd}\t${sizes[$count]}\n";
	#print "${midBin}\t${sizes[$count]}\n";
    }
    else{
	print "${binStart}-${binEnd}\t0\n";
    }
 
    $count++;
}
