function board_state = check_capture(board_state, point, color)
    board_size = length(board_state);
    
    %if point is not outside the borders, check for if it's taken
    if~( (point(1) < 1) || (point(1) > board_size) ...
        || (point(2) < 1) || (point(2) > board_size) )

        left = [point(1), point(2)-1];
        left = checkEdges(left, board_size, board_state, ...
            board_state(point(1),point(2)));
        right = [point(1), point(2)+1];
        right = checkEdges(right, board_size, board_state, ...
            board_state(point(1),point(2)));
        top = [point(1)-1, point(2)];
        top = checkEdges(top, board_size, board_state, ...
            board_state(point(1),point(2)));
        bottom = [point(1)+1, point(2)];
        bottom = checkEdges(bottom, board_size, board_state, ...
            board_state(point(1),point(2)));
        
        if (strcmpi(left,right) && strcmpi(top,bottom) && strcmpi(left,top))
            if(~strcmpi(left,board_state(point(1),point(2))))
                board_state(point(1),point(2)) = 'n';
            end
        end
    end
end