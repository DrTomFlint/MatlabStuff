function setx(varargin)
% setx(xmin, xmax);
% This sets the x limits on all subplots of the current figure
% with no arguments all subplots are autoscaled in x,
% with one argument it assumes 0.0 for xmin,
% with two arguments it sets both xmin and xmax.

plts=get(gcf,'Children');

% with no args reset all to auto scaling.
if nargin==0,
	for i=1:max(size(plts))
	   if strcmp(get(plts(i),'Type'),'axes')
   		set(plts(i),'XLimMode','auto');
      end
   end
	return;   
end

if nargin==1
   xmin=0;
   xmax=varargin{1};
end;

if nargin==2
   xmin=varargin{1};
   xmax=varargin{2};
end;

for i=1:max(size(plts))
   if strcmp(get(plts(i),'Type'),'axes')
      set(plts(i),'XLim',[xmin xmax]);
   end
end;
