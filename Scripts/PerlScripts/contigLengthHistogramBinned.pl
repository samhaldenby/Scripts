
#!/usr/bin/perl
use warnings;

$binSize = 100;

while (<STDIN>){
    #check line size
    if (length($_) > 0 && substr ($_ , 0 ,1) eq '>'){
	@temp = split(' ' ,$_ , 3);
#	print "$temp[1] / $binSize = ", int($temp[1] / $binSize) , "\n";
	@sizes[int($temp[1]/$binSize)]+=1;    
	$_ = <STDIN>;
    }
}

$count=0;
print "ContigSize\tFrequency\n";
while($count < @sizes){
    $midBin = ($count * $binSize) + $binSize/2;
    if(defined($sizes[$count])){
	print "${midBin}\t${sizes[$count]}\n";
    }
    else{
	print "${midBin}\t0\n";
    }
 
    $count++;
}
