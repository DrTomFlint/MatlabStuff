%--------------------------------------------------------------------------
% readmap.m   This is a function to read the map file generated by the linker
% and make a table in the matlab workspace that can be used for symbol to
% address translations.  Note that initmap must be run first to setup the
% global variables that is file requires.
%
% call:    readmap(mapfile)
%
% inputs:  mapfile is a string containing the path to the .map file
%
% outputs: xSymbol - a global cell array of strings that contain symbol names
%          xAddress - a global matrix of addresses corresponding to those symbols
%
% To access the cell array use curly brackets, so symb{745} will give the
% name of the 745th symbol, and addr(745) is its address.
%
%
%--------------------------------------------------------------------------

function readmap

% setup globals in the workspace
global xMapfile;
global xSymbol;
global xAddress;

% Get user to agree that the mapfile is the correct one
%fprintf('mapfile is %s\n    Are you sure? ',xMapfile);
%x=input(' <y,n> ','s');
%if(x~='y'),
%    xAddress=[];
%    xSymbol=[];
%    fprintf('\n readmap exiting\n');
%    return;
%end;    

% open the file for reading
fid = fopen(xMapfile,'rt');
if fid== -1,
    fprintf('Cannot open map file %s\n',xMapfile);
end;

% Read lines until one is found matches this text:
str1 = fgetl(fid);
x=findstr(str1,'GLOBAL SYMBOLS: SORTED BY');
while( isempty(x) ),
    str1 = fgetl(fid);
    x=findstr(str1,'GLOBAL SYMBOLS: SORTED BY');
end;

% Read and discard 3 more lines:
str1 = fgetl(fid);
str1 = fgetl(fid);
str1 = fgetl(fid);

% Begin reading address and symbol stop when address 0xffffffff appears
i=1;
a = '0000dead';

while( strcmp(a,'ffffffff') == 0 ),
    str1 = fgetl(fid);
    [a,s]=strread(str1,'%s%s','delimiter',' ');
    
    xAddress(i) = hex2dec(a);
    xSymbol{i} = s;
    i=i+1;
end;

fclose(fid);

fprintf('mapfile read ok\n');

%--------------------------------------------------------------------------
