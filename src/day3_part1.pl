#!/usr/bin/perl

use v5.24;
use strict;
use warnings;
use utf8;

my $joltage_sum = 0;
while (my $row = <STDIN>) {
    chomp($row);
    my @digits = split(m//, $row);
    my ($lhs, $rhs) = @digits;
    for my $digit (@digits[2..$#digits]) {
        if ($rhs > $lhs) {
            $lhs = $rhs;
            $rhs = $digit;
        } elsif ($digit > $rhs) {
            $rhs = $digit;
        }
    }

    $joltage_sum += $lhs . $rhs;
}

say $joltage_sum;

1;