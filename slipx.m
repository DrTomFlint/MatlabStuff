% slipx.m  This script displays a sequence of zooms on the plot windows
%
% No arguments: start t=0, step 0.1, width 2/60
%  1 argument: start t=0, step <arg1>, width 2/60
%  2 argument: start t=<arg1>, step <arg2>, width 2/60
%  3 argument: start t=<arg1>, step <arg2>, width <arg3>
%
%

function slipx(varargin)

  if nargin==0,
      % if no arguments supplied the use defaults:
      x0=0;
      xstep=0.1;
      xwide=2/60;
  elseif nargin==1,
      % one argument:
      x0=0;
      xstep=varargin{1};
      xwide=2/60;
  elseif nargin==2,
      % 2 arguments:
      x0=varargin{1};
      xstep=varargin{2};
      xwide=2/60;
  elseif nargin==3,
      % 3 arguments:
      x0=varargin{1};
      xstep=varargin{2};
      xwide=varargin{3};
  end;
  
  for x=x0:xstep:20*xstep+x0,
      allx(x,x+xwide);
%      samey2(1);
      fprintf('from %7.4f to %7.4f showing %7.4f seconds or %7.4f cycles\n',x,x+xwide,xwide,xwide*60);
      pause;
  end;
  
  
  
  
  




