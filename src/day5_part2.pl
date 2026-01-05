#!/usr/bin/perl

use v5.24;
use strict;
use warnings;
use utf8;

my %ranges = ();
NEW_RANGE: while (my $input_row = <STDIN>) {
    chomp($input_row);
    last if ($input_row eq '');

    my ($n_s, $n_e) = split(m/-/, $input_row);

    EXISTING_RANGE: foreach my $key (keys(%ranges)) {
        my ($c_s, $c_e) = split(m/-/, $key);

        if ($n_s <= $c_s <= $c_e <= $n_e) {
            delete($ranges{$c_s . '-' . $c_e});
        } elsif ($c_s <= $n_s <= $n_e <= $c_e) {
            next NEW_RANGE;
        } elsif ($c_s <= $n_s <= $c_e) {
            delete($ranges{$c_s . '-' . $c_e});
            $n_s = $c_s;
        } elsif ($n_s <= $c_s <= $n_e) {
            delete($ranges{$c_s . '-' . $c_e});
            $n_e = $c_e;
        }
    }
    $ranges{$n_s . '-' . $n_e} = 1;
}

my $fresh_ids_count = 0;
foreach my $key (keys(%ranges)) {
    my ($start, $end) = split(m/-/, $key);
    $fresh_ids_count += $end - $start + 1;
}

say $fresh_ids_count;

1;