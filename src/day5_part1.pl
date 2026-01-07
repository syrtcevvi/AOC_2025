#!/usr/bin/perl

use v5.24;
use strict;
use warnings;
use utf8;

my @ranges = ();
while (my $input_row = <STDIN>) {
    chomp($input_row);
    last if ($input_row eq '');

    my ($start, $end) = split(m/-/, $input_row);
    push(@ranges, {start => $start, end => $end});
}

my $fresh_count = 0;
while (my $input_row = <STDIN>) {
    chomp($input_row);
    my $id = $input_row;

    foreach my $range (@ranges) {
        if (
            $range->{start} <= $id
            && $id <= $range->{end}
        ) {
            $fresh_count++;
            last;
        }
    }
}

say $fresh_count;

1;