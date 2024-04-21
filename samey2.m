% Set the y axis on each subplot to accomodate the maximum range over all figure windows.
%
%
function samey2(Nmatch)

autoy();

% Get handles for all figures, get Y limits for all subplots.
r0=get(0,'Children');
Nfig=max(size(r0));
fname=get(r0,'name');
for i0=1:Nfig,
   c0=num2str(i0);
   eval(['r' c0 '=get(r0(i0),''Children'');']);
%   eval(['yl' c0 '=get(r' c0 ',''YLim'');']);
end;

% Split the figures into groups
Ngroup=1;
GroupSize=zeros(Nfig,1);
GroupFigs=zeros(Nfig,Nfig);
groupId=cell(Nfig,1);
groupId{1}=fname{1}(1:Nmatch);
GroupFigs(1,1)=1;
GroupSize(1)=1;
for i0=2:Nfig,
    Id=fname{i0}(1:Nmatch);
    match=0;
    for i1=1:Ngroup,
        if(strcmp(Id,groupId{i1})==1),
            % found a match, increase group size, add figure to group.
            GroupSize(i1)=GroupSize(i1)+1;
            GroupFigs(i1,GroupSize(i1))=i0;
            match=1;
        end;
    end;
    if(match==0),
        % didn't find a match, add this as a new group.
        Ngroup=Ngroup+1;
        GroupSize(Ngroup)=1;
        GroupFigs(Ngroup,1)=i0;
        groupId{Ngroup}=Id;
    end;
end;    

% Check if number of plots = number of groups, ie each group has only one
% plot.  In this case there is nothing to make the same so just exit
if Nfig==Ngroup,
    return;
end;

% Loop over groups
for g1=1:Ngroup,
    figlist = GroupFigs(g1,find(GroupFigs(g1,:)));
    
    % Get limit into for each figure in the group
    for g2=1:max(size(figlist)),
        c0=num2str(g2);
        c1=num2str(figlist(g2));
        eval(['yl' c0 '=get(r' c1 ',''YLim'');']);
        eval(['Nplts=max(size(r' c1 '));']);
    end;
    
    % Extract limit info from cells, place in matrices.
    for i1=1:Nplts,   
       c1=num2str(i1);
       eval(['ym' c1 '=[];']);
       for i2=1:max(size(figlist)),
          c2=num2str(i2);
          eval(['ym' c1 '=[ym' c1 ';yl' c2 '{' c1 '}];']);
       end;
    end;

    % Find min and max for each subplot across all figures in group.
    for i1=1:Nplts,
       c1=num2str(i1);
       eval(['ylo' c1 '=min(ym' c1 ');']);
       eval(['yhi' c1 '=max(ym' c1 ');']);
       eval(['ylim' c1 '=[ylo' c1 '(1) yhi' c1 '(2)];']);
    end

    % Set axis limits for each subplot across all figures in group
    for i1=figlist,
       c1=num2str(i1);
       for i2=1:Nplts,
          c2=num2str(i2);
          eval(['set(r' c1 '(' c2 '),''YLim'',ylim' c2 ');']);
       end;
    end;
    
end;    



