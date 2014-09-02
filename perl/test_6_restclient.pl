use warnings;
use strict;
use LWP::UserAgent;
use Data::Dumper qw/Dumper/;
use lib 'lib';
use JSON qw/decode_json/;
use GerhardJ::Config;

sub get_lunches;
sub get_lunch_caps;

my $ua = LWP::UserAgent->new;
$ua->timeout(10);
$ua->env_proxy;

#GerhardJ::Config::write_dummy_config_ifne;
my $config = GerhardJ::Config::get_config;

print Dumper get_lunch_caps $config;

sub get_lunches {
	my ($lunch_server) = @_;
	
	unless ($lunch_server) {
	    $lunch_server = GerhardJ::Config::get_config->{lunch_server};
    }

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


#vim: set ts=4:noet:
