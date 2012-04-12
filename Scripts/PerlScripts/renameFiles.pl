#!/usr/bin/perl

while(<STDIN>){
	#print $_;
	@nameSplit=split (/[.]/,$_);
	$name = $nameSplit[0].".".$nameSplit[2].".".$nameSplit[3];
	print $name;
	chomp($name);
	chomp($_);
	system("mv $_ $name");
}
