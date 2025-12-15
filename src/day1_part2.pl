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
        if ($pos == 0) {
            $pos_at_zero_counter += int(((100 - $pos) + $distance) / 100) - 1;
        } else {
            $pos_at_zero_counter += int(((100 - $pos) + $distance) / 100);
        }
        $pos = ($pos - $distance) % 100;
    } elsif ($rotation eq 'R') {
        $pos_at_zero_counter += int(($pos + $distance) / 100);
        $pos = ($pos + $distance) % 100;
    }
}

say $pos_at_zero_counter;

1;