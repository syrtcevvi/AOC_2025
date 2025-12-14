#!/usr/bin/perl

use v5.24;
use strict;
use warnings;
use utf8;

my $pos_at_zero_counter = 0;
my $init_pos = 50;
while (my $row = <STDIN>) {
    my ($rotation, $distance) = $row =~ m/(.)(\d+)/;
    if ($rotation eq 'L') {
        $init_pos = ($init_pos - $distance) % 100;
    } elsif ($rotation eq 'R') {
        $init_pos = ($init_pos + $distance) % 100;
    }

    if ($init_pos == 0) {
        $pos_at_zero_counter++;
    }
}

say $pos_at_zero_counter;

1;