function [xcoord,ycoord,move1]=GoDisplay(size,board_state,first_move)
rows=size-1;
cols=size-1;
global move1;
% default values needed in case of pass
xcoord = 1;
ycoord = 1;

ssPos = get(0,'ScreenSize');
fs = [ssPos(3:4)/4 ssPos(3:4)/2]; %centre & quater of a screen
set(0, 'DefaultFigurePosition', fs);

display.figHandle = figure('Name','AIGo','NumberTitle','off'); 
%set(display.figHandle,'Position',ssPos+100*[0 .5 -1 -1]);
set(display.figHandle,'Color',[.9 .8 .5]);

ax = axes('color','none', ...
    'xlim',[0 cols]+[0 0],'ylim',[0 rows]+[0.05 0],...    
    'xtick',[],'ytick',[],...
    'NextPlot','add',...
    'Layer','bottom',...
    'DataAspectRatio',[1 1 1],...
    'XColor','k','YColor','k','Box','On','LineWidth',4);

alphamap([0:1:255]/255'); 
 
% Create Go tiles
for i = 1:cols
    for j=1:rows
        mod(i+j,2);
        color = [.87 .49 0]; %white
        h = patch(i-1+[0 1 1 0], j-1+[0 0 1 1], color);
    end
end

title_disp=sprintf('%d X %d',rows,cols);
if first_move==2
    title_disp='Game has ended!'
end    
labelFont='Comic'; labelFontSize=12;
title(title_disp,'FontName',labelFont,'FontSize',labelFontSize);

fontSize = .35;
% New game - button
h_new_game = uicontrol('Style', 'pushbutton', ...
    'String','New game',...
    'Unit','normalized',...
    'Position', [.018 .85 .14 .07],...
    'FontName','Comic',...
    'FontUnits','normalized',...
    'FontSize',fontSize,...
    'Callback','close(gcf); Go;'); 

% Pass - button
h_new_game = uicontrol('Style', 'pushbutton', ...
    'String','Pass',...
    'Unit','normalized',...
    'Position', [.018 .75 .14 .07],...
    'FontName','Comic',...
    'FontUnits','normalized',...
    'FontSize',fontSize,...
    'Callback',@pass); 
disp(move1);

h_new_game = uicontrol('Style', 'pushbutton', ...
    'String','Feedback',...
    'Tooltip','Send feedback to rubygogri@gmail.com',...
    'Unit','normalized',...
    'Position', [.018 .65 .14 .07],...
    'FontName','Comic',...
    'FontUnits','normalized',...
    'FontSize',fontSize,...
    'Callback','web mailto:rubygogri@gmail.com'); 

if first_move>0
    for i=1:rows+1
        for j=1:cols+1
        % board_state(i,j)
        % grid = 'on'
        % plot(0, 0, '.r', 'MarkerSize',69)
            if board_state(i,j)=='b'
     %    disp(sprintf('i:%d,j:%d,val-j:%d,val-i:%d',i,j,j-1,abs(size-i)));
               %plot black coin(s)
                plot(j-1,abs(size-i),'.black', 'MarkerSize',69);
                plot(40,60,'.black', 'MarkerSize',169)
                
            elseif board_state(i,j)=='w'
      %   disp(sprintf('i:%d,j:%d,val-j:%d,val-i:%d',i,j,j-1,abs(size-i)));
               %plot white coin(s)
                plot(j-1,abs(size-i),'.white', 'MarkerSize',69);
            end 
        end
    end
end

if first_move<2
    [x,y] = ginput(1)
    if round(x)>0 & round(y)>0 
        xcoord=abs(round(y)-rows)+1
        ycoord=round(x)+1
    end
    if round(x)==0
        xcoord=abs(round(y)-rows)+1
        ycoord=1 
    end
    if round(y)==0
        xcoord=6
        ycoord=round(x)+1
    end    
end

%if strcmpi('pass',move1)
%    [x,y] = ginput(1);
end