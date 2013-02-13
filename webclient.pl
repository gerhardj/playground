#!/usr/bin/perl -w
use strict;
use warnings;
use HTTP::Tiny;
use JSON::PP;
use Data::Dumper;

sub latest_tweet {

	my $uri = "";
	if( defined $_[0] ) {
		$uri = "http://search.twitter.com/search.json?q=$_[0]&rpp=5&include_entities=false&result_type=mixed";
	}
	else {
		$uri = "http://search.twitter.com/search.json?q=fossdem&rpp=5&include_entities=false&result_type=mixed";
	}
	my $response = HTTP::Tiny->new->get($uri);
	die "Failed!\n" unless $response->{success};
	#print "$response->{status} $response->{reason}\n";

=pod
	while (my ($k, $v) = each %{$response->{headers}}) {
		for (ref $v eq 'ARRAY' ? @$v : $v) {
			print "$k: $_\n";
		}
	}
=cut

	my $json = new JSON::PP;
	my $data = $json->utf8->decode($response->{content});
	my $results = $data->{results};
	
	my @results = @{$results};
	my $last = $results[$#results];
	
	#return
	($last->{from_user}, $last->{text}, $last->{id});
}

my %ids = ();

my $search_string = defined $ARGV[0] ? $ARGV[0] : "fosdem";

while (1) {

	my ($from_user, $text, $id);
	($from_user, $text, $id) = latest_tweet($search_string);

	if($ids{$id}++) {
		print "found it\n";
	} else {
		#print "not found\n";
		#print $from_user . "\n\n";
		print "$from_user\n$text\n\n";
		system("notify-send \"$from_user\" \"$text\"");
	}
	#$ids{ $id } = 1;
	sleep(10);
}


print "\n";
