package GerhardJ::LunchClient;

use strict;
use warnings;
use JSON qw/decode_json/;

my $ua;

sub _get_ua {
    return if $ua;
    $ua = LWP::UserAgent->new;
    $ua->timeout(10);
    $ua->env_proxy;
    return;
}

sub get_lunches {
	my ($lunch_server) = @_;
	
	_get_ua;
	unless ($lunch_server) {
	    $lunch_server = GerhardJ::Config::get_config->{lunch_server};
    }

	my $response = $ua->get($lunch_server);
 
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
			#print "$info\n";
			push @res, $info;
		}
	}
	return \@res;
}

1;
