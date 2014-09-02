package GerhardJ::Config;

use JSON qw/decode_json encode_json/;

my $single_config;

sub get_config_from_file {
	local $/;
	open( my $fh, '<', 'config.json' );
	my $json_text = <$fh>;
	my $config = decode_json( $json_text );
	return $config;
}

sub get_config {
    unless ($single_config) {
        $single_config = get_config_from_file;
    }
    return $single_config;
}

sub write_dummy_config_ifne {
    my %dummy = (
        lunch_server => "http://example.com/data.json",
    );
    my $orig = {};
    eval {
        $orig = get_config;
    };
    @dummy{ keys %$orig } = values %$orig;
	open( my $fh, '>', 'config.json' );
	my $json_text = JSON->new->utf8->pretty->encode( \%dummy );
	print $fh $json_text;
	return;
}

1;
