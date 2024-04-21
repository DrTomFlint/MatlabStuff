% initmap.m   This script sets up the globals that are used with
% readmap(), getaddress(), and getsymbol() functions.  This is required
% since a function cannot add a global variable into the workspace.
% Users will want to edit this file to establish the correct path to the
% mapfile.  This also creates the global xSerial which will be used to hold
% the serial port handle when sciopen() is used.

global xAddress;
global xSymbol;
global xMapfile;

% Add the path to your mapfile here:
xMapfile = 'C:\Users\tflint\TestRigs\Debug\TestRig1.map';
