#!/usr/bin/perl

use strict;
use warnings;

#verschiedene variablen und datenstrukturen tests

my $var1 = 6;

my $var2;

print "-$var1-\n";
#print "-$var2-\n";

my @names = `cat /etc/passwd | cut -f 1 -d :`;
my @ids = `cat /etc/passwd | cut -f 3 -d :`;

print "-$names[0]-\n";

#foreach (@names) {
#	s/\s+$//;
#}
chomp @names;
chomp @ids;
#foreach my $user (@names) {
	#$user =~ s/\s+$//;
#}

#@names; #is an array
my %names; # is a hash
@names{@names} = @ids;
my $names = \%names; #is a hash reference

print "-$names[0]-\n";
print "-$names{$names[0]}-\n";
print "-$names{gerhard}-\n";
print "-$names{'syslog'}-\n";
print "-$names->{'www-data'}-\n";
