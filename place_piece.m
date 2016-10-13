function [board_state, placed] = place_piece(board_state, point, color)
    placed = false;
    
    % point array 1 is y-value.  2 is x-value.
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
end

function board_state = check_taken(board_state, group)
end