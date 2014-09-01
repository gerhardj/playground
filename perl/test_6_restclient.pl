use warnings;
use strict;
use LWP::UserAgent;
use Data::Dumper qw/Dumper/;
use lib 'lib';
use JSON qw/decode_json/;

sub get_config;
sub get_lunches;
sub get_lunch_caps;

my $ua = LWP::UserAgent->new;
$ua->timeout(10);
$ua->env_proxy;

my $config = get_config;
print Dumper $config;

print Dumper get_lunch_caps $config;

sub get_lunches {
	my ($config) = @_;

	my $response = $ua->get($config->{lunch_server});
 
	if ($response->is_success) {
	    return decode_json $response->decoded_content;
	}
	else {
	    die $response->status_line;
	}
}

sub get_lunch_caps {
	my $lunch = get_lunches @_;
	my @res;
	for my $day (@{ $lunch->{MenusForDays} }) {
		for my $menu (@{ $day->{SetMenus} }) {
			my $info = join "; ", @{ $menu->{Components} };
			print "$info\n";
			push @res, $info;
		}
	}
	return \@res;
}

sub get_config {
	local $/;
	open( my $fh, '<', 'config.json' );
	my $json_text = <$fh>;
	my $config = decode_json( $json_text );
	return $config;
}

#vim: set ts=4:noet:
