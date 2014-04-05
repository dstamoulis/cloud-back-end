#!usr/bin/perl

# let's clear the screen
print "\033[2J";    #clear the screen
print "\033[0;0H"; #jump to 0,0

# welcome message
print "                     ECSE649: VLSI Testing\n";
print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n";
print "Sensor Tags Wireless Network -- Control Panel\n\n";
print "Developed: Stamoulis Dimitrios (McGill ID 260569510)\n";
print "contact: dimitrios.stamoulis\@mail.mcgill.ca\n\n";
print "                                          April 2014, Montreal, Canada\n";
print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
print "\ncontrol panel> ";

while (<STDIN>) {

  # read user's input 
  $user_input = $_;
  chop ($user_input);

  if    ($user_input eq "exit")    { print "thank you for using the control panel\n"; last; }
  elsif ($user_input eq "help")    { print "user pressed help!"; }
  elsif ($user_input eq "")        { } # do nothing - enter pressed
  else                             { print "unknown command - type help for more options";  }

  print "\ncontrol panel> ";
}


