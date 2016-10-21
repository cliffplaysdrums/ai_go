% function capturedIndices = 
%     capturedPieces(board_state, player, opponent)
%
% player and opponent are colors 'b' or 'w'

function capturedIndices = captured_pieces(board_state, player, opponent)

scratch_h = board_state;
scratch_h(:) = '0';
capturedIndices = [];
    for row = 1:size(board_state, 1)
        for column = 1:size(board_state, 2)
            if strcmpi(board_state(row, column), opponent) ...
                && ~strcmpi(scratch_h(row, column), 'S')
                
                if eval_piece(board_state, [row column], player, opponent, ...
                    scratch_h) == true
                    
                    capturedIndices = [capturedIndices; row column];
                else
                    scratch_h(row, column) = 'S';
                end
            end
        end
    end
disp('Captured points: ');
disp(capturedIndices);
end