function board_state = checkgroup(board_state, point, group, edge_group, q)
    if~(isempty(point))
        left = [point(1), point(2)-1];
        left = checkEdges(left, board_size, board_state, ...
            board_state(point(1),point(2)));
        [group, edge_group, q] = ...
            checkgroupedge(left, board_state, point, ...
            group, edge_group, q);
        right = [point(1), point(2)+1];
        right = checkEdges(right, board_size, board_state, ...
            board_state(point(1),point(2)));
        [group, edge_group, q] = ...
            checkgroupedge(right, board_state, point, ...
            group, edge_group, q);
        top = [point(1)-1, point(2)];
        top = checkEdges(top, board_size, board_state, ...
            board_state(point(1),point(2)));
        [group, edge_group, q] = ...
            checkgroupedge(top, board_state, point, ...
            group, edge_group, q);
        bottom = [point(1)+1, point(2)];
        bottom = checkEdges(bottom, board_size, board_state, ...
            board_state(point(1),point(2)));
        [group, edge_group, q] = ...
            checkgroupedge(bottom, board_state, point, ...
            group, edge_group, q);
    end
    if~(isempty(q))
        point = q(1);
        q = q(2:length(q));
        board_state = checkgroup(board_state, point, group, edge_group, q);
    else
        group = unique(group);
        edge_group = unique(edge_group);
        
        i = 1;
        all_opposing = true;
        while ((i < length(edge_group)) && all_opposing)
            if strcmpi(board_state(group(1,1),group(1,2)), ...
                    board_state(edge_group(i,1),edge_group(i,2)))
               all_opposing = false;
               break;
            end
        end
        if all_opposing == true
            i = 1;
            while i < length(group)
                board_state(group(i,1),group(i,2)) = 'n';
            end
        end
    end
end