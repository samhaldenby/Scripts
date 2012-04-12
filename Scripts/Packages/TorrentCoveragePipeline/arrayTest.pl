#!/usr/bin/perl

use Data::Dumper;
use strict;
use warnings;

my $mess = [1,2,3,["a","b","c"],{1=>"dog",2=>"cat",3=>[10,100,300]}];

print Dumper($mess);

print $mess->[3][2],"\n";
print $mess->[4]{3}[2],"\n";

my @exonChr;
