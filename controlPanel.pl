# VLSI testing Project 
# Dimitrios Stamoulis - stamoulis.dimitrios@gmail.com
#
#				April 2014, Montreal, Canada
#
# controlPanel.pl -- command line program to provide back-end support
# for the Sensor Tags wireless Network
#
#!usr/bin/perl -w

#my global vars
@mydays = ("monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday");


# let's clear the screen
print "\033[2J";    #clear the screen
print "\033[0;0H"; #jump to 0,0

# bold chars


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

  if    ($user_input eq "exit")    { print "\nThank you for using the control panel\n\n"; last; }
  elsif ($user_input eq "help")    { help(); }
  elsif ($user_input eq "users")   { users(); }
  elsif ($user_input eq "sensors") { sensors(); }
  elsif ($user_input eq "mount")   { system("mount /home/stam/box.com"); }
  elsif ($user_input eq "umount")  { system("umount /home/stam/box.com"); }
  elsif ($user_input eq "live")    { live(); }
  elsif ($user_input eq "scan")    { scan(); }
  elsif ($user_input eq "matlab_time") { matlab_time(); }
  elsif ($user_input eq "matlab_day")  { matlab_day(); }
  elsif ($user_input eq "")        { } # do nothing - enter pressed
  else                             { print "unknown command - type help for more options";  }

  print "\ncontrol panel> ";
}


# Program's user options -- Function definitions
sub help{
  print "\n\n                        HELP \n\n";
  print "Back-end Software of Control Panel (Sensor Tags Wireless Network)\n";
  print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n";
  print "Available commands:\n";
  print "\n\tusers\n\n";
  print "-List all the registered users (appear in the logfile).\n";
  print "\n\tsensors\n\n";
  print "-List all the installed Sensor Tag TI(TM) sensors (appear in the logfile).\n";
  print "\n\tmount\n\n";
  print "-Mount the remote Box.com repository via WebDAV protocol.\n";
  print "\n\tumount\n\n";
  print "-Unmount the already mounted remote Box.com repository.\n";
  print "\n\tscan\n\n";
  print "-List the latest position of all registered users for today.\n";
  print "\n\tlive\n\n";
  print "-Track live a particular user for its movements at real time.\n\n";
  print "\n\nLogistic Regression (Machine Learning Techniques) are applied using MATLAB software:\n";
  print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n";
  print "Available commands:\n";
  print "\n\tmatlab_day\n\n";
  print "-Compute the probability of a user to be at his lab a specific day.\n";
  print "\n\tmatlab_time\n\n";
  print "-Compute the probability of a user to be at his lab right now.\n\n";
  #print "\t\t\t\t\t\t      Documentation:\n\t\t\t\t\t\t Stamoulis Dimitrios\n\t\t\t\t(dimitrios.stamoulis\@mail.mcgill.ca)\n\n";
}


# subroutine to parse and print users
sub users{
 my (@users) = parseLogFileUsers();
 if (@users)  {   # users found or error msg

   foreach my $val (@users) {
      print "\n${val}";
   }
   print "\n";

 } else {
   print "No registered users!\n";
 }
 
}






sub parseLogFileUsers{

  my @array1;
  # open logfile
  if (open RD, "./control.log") {
    while ( (my $line = <RD>) ) 
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



# subroutine to parse and print sensors
sub sensors{

 my (@sensors) = parseLogFileSensors();
 if (@sensors)  {   # users found or error msg

   foreach my $val (@sensors) {
      print "\n${val}";
   }
   print "\n";

 } else {
   print "No installed sensors!\n";
 }
 
}

sub parseLogFileSensors{

  my @array1;
  # open logfile
  if (open RD, "./control.log") {
    while ( (my $line = <RD>) ) 
    {
        if ( $line =~ m/sensor: (.*)/ )
        {
            my @values = split(', ',$1);
    	    push (@array1, @values[1]);
        }
    }
    close RD;
    return (@array1);
  } else {

    my @array1 = ("Can't open the logfile file: control.log");
    return (@array1);
  }  
}


sub parseLogFileSensorIDs{

  my @array1;
  # open logfile
  if (open RD, "./control.log") {
    while ( (my $line = <RD>) ) 
    {
        if ( $line =~ m/sensor: (.*)/ )
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



sub live{

  print "\nLive Tracking of a user\n";
  print "~~~~~~~~~~~~~~~~~~~~~~~\n";
  print "The following users are registered:";
  $reg_users = 1;
  $user_found = 0;
  $user_counter;
  $counter = 0;

  my (@users) = parseLogFileUsers();
  if (@users)  {   # users found or error msg
     
   if (@users[0] eq "Can't open the logfile file: control.log")
   { $reg_users = 0;}

   foreach my $val (@users) {
       print "\n${val}";
   }
   print "\n";

  } else {
   $reg_users = 0;
   print "No registered users!\n";
  }

  print "\n";

  if ($reg_users){
  
    print "Please give user's name or press 'q' to exit: ";
    while (<STDIN>) {

      # read user's name
      $user_name = $_;
      chop ($user_name);

  	if ($user_name eq "q") 
        { 
	  last; 
        } else { 
	  
          foreach my $val (@users) {
            if (${val} eq ${user_name}){
		$user_counter = $counter;
		$user_found = 1;
	    }
	    $counter++;
	  }

	  if (!$user_found){
              print "unknown user -- please try again\n";  
              print "Please Give user's name or press 'q' to exit: "
	  }else{ 
	      last;
	  }
        }
     } # end while
 
     if ($user_found){

        my (@IDs) = parseLogFileIDs();
        print "\nLive activity of ${user_name} (Press any key to return to main menu):\n\n";
	($sec,$min,$hour,$mday,$mon, $year,$wday,$yday,$isdst) = localtime(time);

	# use 2>/dev/null to suppress the error message to the bit bucket
	my $stat = system("cp /home/stam/box.com/@IDs[$user_counter]_@mydays[$wday-1].txt ./ 2>/dev/null");
 
        if (open RD, "./@IDs[$user_counter]_@mydays[$wday-1].txt") {
          close RD; # close it - it's here
	  monitorUser("@IDs[$user_counter]_@mydays[$wday-1].txt");
        } else {
	  print "\nExiting - No history for this user today!!\n"
        }

     }


   } # end if users exist

}


sub parseLogFileIDs{

  my @array1;
  # open logfile
  if (open RD, "./control.log") {
    while ( (my $line = <RD>) ) 
    {
        if ( $line =~ m/user: (.*)/ )
        {
            my @values = split(', ',$1);
    	    push (@array1, @values[1]);
        }
    }
    close RD;
    return (@array1);
  } else {

    my @array1 = ("Can't open the logfile file: control.log");
    return (@array1);
  }  
}



sub monitorUser(){

  use strict;
  use warnings;
  use Term::ReadKey;

  ReadMode 4;    # Turn off controls keys
  my $key;
  my $last_position = "nullPosition";
  my $current_position = "nullPosition";
  my @values;

  my $first_time = 1;

  my (@sensors) = parseLogFileSensors();
  my (@sensorsIDs) = parseLogFileSensorIDs();

  while ( !defined( $key = ReadKey(-1) ) )
  {

    # keep where you were before as a reference
    my $last_position = $current_position;

    # get latest version of file     
    # use 2>/dev/null to suppress the error message to the bit bucket
    my $doCp = system("cp /home/stam/box.com/$_[0] ./ 2>/dev/null");

    # parse the box.com log file
    open RD, "./$_[0]"; 
    while ( (my $line = <RD>) ) 
    {
        @values = split(' ',$line);
        #foreach my $val (@values) {
        #       print "${val} ";
        #}              
    }
    close RD; #close file to re-open it and repeat check

    # check if I changed position
    if ($values[0]){
       $current_position = $values[0];
    }

    if ( !($current_position eq $last_position))
    {
      if (!$first_time)
      {
        print "User is just located at ";
        my $sensor_counter = 0;

        foreach my $val (@sensorsIDs) {

            if ($val eq $current_position)
               { print "@sensors[$sensor_counter].\n"  }
            $sensor_counter++;    
        } 
      }
      $first_time = 0;
    }
  }

  #print "Get key $key\n";
  ReadMode 0;    # Reset tty mode before exiting

}


sub scan{

  print "\nLatest Update for all users\n";
  print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
  #print "Our users are recently tracked at:";
  $regs_users = 1;
  $user_counter = 0;

  my (@users) = parseLogFileUsers();
  if (@users)  {   # users found or error msg
     
   if (@users[0] eq "Can't open the logfile file: control.log")
   { $regs_users = 0;}

  } else {
    $regs_users = 0;
    print "No registered users!\n";
  }

  print "\n";

  if ($regs_users){
   
   # let's scan their IDs   
   my (@IDs) = parseLogFileIDs();
   ($sec,$min,$hour,$mday,$mon, $year,$wday,$yday,$isdst) = localtime(time);
  
   foreach my $val (@users) {

      print "\n${val} ";
        if (open RD, "./@IDs[$user_counter]_@mydays[$wday-1].txt") {
          close RD; # close it - it's here
	  scanUser("./@IDs[$user_counter]_@mydays[$wday-1].txt");
        } else {
	  print "has not tracked history today!!"
        }
      $user_counter++;
   }
   print "\n";

   } # end if users exist
}



sub scanUser(){

  my $key;
  my $current_position = "nullPosition";
  my @values;

  # keep where you were before as a reference
  my $last_position = $current_position;

  # parse the box.com log file
  open RD, $_[0]; 
  while ( (my $line = <RD>) ) 
  {
      @values = split(' ',$line);
  }
  close RD; #close file to re-open it and repeat check

  # check if I changed position
  $current_position = $values[0];
  print "is lately tracked at ";

  my (@sensors) = parseLogFileSensors();
  my (@sensorsIDs) = parseLogFileSensorIDs();
  my $sensor_counter = 0;

  foreach my $val (@sensorsIDs) {
     
     if ($val eq $current_position)
     { print "@sensors[$sensor_counter]."  }
     $sensor_counter++;    
  } 

}



sub matlab_day{

  print "\nRegression Analysis (Machine Learning) - MATLAB Interface\n";
  print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
  print "The following users are registered:";
  $reg_users = 1;
  $user_found = 0;
  $user_counter;
  $counter = 0;

  my (@users) = parseLogFileUsers();
  if (@users)  {   # users found or error msg
     
   if (@users[0] eq "Can't open the logfile file: control.log")
   { $reg_users = 0;}

   foreach my $val (@users) {
       print "\n${val}";
   }
   print "\n";

  } else {
   $reg_users = 0;
   print "No registered users!\n";
  }

  print "\n";

  if ($reg_users){
 
    print "Please give user's name or press 'q' to exit: ";
    while (<STDIN>) {

      # read user's name
      $user_name = $_;
      chop ($user_name);

        if ($user_name eq "q")
        {
          last;
        } else {

          foreach my $val (@users) {
            if (${val} eq ${user_name}){
                $user_counter = $counter;
                $user_found = 1;
            }
            $counter++;
          }

          if (!$user_found){
              print "unknown user -- please try again\n";
              print "Please Give user's name or press 'q' to exit: "
          }else{
              last;
          }
        }
     } # end while


  if ($user_found){
 
    print "Please select the day's number (1=Monday, 2=Tuesday, ...): ";
    while (<STDIN>) {

      # read day name
      $sel_dayname = $_;
      chop ($sel_dayname);

  	if ($sel_dayname < 1 || $sel_dayname > 7) 
        { print "\nwrong day -- please try again: ";} 
	else{ last; }

     } # end while
 
    # call MATLAB from command line !!!
    system("/usr/local/MATLAB/R2012b/bin/matlab -nojvm -nodesktop -r \"select = ${sel_dayname}; run ./machine_learning/logistic_regression_day.m; quit\"");

   }

   } # end if users exist

}




sub matlab_time{

  print "\nRegression Analysis (Machine Learning) - MATLAB Interface\n";
  print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
  print "The following users are registered:";
  $reg_users = 1;
  $user_found = 0;
  $user_counter;
  $counter = 0;

  my (@users) = parseLogFileUsers();
  if (@users)  {   # users found or error msg
     
   if (@users[0] eq "Can't open the logfile file: control.log")
   { $reg_users = 0;}

   foreach my $val (@users) {
       print "\n${val}";
   }
   print "\n";

  } else {
   $reg_users = 0;
   print "No registered users!\n";
  }

  print "\n";

  if ($reg_users){
 
    print "Please give user's name or press 'q' to exit: ";
    while (<STDIN>) {

      # read user's name
      $user_name = $_;
      chop ($user_name);

        if ($user_name eq "q")
        {
          last;
        } else {

          foreach my $val (@users) {
            if (${val} eq ${user_name}){
                $user_counter = $counter;
                $user_found = 1;
            }
            $counter++;
          }

          if (!$user_found){
              print "unknown user -- please try again\n";
              print "Please Give user's name or press 'q' to exit: "
          }else{
              last;
          }
        }
     } # end while


  if ($user_found){
 
    #print "Please select the day's number (1=Monday, 2=Tuesday, ...): ";
    #while (<STDIN>) {

      ## read day name
      #$sel_dayname = $_;
      #chop ($sel_dayname);

      #	if ($sel_dayname < 1 || $sel_dayname > 7) 
      #  { print "\nwrong day -- please try again: ";} 
      #	else{ last; }

    #} # end while

    ($sec,$min,$hour,$mday,$mon, $year,$wday,$yday,$isdst) = localtime(time); 
    # call MATLAB from command line !!!
    system("/usr/local/MATLAB/R2012b/bin/matlab -nojvm -nodesktop -r \"select = ${hour}+1; run ./machine_learning/logistic_regression_time.m; quit\"");

   }

   } # end if users exist

}



