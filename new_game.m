% function board_state = new_game(size)
%
% returns a (size x size) board
%
%TODO: since this is now automated, we can probably remove the return value

function board_state = new_game(size)
    board_state(1:size,1:size) = 'n';
    prev_board_state = board_state;
    num_passes = 0;
    color = 'b';
    last_b_move = [];
    last_w_move = [];
    b_taken_count = 0;
    w_taken_count = 0;
    
    % will be used for move history to feed to the NN
    EMPTY = 1;
    BLACK = 2;
    WHITE = 3;
    boardStateUnrolled = ones(1, size*size);
    
    % matrix to feed through NN
    % indices:
    %   1: The move made. Represented as an integer from 1 to size*size or
    %       0 to represent a pass. Odd rows will be black's moves. Even
    %       rows will be white's moves.
    %   2: Interpreted cost of move (not finalized until game ends)
    %   3 to the end: the board state "unrolled" prior to the move
    %       that was made
    moveHistory = ones(1, size*size + 3);
    moveNumber = 1;
    
    while num_passes < 2
        query_string = sprintf('Enter move for %s (as #,#): ', color);
        move = input(query_string, 's');
        
        placed = true;
        
        if strcmpi('pass',move)
            num_passes = num_passes + 1;
            % set moveHistory data for NN
            moveHistory(moveNumber, 1) = 0; % move made (pass)
            moveHistory(moveNumber, 2) = 0; % cost (initially 0)
            moveHistory(moveNumber, 3:end) = boardStateUnrolled;
        else
            prev_board_state = board_state;
            
            moves = strsplit(move, ',');
            moves = [...
                str2num(cell2mat(moves(1))),...
                str2num(cell2mat(moves(2)))];
            
            if strcmpi('b',color)
                if ~isequal(moves,last_b_move)
                    [board_state, boardStateUnrolled, placed] = ...
                        place_piece(board_state,moves,color); 
                    num_passes = 0;
                    last_b_move = moves;
                else
                    placed = false;
                end
            else
                if ~isequal(moves,last_w_move)
                    [board_state, boardStateUnrolled, placed] = ...
                        place_piece(board_state,moves,color); 
                    num_passes = 0;
                    last_w_move = moves;
                else
                    placed = false;
                end
            end
        end
        
        if placed
            disp(board_state);
            if strcmpi('b',color)
                color = 'w';
            else
                color = 'b';
            end
            
            %TODO: this can be made faster using find() and sum() without a loop
            for idx = 1:numel(board_state)
                if board_state(idx) ~= prev_board_state(idx)
                    if strcmpi(board_state(idx),'n')
                        if strcmpi(prev_board_state(idx),'b')
                            b_taken_count = b_taken_count + 1;
                        else
                            w_taken_count = w_taken_count + 1;
                        end
                    end
                end
            end
            disp(b_taken_count);
            disp(w_taken_count);
        else
            disp('Problem placing piece.  Try again.');
        end
    end
    disp('Game has ended.');
end