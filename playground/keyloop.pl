# VLSI testing Project 
# Dimitrios Stamoulis - stamoulis.dimitrios@gmail.com
#
# keyloop.pl : 
# Exits loop while key is pressed !!

#!usr/bin/perl
use strict;
use warnings;
use Term::ReadKey;

ReadMode 4;    # Turn off controls keys
my $key;

while ( !defined( $key = ReadKey(-1) ) ) {
    #print "No key yet\n";
    #sleep 5;
}
print "Get key $key\n";

ReadMode 0;    # Reset tty mode before exiting
