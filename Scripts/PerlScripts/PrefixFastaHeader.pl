#!/usr/bin/perl

$text="Saimiri";

while (<STDIN>){
    if (substr($_, 0,1) eq '>'){
	print ">${text}_",substr($_,1);
    }
    else{
	print $_;
    }
}
