#!/usr/bin/perl

use v5.24;
use strict;
use warnings;
use utf8;

use List::Util qw(sum reduce);

my @operators;
my %problem_numbers = ();
while (my $input_row = <STDIN>) {
    chomp($input_row);
    $input_row =~ s/^\s+//;

    if ($input_row =~ m/\d/) {
        my @numbers = split(m/\s+/, $input_row);
        my $col = 0;
        for my $number (@numbers) {
            $problem_numbers{$col} //= [];
            push($problem_numbers{$col}->@*, $number);
            $col++;
        }
    } else {
        @operators = split(m/\s+/, $input_row);
        last;
    }
}

my $grand_total = 0;
for my $problem_i (keys %problem_numbers) {
    if ($operators[$problem_i] eq '+') {
        $grand_total += sum $problem_numbers{$problem_i}->@*;
    } elsif ($operators[$problem_i] eq '*') {
        $grand_total += reduce { $a * $b } $problem_numbers{$problem_i}->@*;
    }
}

say $grand_total;

1;