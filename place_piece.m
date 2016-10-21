% function [board_state, boardStateUnrolled, placed] =
%     place_piece(board_state, boardStateUnrolled, point, color)
%
% point should be defined as an array: [row column]
% color should be 'b' or 'w'

function [board_state, boardStateUnrolled, placed] = ...
    place_piece(board_state, boardStateUnrolled, point, color)
    % point array 1 is y-value (row). 2 is x-value (column).
    
    % I've commented out the majority of the code here to test my (Cliff's) 
    % group capture. I'm not deleting it until we're sure we want to stick 
    % with mine
    %{
    % placed = false;
        
    if strcmpi(board_state(point(1),point(2)), 'n')
        placed = true;
        board_state(point(1),point(2)) = color;
        
        left = [point(1), point(2)-1];
        board_state = check_capture(board_state,left,color);
        right = [point(1), point(2)+1];
        board_state = check_capture(board_state,right,color);
        top = [point(1)-1, point(2)];
        board_state = check_capture(board_state,top,color);
        bottom = [point(1)+1, point(2)];
        board_state = check_capture(board_state,bottom,color);
    end
    %}
    
    % constants for boardStateUnrolled
    EMPTY = 1;
    BLACK = 2;
    WHITE = 3;
    
    placed = true;
    board_state(point(1),point(2)) = color; 
    
    if strcmpi(color, 'w')
        playerNumber = WHITE;
        opponentNumber = BLACK;
        opponent = 'b';
    else
        playerNumber = BLACK;
        opponentNumber = WHITE;
        opponent = 'w';
    end
    
    unrolledIndex = (point(1) - 1) * size(board_state, 2) + point(2);
    boardStateUnrolled(unrolledIndex) = playerNumber;
    
    % check to see if capturing
    capturedIndices = captured_pieces(board_state, color, opponent);
    
    if isempty(capturedIndices)
        % check for suicide
        scratch = board_state;
        scratch(:) = '0';
        if eval_piece(board_state, point, opponent, color, scratch)
            % suicide
            board_state(point(1), point(2)) = 'n';
            placed = false;
        end
    else % not suicide, proceed as normal
        for i = 1:size(capturedIndices, 1)
            captured = capturedIndices(i, :);
            board_state(captured(1), captured(2)) = 'n';
        end
    end    
end