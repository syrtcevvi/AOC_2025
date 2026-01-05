#!/usr/bin/perl

use v5.24;
use strict;
use warnings;
use utf8;

my %beam_columns;
{
    my $start_row = <STDIN>;
    chomp($start_row);
    my @start_row = split(m//, $start_row);
    %beam_columns = (
        map { $_ => 1 } grep { $start_row[$_] eq 'S' } (0..$#start_row)
    );
}

my $split_count = 0;
while (my $row = <STDIN>) {
    chomp($row);
    my @row = split(m//, $row);
    my @splitter_columns = grep { $row[$_] eq '^' } (0..$#row);

    foreach my $column (@splitter_columns) {
        if (exists($beam_columns{$column})) {
            $split_count++;
            delete($beam_columns{$column});
            $beam_columns{$column - 1} = $beam_columns{$column + 1} = 1;
        }
    }
}

say $split_count;

1;