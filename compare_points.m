function are_same = compare_points(board_state, point1, point2)
    if(strcmpi(board_state(point1(1),point1(2)), ...
            board_state(point2(1),point2(2))))
        are_same = true;
    else
        are_same = false;
    end
end