function [group, edge_group, q] ...
    = checkgroupedge(original_point, board_state, point, ...
    group, edge_group, q)
    if strcmpi(original_point, board_state(point(1),point(2)))
        group = [group, [point(1),point(2)]];
        q = [q, [point(1),point(2)]];
    else
        edge_group = [edge_group, [point(1),point(2)]];
    end
end