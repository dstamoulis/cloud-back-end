%% ECSE 649: VLSI Testing project 
% Machine Learning Applications for WSN Back-End
% 
% Logistic Regression - Predicting probability for user to be at his lab
% for a given day...!!!
%
% Developed: Stamoulis Dimitrios (McGill ID 260569510)
% contact: dimitrios.stamoulis@mail.mcgill.ca
%
%                                          April 2014, Montreal, Canada
%
%%

%clear all

% parse the days
% Mondays
mondayz = 0;

X = importdata('./xinchi.chen@mail.mcgill.ca_monday.txt', ' ');
parsed = cell2mat(X);

NumDays = size(parsed);
current_day = ' ';
next_day = ' ';

for i=1:1:NumDays(1)
    
   next_day = parsed(i,19:28);
   if (~strcmp(next_day,current_day))
       mondayz = mondayz +1;
   end    
   current_day = next_day;
   
end


% Tuesdays
tuesdayz = 0;

X = importdata('./xinchi.chen@mail.mcgill.ca_tuesday.txt', ' ');
parsed = cell2mat(X);

NumDays = size(parsed);
current_day = ' ';
next_day = ' ';

for i=1:1:NumDays(1)
    
   next_day = parsed(i,19:28);
   if (~strcmp(next_day,current_day))
       tuesdayz = tuesdayz +1;
   end    
   current_day = next_day;
   
end


% Wednesdays
wednesdayz = 0;

X = importdata('./xinchi.chen@mail.mcgill.ca_wednesday.txt', ' ');
parsed = cell2mat(X);

NumDays = size(parsed);
current_day = ' ';
next_day = ' ';

for i=1:1:NumDays(1)
    
   next_day = parsed(i,19:28);
   if (~strcmp(next_day,current_day))
       wednesdayz = wednesdayz +1;
   end    
   current_day = next_day;
   
end

% Thursdays
thursdayz = 0;

X = importdata('./xinchi.chen@mail.mcgill.ca_thursday.txt', ' ');
parsed = cell2mat(X);

NumDays = size(parsed);
current_day = ' ';
next_day = ' ';

for i=1:1:NumDays(1)
    
   next_day = parsed(i,19:28);
   if (~strcmp(next_day,current_day))
       thursdayz = thursdayz +1;
   end    
   current_day = next_day;
   
end

% Fridays
fridayz = 0;

X = importdata('./xinchi.chen@mail.mcgill.ca_friday.txt', ' ');
parsed = cell2mat(X);

NumDays = size(parsed);
current_day = ' ';
next_day = ' ';

for i=1:1:NumDays(1)
    
   next_day = parsed(i,19:28);
   if (~strcmp(next_day,current_day))
       fridayz = fridayz +1;
   end    
   current_day = next_day;
   
end



% Saturdays
saturdayz = 0;

X = importdata('./xinchi.chen@mail.mcgill.ca_saturday.txt', ' ');
parsed = cell2mat(X);

NumDays = size(parsed);
current_day = ' ';
next_day = ' ';

for i=1:1:NumDays(1)
    
   next_day = parsed(i,19:28);
   if (~strcmp(next_day,current_day))
       saturdayz = saturdayz +1;
   end    
   current_day = next_day;
   
end


% Sundays
sundayz = 0;

X = importdata('./xinchi.chen@mail.mcgill.ca_sunday.txt', ' ');
parsed = cell2mat(X);

NumDays = size(parsed);
current_day = ' ';
next_day = ' ';

for i=1:1:NumDays(1)
    
   next_day = parsed(i,19:28);
   if (~strcmp(next_day,current_day))
       sundayz = sundayz +1;
   end    
   current_day = next_day;
   
end


dayz = [ mondayz tuesdayz wednesdayz thursdayz fridayz saturdayz sundayz ];


% The generated experimental data emulate activity over a period of 9 weeks
% Thus the counted days are out of 9 Mondays, Tuesdays etc...

% For instance, the user was not at his lab 1 out of 9 wednesdays.
% We annotate a day of being at the lab with "2" and with "1" for not
% being at the lab..!!

% We also represent each day with the respective number -> 1 for Monday, 2
% for Tuesday etc...

Days = 63;
TotalWeeks = 9;
WeekDays = 7;
counter = 0;

for k=1:1:WeekDays
  for i=1:1:TotalWeeks
    Days((k-1)*TotalWeeks+i) = k; 
    if (i<=dayz(k))
         BeingAtLab((k-1)*TotalWeeks+i) = 2;
    else
         BeingAtLab((k-1)*TotalWeeks+i) = 1;
    end            
  end
end

    

% applying logistic regression
B = mnrfit( (1:1:9)', BeingAtLab((select-1)*TotalWeeks + 1 : (select)*TotalWeeks)' );
pred = mnrval( B, (1:1:9)' );

% notify the front end software
prob = mean(pred(:,2));
fprintf( 1, 'There is a %0.2f%% chance for the selected user to be at his lab the selected day.\n', ...
    prob*100 );



