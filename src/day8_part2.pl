#!/usr/bin/perl

use v5.24;
use strict;
use warnings;
use utf8;

use List::Util qw(any);

my %boxes = ();
while (my $row = <STDIN>) {
    chomp($row);
    $boxes{$row} = 1;
}

my %distances = ();
foreach my $l_box (keys(%boxes)) {
    foreach my $r_box (keys(%boxes)) {
        next if $l_box eq $r_box;

        my ($l_x, $l_y, $l_z) = split(m/,/, $l_box);
        my ($r_x, $r_y, $r_z) = split(m/,/, $r_box);
        my $distance = sqrt(
            ($l_x - $r_x) ** 2
            + ($l_y - $r_y) ** 2
            + ($l_z - $r_z) ** 2
        );
        $distances{$distance} =  {l => $l_box, r => $r_box};
    }
}

my $new_circuit_i = 1;
my %circuit_for_box = ();
my %boxes_in_circuit = ();
my @nearest_connections = map { $distances{$_} } sort { $a <=> $b } keys(%distances);
foreach my $connection (@nearest_connections) {
    my ($l_box, $r_box) = @{$connection}{qw(l r)};
    if (
        !exists($circuit_for_box{$l_box})
        && !exists($circuit_for_box{$r_box})
    ) {
        $circuit_for_box{$l_box} = $circuit_for_box{$r_box} = $new_circuit_i;
        push($boxes_in_circuit{$new_circuit_i}->@*, $l_box, $r_box);
        $new_circuit_i++;
    } elsif (
        exists($circuit_for_box{$l_box})
        && exists($circuit_for_box{$r_box})
    ) {
        next if ($circuit_for_box{$l_box} == $circuit_for_box{$r_box});

        my $prev_r_box_circuit = $circuit_for_box{$r_box};
        foreach my $box ($boxes_in_circuit{$prev_r_box_circuit}->@*) {
            $circuit_for_box{$box} = $circuit_for_box{$l_box};
            push($boxes_in_circuit{$circuit_for_box{$l_box}}->@*, $box);
        }
        $boxes_in_circuit{$prev_r_box_circuit} = [];
    } else {
        if (
            !exists($circuit_for_box{$l_box})
            && exists($circuit_for_box{$r_box})
        ) {
            ($l_box, $r_box) = ($r_box, $l_box);
        }
        push($boxes_in_circuit{$circuit_for_box{$l_box}}->@*, $r_box);
        $circuit_for_box{$r_box} = $circuit_for_box{$l_box};
    }

    if (any { scalar(@$_) == 1000 } values(%boxes_in_circuit)) {
        my ($l_x, undef, undef, $r_x) = (split(m/,/, $l_box), split(m/,/, $r_box));
        say $l_x * $r_x;
        last;
    }
}

1;