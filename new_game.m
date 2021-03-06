% function board_state = new_game(size)
%
% returns a (size x size) board
%
%TODO: since this is now automated, we can probably remove the return value
%global move1;
function board_state = new_game

    prompt = {'Please enter the size for the GO game:'};
    while 1
        dlg_title = 'Input';
        num_lines = 1;
        size_var = inputdlg(prompt,dlg_title,num_lines);
        size=str2num(size_var{1});

        if (isempty(size_var{1})==1)
             prompt={'Size cannot be left empty, please enter the size:'}; 

        %Valid numeric value needs to be entered

        elseif ~isempty(size)
             break
        else
             prompt = {'Please enter numeric GO size:'};
        end
    end

    size=size+1;    %ruby code
    board_state(1:size,1:size) = 'n';
    prev_board_state = board_state;
    num_passes = 0;
    color = 'b';
    last_b_move = [];
    last_w_move = [];
    b_taken_count = 0;
    w_taken_count = 0;
    %[xcoord,ycoord,move]= GoDisplay(size,board_state,0); %ruby code
    %disp(move);
    
    while num_passes < 2
        %query_string = sprintf('Enter move for %s (as #,#): ', color);
        %move = input(query_string, 's');
        
        placed = true;
        [xcoord,ycoord,move]= GoDisplay(size,board_state,1);
        if strcmpi('pass',move)
            num_passes = num_passes + 1;
            disp('Passed.');
            continue;
        else
            prev_board_state = board_state;
            
            moves = [xcoord, ycoord];
            
%             moves = strsplit(move, ',');
%             moves = [...
%                 str2num(cell2mat(moves(1))),...
%                 str2num(cell2mat(moves(2)))];
            
            if strcmpi('b',color)
                if ~isequal(moves,last_b_move)
                    [board_state,placed] = ...
                        place_piece(board_state,moves,color); 
                    num_passes = 0;
                    last_b_move = moves;
                else
                    placed = false;
                end
            else
                if ~isequal(moves,last_w_move)
                    [board_state,placed] = ...
                        place_piece(board_state,moves,color); 
                    num_passes = 0;
                    last_w_move = moves;
                else
                    placed = false;
                end
            end
        end
        
        if placed
            disp(board_state);
            close(gcf);     %ruby code
           %[xcoord,ycoord,move]= GoDisplay(size,board_state,1); %ruby code
            if strcmpi('b',color)
                color = 'w';
            else
                color = 'b';
            end
            
            %TODO: this can be made faster using find() and sum() without a loop
            for idx = 1:numel(board_state)
                if board_state(idx) ~= prev_board_state(idx)
                    if strcmpi(board_state(idx),'n')
                        if strcmpi(prev_board_state(idx),'b')
                            b_taken_count = b_taken_count + 1;
                        else
                            w_taken_count = w_taken_count + 1;
                        end
                    end
                end
            end
            disp(b_taken_count);
            disp(w_taken_count);
        else
            disp('Problem placing piece.  Try again.');
            %close(gcf); %ruby code
            %[xcoord,ycoord,move]= GoDisplay(size,board_state,1); %ruby code
        end
    end
    disp('Game has ended.');
    close(gcf); %ruby code
   % [xcoord,ycoord,move]= GoDisplay(size,board_state,2); %ruby code
    Go_score(board_state,size);
end