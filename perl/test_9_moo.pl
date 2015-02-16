#!/usr/bin/perl

use strict;
use warnings;

package GenericGreet;

use Moo;

sub greet {
	my ($self, $name) = @_;
	print $self->create_greeting($name);
}

sub create_greeting {
	my ($self, $name) = @_;
	return "Hello, $name\n";
}

1;

package MorningGreet;

use Moo;

extends 'GenericGreet';

sub create_greeting {
	my ($self, $name) = @_;
	return "Good Morning, $name\n";
}

1;

package main;

my $g = GenericGreet->new;
my $m = MorningGreet->new;

$g->greet("Alice");
$m->greet("Alice");

