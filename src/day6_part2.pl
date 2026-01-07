#!/usr/bin/perl

use v5.24;
use strict;
use warnings;
use utf8;

use List::Util qw(max all sum reduce);

my $row_max_length = 0;
my $rows_with_numbers = [];
my @operators = ();
while (my $input_row = <STDIN>) {
    chomp($input_row);
    if ($input_row =~ m/\d/) {
        push(@$rows_with_numbers, [split m//, $input_row]);
        $row_max_length = max($row_max_length, length($input_row));
    } else {
        @operators = split m/\s+/, $input_row;
    }
}

my $grand_total = 0;
my @numbers = ();
foreach my $col (0..$row_max_length) {
    if (all { !defined($_) || $_ eq ' ' } map { $rows_with_numbers->[$_][$col] } 0..$#{$rows_with_numbers}) {
        my $operator = shift @operators;
        if ($operator eq '+') {
            $grand_total += sum @numbers;
        } elsif ($operator eq '*') {
            $grand_total += reduce { $a * $b } @numbers;
        }
        @numbers = ();
        next;
    }
    push(
        @numbers,
        join('', grep { defined($_) && $_ ne ' ' } map { $rows_with_numbers->[$_][$col] } 0..$#{$rows_with_numbers}),
    );
}

say $grand_total;

1;