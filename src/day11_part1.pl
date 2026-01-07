#!/usr/bin/perl

use v5.24;
use strict;
use warnings;
use utf8;

my %al = ();
while (my $row = <STDIN>) {
    chomp($row);
    my ($from_node, $rhs) = split(m/: /, $row);
    my @to_nodes = split(m/ /, $rhs);

    $al{$from_node} = \@to_nodes;
}

my %visited_nodes = ();
my %paths_to_node_count = (you => 1);
my @nodes_queue = ('you');
while (my $node = shift(@nodes_queue)) {
    next if $visited_nodes{$node};
    $visited_nodes{$node} = 1;

    foreach my $linked_node ($al{$node}->@*) {
        $paths_to_node_count{$linked_node} += $paths_to_node_count{$node};
        push(@nodes_queue, $linked_node);
    }
}

say $paths_to_node_count{'out'};

1;