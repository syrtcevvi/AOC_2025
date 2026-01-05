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

    my %invalid_ids = ();
    foreach my $digits_count (length($start)..length($end)) {
        foreach my $part_length (1..$digits_count) {
            next unless ($digits_count % $part_length == 0 && $digits_count / $part_length >= 2);

            for my $part (1 . '0' x ($part_length - 1) .. 9 . '9' x ($part_length - 1)) {
                my $number = $part x ($digits_count / $part_length);
                if (
                    $start <= $number
                    && $number <= $end
                    && !$invalid_ids{$number}
                ) {
                    $invalid_ids_sum += $number;
                    $invalid_ids{$number} = 1;
                }
            }
        }
    }
}

say $invalid_ids_sum;

1;