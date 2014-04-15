#! perl -slw
use strict;
use Time::HiRes qw[ time ];
use List::Util qw[ min ];
use Data::Dump qw[ pp ];

srand 1;

our $N //= 10000;

my $start = time();

my %pvalues = map{ $_ => rand() } 1 .. $N;

#my %pvalues = (
#    1=> 0.5453980,
#    2=> 0.4902384,
#    3=> 0.8167950,
#    4=> 0.2821822,
#    5=> 0.4693030,
#    6=> 0.6491767,
#    7=> 0.9802138,
#    8=> 0.1155778,
#    9=> 0.9585124,
#    10=> 0.4069490
#);

my @orderedKeys = sort {
    $pvalues{ $b } <=> $pvalues{ $a }
} keys %pvalues;

my $d = my $n = values %pvalues;

$pvalues{ $_ } *= $n / $d-- for @orderedKeys;

$pvalues{ $orderedKeys[ $_ ] } =
    min( @pvalues{ @orderedKeys[ 0 .. $_ ] } )
    for 1 .. $n-1;

$pvalues{ $_ } = min( $pvalues{ $_ }, 1 ) for keys %pvalues;

printf "$N: Took %.3f seconds\n", time() - $start;



