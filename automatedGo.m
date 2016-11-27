function winner = automatedGo(org1, org2)
% winner = automatedGo(org1, org2)
%
% org1 and org2 are Organism objects
% 
% The purpose of this function is to automate a game of Go between 2 AIs
% and return an integer indicating the winner (0=draw, 1=org1, 2=org2)
    
    theta1 = org1.Theta1;
    theta2 = org1.Theta2;
    randomFlag = false;

    size = 9;
    board_state(1:size,1:size) = 'n';
    blackGameboard = zeros(1, size*size);
    whiteGameboard = zeros(1, size*size);
    prev_board_state = board_state;
    num_passes = 0;
    color = 'b';
    last_b_move = [];
    last_w_move = [];
    b_taken_count = 0;
    w_taken_count = 0;
    winner = 0;
    misplacedCount = 0;
    passThreshold = 0.12;
    
    while num_passes < 2
                
      % Get move from AI player
      if ~randomFlag
        if strcmpi(color, 'b')
            theta1 = org1.Theta1;
            theta2 = org1.Theta2;
            moveIndex = bestMove(blackGameboard, theta1, theta2);
        elseif strcmpi(color, 'w')
            theta1 = org2.Theta1;
            theta2 = org2.Theta2;
            moveIndex = bestMove(whiteGameboard, theta1, theta2);
        end
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
                
        emptySpaces = sum(blackGameboard == 0);
        if ((emptySpaces / (size*size)) < passThreshold) || (misplacedCount > 14)
            move = 'pass';
        else
            move = 'Keep going';
        end
        
        placed = true;
        if strcmpi('pass',move)
            num_passes = num_passes + 1;
            %disp('Passed.');
        else
            prev_board_state = board_state;
            
            if strcmpi('b',color)
                if ~isequal(moves,last_b_move)
                    [board_state,placed] = ...
                        place_piece(board_state,moves,color); 
                    num_passes = 0;
                    last_b_move = moves;
                else
                    placed = false;
                end
            else
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
            randomFlag = false;
            misplacedCount = 0;
            %disp(board_state);
            if strcmpi('b',color)
                blackGameboard(moveIndex) = 1;
                whiteGameboard(moveIndex) = -1;
                color = 'w';
            else
                blackGameboard(moveIndex) = -1;
                whiteGameboard(moveIndex) = 1;
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
            %disp(b_taken_count);
            %disp(w_taken_count);
        else
            %disp('Problem placing piece. Try again.');
            misplacedCount = misplacedCount + 1;
            rng('shuffle');
            randomFlag = true;
        end
    end
    %disp(board_state);
    %disp('Game has ended.');
    winner = automatedScore(board_state,size);

end

