function new_game_vs_ai()
    
    size = 9; % current AI version was trained on a 9x9 board
    load('goThetas.mat', 'theta1', 'theta2');
    board_state(1:size,1:size) = 'n';
    aiGameboard = zeros(1, size*size);
    prev_board_state = board_state;
    num_passes = 0;
    color = 'b';
    last_b_move = [];
    last_w_move = [];
    b_taken_count = 0;
    w_taken_count = 0;
    misplacedCount = 0;
    maxPass = 0.12;
    randomFlag = false;
    
    while num_passes < 2
        
        % human move
        if strcmpi(color, 'b') 
            %query_string = sprintf('Enter move for %s (as #,#): ', color);
            %move = input(query_string, 's');
            [xcoord,ycoord,move]= GoDisplay(size,board_state,1);
            moves = [xcoord, ycoord];
        else % ai move
            if ~randomFlag
                moveIndex = bestMove(aiGameboard, theta1, theta2);
            else
                moveIndex = ceil(rand()*size*size);
            end
            % Convert move to 2D
            moveRow = ceil(moveIndex / size);
            moveCol = mod(moveIndex, size);
            if moveCol == 0
                moveCol = size;
            end
            moves = [moveRow, moveCol];
            
            emptySpaces = sum(aiGameboard == 0);
            if ((emptySpaces / (size*size)) < maxPass) || (misplacedCount > 14)
                move = 'pass';
            else
                move = 'Keep going';
            end
        end
        
        placed = true;
        if strcmpi('pass',move)
            num_passes = num_passes + 1;
            disp('Passed.');
            continue;
        else
            prev_board_state = board_state;

            if strcmpi('b',color) % human move
%                 moves = strsplit(move, ',');
%                 moves = [...
%                     str2num(cell2mat(moves(1))),...
%                     str2num(cell2mat(moves(2)))];
                if ~isequal(moves,last_b_move)
                    [board_state,placed] = ...
                        place_piece(board_state,moves,color); 
                    num_passes = 0;
                    last_b_move = moves;
                else
                    placed = false;
                end
            else % ai move
                if ~isequal(moves,last_w_move)
                    [board_state,placed] = ...
                        place_piece(board_state,moves,color); 
                    num_passes = 0;
                    last_w_move = moves;
                else
                    placed = false;
                end
            end
        end
        
        if placed
            close(gcf);
            randomFlag = false;
            misplacedCount = 0;
            disp(board_state);
            if strcmpi('b',color)
                moveIndex = (moves(1)-1)*size + moves(2);
                aiGameboard(moveIndex) = -1;
                color = 'w';
            else
                disp(sprintf('AI moves to %d,%d', moves(1), moves(2)));
                aiGameboard(moveIndex) = 1;
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
            misplacedCount = misplacedCount + 1;
            rng('shuffle');
            randomFlag = true;
        end
    end
    disp('Game has ended.');
    winner = automatedScore(board_state,size);
    if winner == 1
        disp('You win!');
    elseif winner == 2
        disp('The AI has won.');
    else
        disp('Draw!');
    end
end