%--------------------------------------------------------------------------
% showevents.m
% Parse an event log to human readable form
%
% Use:     showevents
%          Must have run getevents and still have the EventXXX variables
%          in the workspace.
% Inputs: EventSize, integer length of event buffer
%          EventIndex, integer current event index
%          EventCode[], integer array of event codes
%          EventTime1[], long integer array MSB of timestamp
%          EventTime2[], long integer array LSB of timestamp
%          EventData1[], integer array optional argument of event
%          EventData2[], float array optional argument of event
% Outputs: Text
% Errors:  possible warnings if CAN bus is not operable.
% Calls:   mex4.mexw32.
%
%--------------------------------------------------------------------------

EventText=[];
EventFetch = cantime;

fprintf('====================================================  %12.6f  \n',EventFetch);
fprintf('Index     Time      Event\n');

i=0;
for i=EventIndex: -1 : 1,
        
    switch(EventCode(i))
        case 0,
            EventText = ' ';
        case 1,
            if(EventData2(i)==0),
                EventText = sprintf('Start Command Ignored, not Ready');
            else
                EventText = sprintf('Start Command mode %2.0f',EventData2(i));
            end;
        case 2,
            EventText = sprintf('Stop Command');
        case 3,
            EventText = sprintf('Reset Faults Command');
        case 4,
            EventText = sprintf('Force Fault Command');
        case 5,
            EventText = sprintf('State Changed to %s',getstate(EventData1(i)));
        case 6,
            EventText = sprintf('Parameter %s set to %f',getparam(EventData1(i)),EventData2(i));
        case 7,
            EventText = sprintf('Fault %s',getfault(EventData1(i),EventData2(i)));
        case 8,
            EventText = sprintf('Datalog Trigger set to %d with skip %4.0f',EventData1(i),EventData2(i));
        case 9,
            EventText = sprintf('Speed Setpoint changed to %6.1f RPM',EventData2(i));
        case 10,
            EventText = '';
            if(EventData1(i)==1) EventText = sprintf('Parameters Loaded from Flash'); end;
            if(EventData1(i)==2) EventText = sprintf('Parameters Saved to Flash'); end;
            if(EventData1(i)==3) EventText = sprintf('Parameters Set to Default'); end;
            if(EventData1(i)==4) EventText = sprintf('Parameters Set to Zero'); end;
            if(max(size(EventText))==0) EventText = sprintf('Undefined Flash Event %d',EventData1(i)); end;
        otherwise,
            EventText = sprintf('Unknown Event Code %d with data1 %d, data2 %f',EventCode(i),EventData1(i),EventData2(i));            
    end;
    
    % printout
%    fprintf('%3d\t %10d\t %10d\t     %s\n', ...
%             i-1,EventTime1(i),EventTime2(i),EventText);
    fprintf('%3d\t %12.6f\t %s\n', ...
             i-1,EventTime1(i)*1e-3+EventTime2(i)*6.66667e-9,EventText);
    
end;

for i=EventSize:-1:EventIndex+1,
        
    switch(EventCode(i))
        case 0,
            EventText = ' ';
        case 1,
            if(EventData2(i)==0),
                EventText = sprintf('Start Command Ignored, not Ready');
            else
                EventText = sprintf('Start Command mode %2.0f',EventData2(i));
            end;
        case 2,
            EventText = sprintf('Stop Command');
        case 3,
            EventText = sprintf('Reset Faults Command');
        case 4,
            EventText = sprintf('Force Fault Command');
        case 5,
            EventText = sprintf('State Changed to %s',getstate(EventData1(i)));
        case 6,
%            EventText = sprintf('Parameter %d set to %f',EventData1(i),EventData2(i));
            EventText = sprintf('Parameter %s set to %f',getparam(EventData1(i)),EventData2(i));
        case 7,
            EventText = sprintf('Fault %s',getfault(EventData1(i),EventData2(i)));
        case 8,
            EventText = sprintf('Datalog Trigger set to %d with skip %4.0f',EventData1(i),EventData2(i));
        case 9,
            EventText = sprintf('Speed Setpoint changed to %6.1f RPM',EventData2(i));
        case 10,
            EventText = '';
            if(EventData1(i)==1) EventText = sprintf('Parameters Loaded from Flash'); end;
            if(EventData1(i)==2) EventText = sprintf('Parameters Saved to Flash'); end;
            if(EventData1(i)==3) EventText = sprintf('Parameters Set to Default'); end;
            if(EventData1(i)==4) EventText = sprintf('Parameters Set to Zero'); end;
            if(max(size(EventText))==0) EventText = sprintf('Undefined Flash Event %d',EventData1(i)); end;
        otherwise,
            EventText = sprintf('Unknown Event Code %d with data1 %d, data2 %f',EventCode(i),EventData1(i),EventData2(i));            
    end;
    
    % printout
%    fprintf('%3d\t %10d\t %10d\t     %s\n', ...
%             i-1,EventTime1(i),EventTime2(i),EventText);
    fprintf('%3d\t %12.6f\t %s\n', ...
             i-1,EventTime1(i)*1e-3+EventTime2(i)*6.66667e-9,EventText);
    
end;

fprintf('==================================================================\n');


%--------------------------------------------------------------------------
