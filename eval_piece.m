function captured = eval_piece(board_state, point, player, opponent, scratch)
% only evaluates opponent's pieces to see if they've been captured
% just reverse opponent and player parameters to check the reverse
% returns true if piece is captured
    captured = true;
    row = point(1);
    column = point(2);
    WORKING = 'z';
    
%TODO: skip 'safe'

if ~strcmpi(scratch(row, column), WORKING)   
    % check above
    if row > 1
        if ~strcmpi(board_state(row - 1, column), 'n')
            if strcmpi(board_state(row - 1, column), opponent);
                scratch(row, column) = WORKING;
                captured = eval_piece(board_state, [row - 1 column], player, ...
                    opponent, scratch);
                scratch(row, column) = '0';
            end
        else
            captured = false;
        end
    end
    
    % check below
    if captured && (row < rows(board_state))
        if ~strcmpi(board_state(row + 1, column), 'n')
            if strcmpi(board_state(row + 1, column), opponent)
                scratch(row, column) = WORKING;
                captured = eval_piece(board_state, [row + 1 column], player, ...
                    opponent, scratch);
                scratch(row, column) = '0';
            end
        else
            captured = false;
        end
    end
    
    % check left
    if captured && (column > 1)
        if ~strcmpi(board_state(row, column - 1), 'n')
            if strcmpi(board_state(row, column - 1), opponent)
                scratch(row, column) = WORKING;
                captured = eval_piece(board_state, [row column - 1], player, ...
                    opponent, scratch);
                scratch(row, column) = '0';
            end
        else
            captured = false;
        end
    end
    
    % check right
    if captured && (column < columns(board_state))
        if ~strcmpi(board_state(row, column + 1), 'n')
            if strcmpi(board_state(row, column + 1), opponent)
                scratch(row, column) = WORKING;
                captured = eval_piece(board_state, [row column + 1], player, ...
                    opponent, scratch);
                scratch(row, column) = 0;
            end
        else
            captured = false;
        end
    end
end

end