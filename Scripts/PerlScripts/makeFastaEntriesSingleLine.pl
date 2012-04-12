#!/usr/bin/perl

$seq = "";
while (<STDIN>) {
   # print $_;
    if(length($_)>0 && substr($_,0,1) ne '>'){
	chomp($_);
	$seq  = $seq.$_;
    }
    else{
	if(length($seq)>0){
	    print $seq,"\n";
	    $seq = "";
	    print $_;
	}
	else{
	    print $_;
	}
    }
}
