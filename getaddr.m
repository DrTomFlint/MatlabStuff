%--------------------------------------------------------------------------
% getaddr.m   This function returns the address of a symbol or -1 if that
% symbol is not found in the lookup table contained in global variables
% xAddress and xSymbol.  Those globals are created by initmap and readmap.
%
% call:   addr=getaddr(symb);
%
% inputs: symb - a string naming the symbol
%         xSymbol - a global cell array of strings containing names (from readmap)
%         xAddress - a global array of corresponding addresses (from readmap)
%
% outputs: addr - the address of the symbol
%
%--------------------------------------------------------------------------

function addr=getaddr(symb)

global xAddress;
global xSymbol;

% Get the length of these lookup tables
len=max(size(xAddress));

% Add an underscore, names in the mapfile and xSymbol have _varname 
symb = ['_' symb];

% Start looking for the desired symbol
for i=1:len,
    if (strcmp(symb,xSymbol{i}) == 1),
        addr=xAddress(i);
        return;
    end;
end;

% If symbol never matched return -1
addr=-1;
return;

%--------------------------------------------------------------------------

