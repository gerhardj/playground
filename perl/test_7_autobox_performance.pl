#! perl -slw
use strict;
use autobox::Core;

use Time::HiRes qw[ time ];
use List::Util qw[ min ];
use Data::Dump qw[ pp ];

srand 1;

our $N //= 10000;

my $start = time();

my %pvalues = @{ [ 1 .. $N ]->map( sub{ $_[0] => rand() } ) };

#our %pvalues = (
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

my @orderedKeys = @{ %pvalues->keys->sort(
        sub{ $pvalues{ $_[1] } <=> $pvalues{ $_[0] } }
    )
};
my $d = my $n = @{ %pvalues->keys };

@orderedKeys->map(
    sub{ $pvalues{ $_[0] } *= $n / $d--; }
);

[ 1 .. $n-1 ]->map(
    sub{
        $pvalues{ $orderedKeys[ $_[0] ] } =
            min( @pvalues{ @orderedKeys[ 0 .. $_[0] ] } );
    }
);

%pvalues->keys->map(
    sub{ $pvalues{ $_[0] } = min( $pvalues{ $_[0] }, 1 ) }
);

printf "$N: Took %.3f seconds\n", time() - $start;

#pp \%pvalues;
