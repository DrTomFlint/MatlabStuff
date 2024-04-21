% Set the y axis on each subplot on all figure windows to autoscale.

function autoy()

% Get handles for all figures, get Y limits for all subplots.
r0=get(0,'Children');
Nfig=max(size(r0));
for i0=1:Nfig,
   c0=num2str(i0);
   eval(['r' c0 '=get(r0(i0),''Children'');']);
   eval(['yl' c0 '=get(r' c0 ',''YLim'');']);
end;

Nplts=max(size(r1));

% Set axis limits for each subplot across all figure windows.
for i1=1:Nfig,
   c1=num2str(i1);
   eval(['Nplts =  max(size(r' c1 '));']);
   for i2=1:Nplts,
      c2=num2str(i2);
      eval(['set(r' c1 '(' c2 '),''YLimMode'',''Auto'');']);
   end;
end;