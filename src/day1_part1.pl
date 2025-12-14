#!/usr/bin/perl

use v5.24;
use strict;
use warnings;
use utf8;

my $pos_at_zero_counter = 0;
my $pos = 50;
while (my $row = <STDIN>) {
    my ($rotation, $distance) = $row =~ m/(.)(\d+)/;
    if ($rotation eq 'L') {
        $pos = ($pos - $distance) % 100;
    } elsif ($rotation eq 'R') {
        $pos = ($pos + $distance) % 100;
    }

    if ($pos == 0) {
        $pos_at_zero_counter++;
    }
}

say $pos_at_zero_counter;

1;