#!/usr/bin/perl

use v5.24;
use strict;
use warnings;
use utf8;

chomp(my $input_row = <STDIN>);

my @periods = map {
    my ($s, $e) = split(m/-/, $_);
    { start => $s, end => $e }
} split(m/,/, $input_row);

my $invalid_ids_sum = 0;
foreach my $period (@periods) {
    my ($start, $end) = @{$period}{qw(start end)};

    foreach my $digits_count (length($start)..length($end)) {
        next if ($digits_count % 2 == 1);

        foreach my $number_part (1 . '0' x ($digits_count / 2 - 1) .. 9 . '9' x ($digits_count / 2 -1)) {
            my $number = $number_part . $number_part;
            if (
                $start <= $number
                && $number <= $end
            ) {
                $invalid_ids_sum += $number;
            }
        }
    }
}

say $invalid_ids_sum;

1;