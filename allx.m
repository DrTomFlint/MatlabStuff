% allx.m    This script works like pltx but effects all the figure windows
%           instead of just the active window.
%
% pltx(xmin, xmax);
% This sets the x limits on all subplots of the current figure
% with no arguments all subplots are autoscaled in x,
% with one argument it assumes 0.0 for xmin,
% with two arguments it sets both xmin and xmax.

function allx(varargin)

% get handles for all the figure windows.
r0=get(0,'Children');
Nfig=max(size(r0));
for i0=1:Nfig,
   c0=num2str(i0);
   % get handles for each subplot of the figure
   eval(['plts=get(r0(i0),''Children'');']);
   if nargin==0,
      % if no arguments supplied reset axis to autoscale
   	for i=1:max(size(plts))
   	   if strcmp(get(plts(i),'Type'),'axes')
      		set(plts(i),'XLimMode','auto');
         end
      end
   else
      % with one argument set min to zero 
      if nargin==1
         xmin=0;
         xmax=varargin{1};
      end;
      % with two args set min and max
      if nargin==2
         xmin=varargin{1};
         xmax=varargin{2};
      end;
      % for each subplot set manual axis scaling
      for i=1:max(size(plts))
         if strcmp(get(plts(i),'Type'),'axes')
            set(plts(i),'XLim',[xmin xmax]);
         end
      end;
   end;

end;




