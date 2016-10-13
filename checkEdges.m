function color = checkEdges(point, board_size, board_state, color)
    if ((point(1) < 1) || (point(2) < 1) || ...
            (point(1) > board_size) || (point(2) > board_size))
        if strcmpi(color,'w')
            color = 'b';
        elseif strcmpi(color, 'b')
            color = 'w';
        end
    else
        color = board_state(point(1),point(2));
    end
end