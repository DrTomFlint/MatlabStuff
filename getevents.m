%--------------------------------------------------------------------------
% getevents.m
% Can bus fetch of the event log
%
% Use:     getevents
% Inputs:  none.
% Outputs: EventSize, integer length of event buffer
%          EventIndex, integer current event index
%          EventCode[], integer array of event codes
%          EventTime1[], long integer array MSB of timestamp
%          EventTime2[], long integer array LSB of timestamp
%          EventData1[], integer array optional argument of event
%          EventData2[], float array optional argument of event
% Errors:  possible warnings if CAN bus is not operable.
% Calls:   mex4.mexw32.
%
%--------------------------------------------------------------------------

% get the size of the event log and the current index
EventSize = canrdi('EventSize');
EventIndex = canrdi('EventIndex');

% pre-allocate and zero some storage
EventCode=zeros(EventSize,1);
EventTime1=zeros(EventSize,1);
EventTime2=zeros(EventSize,1);
EventData1=zeros(EventSize,1);
EventData2=zeros(EventSize,1);

% read each of the arrays
for i=1:EventSize,
    EventCode(i)=canrdi('EventCode',i-1);
    EventTime1(i)=canrdl('EventTime1',i-1);
    EventTime2(i)=canrdl('EventTime2',i-1);
    EventData1(i)=canrdi('EventData1',i-1);
    EventData2(i)=canrdf('EventData2',i-1);
    
end;


%--------------------------------------------------------------------------
