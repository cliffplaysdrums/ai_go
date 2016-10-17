% function [board_state, placed] =
%     place_piece(board_state, point, color)
%
% point should be defined as an array: [row column]
% color should be 'b' or 'w'

function [board_state, placed] = place_piece(board_state, point, color)
    placed = false;
    
    % point array 1 is y-value (row). 2 is x-value (column).
    
    % I've commented out the majority of the code here to test my group capture.
    % The group capture appears to work (I've only run a handful of tests)
    
    %if strcmpi(board_state(point(1),point(2)), 'n')
        placed = true;
        board_state(point(1),point(2)) = color;
     %{   
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
    
    if strcmpi(color, 'w')
        opponent = 'b';
    else
        opponent = 'w';
    end
    
    % check for suicide
    if eval_piece(board_state, point, opponent, color, board_state .* 0)
        % suicide
        board_state(point(1), point(2)) = 'n';
        placed = false;
    end
    
    capturedIndices = captured_pieces(board_state, color, opponent);
    parfor i = 1:size(capturedIndices, 1)
        captured = capturedIndices(i, :);
        board_state(captured(1), captured(2)) = 'n';
    end
    
end

function board_state = check_taken(board_state, group)
end