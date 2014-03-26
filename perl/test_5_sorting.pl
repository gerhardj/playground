my @keys = qw/foo bar baz first second third/;

my %primary = ( first => 3, second => 2, third => 1);	# different values for each key giving sort order (1, 2, 3, etc.)


my @sorted;
#@sorted = sort { ($primary{$a}//'a') cmp ($primary{$b}//'a') || $a cmp $b} @keys;

@sorted = sort { ($a cmp $b) + 5*(($primary{$a}||'a') cmp ($primary{$b}||'a'))} @keys;
	
print "Sorted: ", join(', ',@sorted), "\n";
