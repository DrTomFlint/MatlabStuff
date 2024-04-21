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

fprintf('Index     Time1       Time2         Code        Data1    Data2\n');
% read each of the arrays
for i=1:EventSize,

    % printout
    fprintf('%3d\t %10d\t %10d\t %10d\t %10d\t %10.4f\n', ...
             i-1,EventTime1(i),EventTime2(i),EventCode(i),EventData1(i),EventData2(i));

    if(i==EventIndex),
        fprintf('-------------------------------------------------------------------\n');
    end;
    
end;


%--------------------------------------------------------------------------
