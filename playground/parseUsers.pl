if (@ARGV < 1)
{
	die "not enough arguments";
}


open RD, "./$ARGV[0]" or die ("Can't open the input file: $ARGV[0]\n" );
my $line_counter = 1;

$dline;
$string;

while ( (my $line = <RD>) ) # it loops till it scans BTI parameters	
{
	
	if ( $line =~ m/user: (.*)/ ) 
	{
		#my @all_nums    = $1 =~ /(\d+)/g;
		#$string = "$all_nums[2].$all_nums[3]";
		#if ( $max < $string )
		#{
		#  $max = $string;
		#}
		my @values = split(', ',$1);
		print("@values[0]\n");
	}	
}

close RD;

