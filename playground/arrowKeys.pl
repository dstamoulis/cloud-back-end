#!/usr/bin/perl -w 
use strict; 
use Term::ReadKey; 
ReadMode 4; 
while( (my $key = ReadKey(0)) ne 'q') 
{ 
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
        print $key,"\n"; 
      }
}
ReadMode 0; 
