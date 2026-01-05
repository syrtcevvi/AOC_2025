#!/usr/bin/perl

use v5.24;
use strict;
use warnings;
use utf8;

use List::Util qw(max);

my @points = ();
while(my $row = <STDIN>) {
    chomp($row);
    push(@points, $row);
}

my $max_area = 0;
foreach my $l_point (@points) {
    foreach my $r_point (@points) {
        my ($l_x, $l_y, $r_x, $r_y) = (split(m/,/, $l_point), split(m/,/, $r_point));
        $max_area = max($max_area, abs($l_x - $r_x + 1) * abs($l_y - $r_y + 1));
    }
}

say $max_area;

1;