#!/usr/bin/perl

use v5.24;
use strict;
use warnings;
use utf8;

use List::Util qw(sum);

my %beams;
{
    my $start_row = <STDIN>;
    chomp($start_row);
    my @start_row = split(m//, $start_row);
    %beams = (
        map { $_ => 1  } grep { $start_row[$_] eq 'S' } (0..$#start_row)
    );
}

while (my $row = <STDIN>) {
    chomp($row);
    my @row = split(m//, $row);
    my @splitter_columns = grep { $row[$_] eq '^' } (0..$#row);

    foreach my $column (@splitter_columns) {
        if (exists($beams{$column})) {
            $beams{$column - 1} += $beams{$column};
            $beams{$column + 1 } += $beams{$column};
            delete($beams{$column});
        }
    }
}

say sum(values(%beams));

1;