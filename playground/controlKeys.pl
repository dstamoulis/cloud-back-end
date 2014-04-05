# VLSI testing Project 
# Dimitrios Stamoulis - stamoulis.dimitrios@gmail.com
#
#				April 2014, Montreal, Canada
#
# controlPanel.pl -- command line program to provide back-end support
# for the Sensor Tags wireless Network
#
#!usr/bin/perl -w

# let's clear the screen
print "\033[2J";    #clear the screen
print "\033[0;0H"; #jump to 0,0

# package to detect key is pressed
use strict;
use Term::ReadKey;
ReadMode("cbreak");
#ReadMode 4;


# welcome message
print "                     ECSE649: VLSI Testing\n";
print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n";
print "Sensor Tags Wireless Network -- Control Panel\n\n";
print "Developed: Stamoulis Dimitrios (McGill ID 260569510)\n";
print "contact: dimitrios.stamoulis\@mail.mcgill.ca\n\n";
print "                                          April 2014, Montreal, Canada\n";
print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
print "\ncontrol panel> ";

while (1) {
 
 my $key_input = 1;
 while ($key_input==1){
   while (defined (my $key = ReadKey(-1)) and $key_input==1 ){

     if (ord($key) == 27)
     {
       my $code = ord(ReadKey -1);
       if ($code == 91)
         {
           my $action = ord(ReadKey -1);
           print "Left\n" if ( $action == 68 );
           print "Right\n" if ( $action == 67 );
           print "Up\n" if ( $action == 65 );
           print "Down\n" if ( $action == 66 );
         }
       else
         {
           print "Some other control key ?\n";
         }
      }
      else
      {
        if ($key =~ /[[:alnum:]]/) 
	{	print $key;
          	my $user_input = my $user_input . $key;	 }
        else 
	{	
           my $key_input = 0; }
      }
    }
  }
  # read user's input 
  # $user_input = $_;
  #chop ($user_input);

  if    (my $user_input eq "exit")    { print "thank you for using the control panel\n"; last; }
  elsif (my $user_input eq "help")    { help(); }
  elsif (my $user_input eq "users")   { users(); }
  elsif (my $user_input eq "")        { } # do nothing - enter pressed
  else                             { print "unknown command - type help for more options";  }

  print "\ncontrol panel> ";
}

ReadMode 0;


# Program's user options -- Function definitions
sub help{
   print "user pressed help!!";
}


sub users{
   my (@users) = parseLogFile();

   foreach my $val (@users) {
      print "\n${val}";
   }
   print "\n";
   
}


# Program's functional subroutines
sub parseLogFile{

  my @array1;
  
  # open logfile
  if (open RD, "./control.log") {
    while ( (my $line = <RD>) ) # it loops till it scans BTI parameters   
    {
        if ( $line =~ m/user: (.*)/ )
        {
            my @values = split(', ',$1);
    	    push (@array1, @values[0]);
        }
    }
    close RD;
    return (@array1);
  } else {

    my @array1 = ("Can't open the logfile file: control.log");
    return (@array1);
  }  

}


