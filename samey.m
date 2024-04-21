% Set the y axis on each subplot to accomodate the maximum range over all figure windows.

function samey()

autoy();

% Get handles for all figures, get Y limits for all subplots.
r0=get(0,'Children');
Nfig=max(size(r0));
for i0=1:Nfig,
   c0=num2str(i0);
   eval(['r' c0 '=get(r0(i0),''Children'');']);
   eval(['yl' c0 '=get(r' c0 ',''YLim'');']);
end;

% Extract limit info from cells, place in matrices.
Nplts=max(size(r1));
for i1=1:Nplts,   
   c1=num2str(i1);
   eval(['ym' c1 '=[];']);
   for i2=1:Nfig,
      c2=num2str(i2);
      eval(['ym' c1 '=[ym' c1 ';yl' c2 '{' c1 '}];']);
   end;
end;

% Find min and max for each subplot across all figure windows.
for i1=1:Nplts,
   c1=num2str(i1);
   eval(['ylo' c1 '=min(ym' c1 ');']);
   eval(['yhi' c1 '=max(ym' c1 ');']);
   eval(['ylim' c1 '=[ylo' c1 '(1) yhi' c1 '(2)];']);
end

% Set axis limits for each subplot across all figure windows.
for i1=1:Nfig,
   c1=num2str(i1);
   for i2=1:Nplts,
      c2=num2str(i2);
      eval(['set(r' c1 '(' c2 '),''YLim'',ylim' c2 ');']);
   end;
end;