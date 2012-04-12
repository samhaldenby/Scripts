
#!/usr/bin/perl
use warnings;

while (<STDIN>){
    #check line size
    if (length($_) > 0 && substr ($_ , 0 ,1) eq '>'){
	@temp = split(' ' ,$_ , 3);
	@sizes[$temp[1]]+=1;    
	$_ = <STDIN>;
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
