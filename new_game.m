% function board_state = new_game(size)
%
% returns a (size x size) board
function board_state = new_game(size)
    board_state(1:size,1:size) = 'n';
end