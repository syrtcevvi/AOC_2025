#!/usr/bin/perl

use v5.24;
use strict;
use warnings;
use utf8;

use List::Util qw(max);

my $joltage_sum = 0;
while (my $row = <STDIN>) {
    chomp($row);
    my @digits = split(m//, $row);
    my @max_joltage_digits = @digits[0..11];
    for my $new_digit (@digits[12..$#digits]) {
        for my $i (0..10) {
            if ($max_joltage_digits[$i] < $max_joltage_digits[$i+1]) {
                splice(@max_joltage_digits, $i, 2, ($max_joltage_digits[$i+1]));
                push(@max_joltage_digits, $new_digit);
                last;
            }
        }
        $max_joltage_digits[11] = max($max_joltage_digits[11], $new_digit);
    }

    $joltage_sum += join('', @max_joltage_digits);
}

say $joltage_sum;

1;