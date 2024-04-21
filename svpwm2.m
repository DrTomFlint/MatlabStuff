% -----------------------------------------------------------------------
% svpwm2.m
% 
% This calculates gate times for space vector modulation.
% and adds dead time compensation (level 1 using only phase current info)
%
% function [PWM,sector]=svpwm2(Vab,Tpwm,Iabc,Tdt,Method)
%
% INPUTS:
% Vab is the Voltage command in alpha-beta frame normalized to -1,1
% Tpwm is an integer which will represent the duration of the whole pwm
% cycle, the on-times then will be integers less than or equal to this
% number.
% Iabc is the inverter phase current, (only sign really matters).
% Tdt is the dead time that will be inserted by the DSP hardware measured
% in same units as Tpwm, only integers are supported.  To disable deadtime
% compensation enter zero for this arguement.
% Method choses which type of modulation is used:
% 1: regular symmetric pwm
% 2: bus clamped 60 degree odd, ie 111 state is used in odd sectors
% 3: bus clamped 60 degree even, ie 111 state is used in even sectors
%
% OUTPUTS: 
% PWM is a vector containing the on-times for each channel [a b c]'
% sector indicates which sector the Vab falls within
% -----------------------------------------------------------------------

function [PWM,sector]=svpwm2(Vab,Tpwm,Iabc,Tdt,Method)

alpha=Vab(1);
beta=Vab(2);
bsqrt3=beta/sqrt(3);
sector=0;

% Figure out the sector based on Vab
if beta>=0,
   % sectors 123,
   if abs(alpha)<abs(bsqrt3),
      sector=2;
   else
      if alpha>=0,
         sector=1;
      else
         sector=3;
      end
   end
else
   % sectors 456,
   if abs(alpha)<abs(bsqrt3)
      sector=5;
   else
      if alpha>=0,
         sector=6;
      else
         sector=4;
      end;
   end
end

if sector==0,
   fprintf('error: no sector determined\n');
   return;
end

% Compute the 2 active vector times Tx and Ty
if ((sector==2)|(sector==5)),
   % group 1
   Tx=alpha+abs(bsqrt3);
   Ty=-alpha+abs(bsqrt3);
else
   % group 2
   Tx=abs(alpha)-abs(bsqrt3);
   Ty=2*abs(bsqrt3);
end

% Bus compensation should go here.

% Calculate the off-time T0 and rescale Tx and Ty if required.
% This implements the hexagon limit not circular limit.
T0=1-Tx-Ty;
if T0<0,
   T0=0;
   k=1/(Tx+Ty);
   Tx=k*Tx;
   Ty=k*Ty;
end;

% Compute the duty cycles from Tx, Ty, and T0
if Method==1,   
    % Regular SVM
    if sector==1, 
       PWM(1) = Tpwm*(Tx+Ty+T0/2);
       PWM(2) = Tpwm*(Ty+T0/2);
       PWM(3) = Tpwm*(T0/2);
    end
    if sector==2, 
       PWM(1) = Tpwm*(Tx+T0/2);
       PWM(2) = Tpwm*(Tx+Ty+T0/2);
       PWM(3) = Tpwm*(T0/2);
    end
    if sector==3, 
       PWM(1) = Tpwm*(T0/2);
       PWM(2) = Tpwm*(Tx+Ty+T0/2);
       PWM(3) = Tpwm*(Tx+T0/2);
    end
    if sector==4, 
       PWM(1) = Tpwm*(T0/2);
       PWM(2) = Tpwm*(Tx+T0/2);
       PWM(3) = Tpwm*(Tx+Ty+T0/2);
    end
    if sector==5, 
       PWM(1) = Tpwm*(Tx+T0/2);
       PWM(2) = Tpwm*(T0/2);
       PWM(3) = Tpwm*(Tx+Ty+T0/2);
    end
    if sector==6, 
       PWM(1) = Tpwm*(Tx+Ty+T0/2);
       PWM(2) = Tpwm*(T0/2);
       PWM(3) = Tpwm*(Ty+T0/2);
    end
end;

if Method==2,
    % Bus Clamped SVM (60 degree odd)
    if sector==1, 
       PWM(1) = Tpwm*(1);
       PWM(2) = Tpwm*(T0+Ty);
       PWM(3) = Tpwm*(T0);
    end
    if sector==2, 
       PWM(1) = Tpwm*(Tx);
       PWM(2) = Tpwm*(Tx+Ty);
       PWM(3) = Tpwm*(0);
    end
    if sector==3, 
       PWM(1) = Tpwm*(T0);
       PWM(2) = Tpwm*(1);
       PWM(3) = Tpwm*(Tx+T0);
    end
    if sector==4, 
       PWM(1) = Tpwm*(0);
       PWM(2) = Tpwm*(Tx);
       PWM(3) = Tpwm*(Tx+Ty);
    end
    if sector==5, 
       PWM(1) = Tpwm*(Tx+T0);
       PWM(2) = Tpwm*(T0);
       PWM(3) = Tpwm*(1);
    end
    if sector==6, 
       PWM(1) = Tpwm*(Tx+Ty);
       PWM(2) = Tpwm*(0);
       PWM(3) = Tpwm*(Ty);
    end
end

if Method==3,
    % Bus Clamped SVM (60 degree even)
    if sector==1, 
       PWM(1) = Tpwm*(Tx+Ty);
       PWM(2) = Tpwm*(Ty);
       PWM(3) = Tpwm*(0);
    end
    if sector==2, 
       PWM(1) = Tpwm*(Tx+T0);
       PWM(2) = Tpwm*(1);
       PWM(3) = Tpwm*(T0);
    end
    if sector==3, 
       PWM(1) = Tpwm*(0);
       PWM(2) = Tpwm*(Tx+Ty);
       PWM(3) = Tpwm*(Tx);
    end
    if sector==4, 
       PWM(1) = Tpwm*(T0);
       PWM(2) = Tpwm*(T0+Tx);
       PWM(3) = Tpwm*(1);
    end
    if sector==5, 
       PWM(1) = Tpwm*(Tx);
       PWM(2) = Tpwm*(0);
       PWM(3) = Tpwm*(Tx+Ty);
    end
    if sector==6, 
       PWM(1) = Tpwm*(1);
       PWM(2) = Tpwm*(T0);
       PWM(3) = Tpwm*(T0+Ty);
    end
end

% DeadTime Compensation.
if Tdt~=0,
   Dtcomp=Tdt*sign(Iabcx);	% calculate compensation.
   PWM=PWM+Dtcomp;
end

% Printing for debug:
if 0,
    fprintf('::Va:%6.4f, Vb:%6.4f, Tx:%6.4f, Ty:%6.4f, T0:%6.4f\n',alpha,beta,Tx,Ty,T0);
    %fprintf('::DtA:%6.4f, DtB:%6.4f, DtC:%6.4f\n',Dtcomp(1),Dtcomp(2),Dtcomp(3));
    fprintf('::ChA:%6.4f, ChB:%6.4f, ChC:%6.4f\n',PWM(1),PWM(2),PWM(3));
end;

