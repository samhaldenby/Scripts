
#!/usr/bin/perl
use warnings;

$currLength = 0;
while (<STDIN>){
    #check line size
    if (length($_) > 0 && substr ($_ , 0 ,1) eq '>' && $currLength>0){
	@sizes[$currLength]+=1;
	$currLength =0;
    }
    else{
	$currLength+=length($_);
    }
}

$count=1;
print "ContigSize\tFrequency\n";
while($count < @sizes){
    if(defined($sizes[$count])){
	print "${count}\t${sizes[$count]}\n";
    }
    else{
	print "${count}\t0\n";
    }
 
    $count++;
}
