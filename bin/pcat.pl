#!/usr/bin/env perl
use strict;
use warnings;

my $a = $ARGV[0];
my ($host,$port) = split(/:/,$a);
warn $host;
my $vpn = ($host =~ /mars.sfsrv.net/) ? 'mars' : 'saturn';
`socat TCP-LISTEN:$port,reuseaddr,fork 'EXEC:docker exec -i $vpn "nc $host $port"'`;
