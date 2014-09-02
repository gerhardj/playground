use warnings;
use strict;
use LWP::UserAgent;
use Data::Dumper qw/Dumper/;
use lib 'lib';
use JSON qw/decode_json/;
use GerhardJ::Config;
use GerhardJ::LunchClient;
use utf8::all;

sub get_lunches;
sub get_lunch_caps;

#GerhardJ::Config::write_dummy_config_ifne;
my $config = GerhardJ::Config::get_config;

my $caps = GerhardJ::LunchClient::get_lunch_caps $config->{lunch_server};

print join "\n", @$caps;
print "\n";


#vim: set ts=4:noet:
