# VLSI testing Project 
# Dimitrios Stamoulis - stamoulis.dimitrios@gmail.com
#
# monitor.pl : 
# Script to monitor user's activity per a particular day
# ~~~~~
# Functionality: 
# you keep tracking the last location of the user. if it changes, give a message 

#!usr/bin/perl
if (@ARGV < 1)
{ die "not enough arguments / USAGE: perl monitor.pl (file-to-parse) "; }

use strict;
use warnings;
use Term::ReadKey;

ReadMode 4;    # Turn off controls keys
my $key;
my $last_position = "nullPosition";
my $current_position = "nullPosition";
my @values;

while ( !defined( $key = ReadKey(-1) ) )
{

  # keep where you were before as a reference
  my $last_position = $current_position;

  # parse the box.com log file
  open RD, "./$ARGV[0]" or die ("Can't open the input file: $ARGV[0]\n" );
  while ( (my $line = <RD>) ) # it loops till it scans BTI parameters	
  {
	@values = split(' ',$line);
	#foreach my $val (@values) {
    	#	print "${val} ";
  	#}		
  }
  close RD; #close file to re-open it and repeat check

  # check if I changed position
  $current_position = $values[0];
  if ( !($current_position eq $last_position))
  {
	print "User just entered room ${current_position}\n";
  }
 
}

print "Get key $key\n";
ReadMode 0;    # Reset tty mode before exiting

