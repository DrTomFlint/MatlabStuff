%--------------------------------------------------------------------------
% getlog.m
% Can bus fetch of the data Log
%
% Use:     getlog
% Inputs:  none.
% Outputs: ??
% Errors:  possible warnings if CAN bus is not operable.
% Calls:   mex4.mexw32.
%
%--------------------------------------------------------------------------

RT0=clock;          % record time at start of simulation

% fetch the Log setup 
LogChan = canrdi('LogChan');
LogLength = canrdi('LogLength');
LogSkip = canrdi('LogSkip');
LogSingle = canrdi('LogSingle');
LogCount = canrdi('LogCount');
LogBaseAddr = getaddr('LogBuf');

% fetch the addresses that were Logged
LogAddr(1)=canrdi('LogAddr0');
LogAddr(2)=canrdi('LogAddr1');
LogAddr(3)=canrdi('LogAddr2');
LogAddr(4)=canrdi('LogAddr3');
LogAddr(5)=canrdi('LogAddr4');
LogAddr(6)=canrdi('LogAddr5');
LogAddr(7)=canrdi('LogAddr6');
LogAddr(8)=canrdi('LogAddr7');
LogAddr(9)=canrdi('LogAddr8');

% convert addresses to variable names
for i=1:LogChan,
    if(LogAddr(i)<0),
        LogAddr(i)=LogAddr(i)+2^16;
    end;
    LogName{i}=getname(LogAddr(i));
end;

% fetch the actual data
LogBuf = zeros(LogChan,LogLength);
i=0;
for LogRow = 1:LogChan,
    for LogCol = 1:LogLength,
        % try to read a float at the address using the CAN
        LogBuf(LogRow,LogCol)=canrdf('LogBuf',i);
        i=i+1;
        end;
    end;
 

% re-order data if circular buffer was used
if(LogSingle==0),
    if(LogCount<LogLength),
        LogTemp1=LogBuf(:,1:LogCount);
        LogTemp2=LogBuf(:,LogCount+1:LogLength);
        LogBuf=[LogTemp2 LogTemp1];        
    end;
end;    
    
% transpose to match simulation plots
LogBuf=LogBuf';

% record the time this was fetched
LogDate = datestr(now);

% read the sampling time
LogTs = canrdf('Ts');

RTf = clock;
RTe = etime(RTf,RT0);
fprintf('Log fetched in %6.4f seconds\n',RTe);

   
%--------------------------------------------------------------------------
