%--------------------------------------------------------------------------
% getname.m   This function returns the symbolic name of an address or -1
% if the address is not found in the lookup table contained in global variables
% xAddress and xSymbol.  Those globals are created by initmap and readmap.
%
% call:   name=getname(addr);
%
% inputs: addr - a numerical address
%         xSymbol - a global cell array of strings containing names (from readmap)
%         xAddress - a global array of corresponding addresses (from readmap)
%
% outputs: name - the variable name associated with the address
%
%--------------------------------------------------------------------------

function name=getname(addr)

global xAddress;
global xSymbol;

% Get the length of these lookup tables
len=max(size(xAddress));

% Start looking for the desired symbol
for i=1:len,
    if (xAddress(i)==addr),
        name=cell2mat(xSymbol{i});  % convert cell to regular array
        j=length(name);             
        name=name(2:j);             % strip leading underscore
        return;
    end;
end;

% If symbol never matched return -1
name='undefined';
return;

%--------------------------------------------------------------------------

