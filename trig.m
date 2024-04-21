%--------------------------------------------------------------------------
% trig.m
% Can bus manipulation of the LogTrigger
%
% Use:     trig(x)
% Inputs:  x, value to set the trigger to.
% Outputs: none.
% Errors:  possible warnings if CAN bus is not operable.
% Calls:   mex4.mexw32.
%
%--------------------------------------------------------------------------
function trig(x)

canwri('LogTrigger',x);

%--------------------------------------------------------------------------
