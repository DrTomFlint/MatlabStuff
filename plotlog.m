%--------------------------------------------------------------------------
% plotlog.m
% Quick plotting script for a data log that was fetched with canget.m
%
% Use:     plotlog
% Inputs:  none.
% Outputs: pops up a figure window
% Errors:  none.
% Calls:   intrinsic only.
%
%--------------------------------------------------------------------------

figure
h=gcf;
set(h,'NumberTitle','off');
pPosition=get(0,'MonitorPositions');
pPosition(1,:)=pPosition(1,:)+[-4 34 0 -104];
set(h,'Position',pPosition(1,:));
set(h,'Name',LogDate);

% chose the number of rows and cols
switch(LogChan),
    case 1,
        r=1;
        c=1;
    case 2,
        r=2;
        c=1;
    case 3,
        r=3;
        c=1;
    case 4,
        r=2;
        c=2;
    case 5,
        r=2;
        c=3;
    case 6,
        r=2;
        c=3;
    case 7,
        r=3;
        c=3;
    case 8,
        r=3;
        c=3;
    case 9,
        r=3;
        c=3;
end;

% make a time axis
LogT = LogTs*(LogSkip+1)*[0:LogLength-1];

% draw the plots
for i=1:LogChan,
    subplot(r,c,i);
    plot(LogT,LogBuf(:,i),'-b');
    grid;
    xlabel(LogName{i});
    if(i==1),
        title(LogDate);
    end;
end;
       
%--------------------------------------------------------------------------
