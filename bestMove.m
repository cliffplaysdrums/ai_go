function move = bestMove(boardState, theta1, theta2)
        EMPTY = 0;
        bestProb = 1;
        move = 1;
        while move < size(boardState, 2) && boardState(move) ~= EMPTY
            move = move + 1;
        end
        for i = move:(size(boardState, 2))
            if boardState(i) == EMPTY
                X = [1 boardState];
                X(i + 1) = 1;
                z2 = X * theta1'; % (1 x n)
                a2 =  1.0 ./ (1.0 + exp(-z2)); % sigmoid
                a2 = [1 a2]; % (m x n+1)

                % output layer
                z3 = a2 * theta2'; % (m x k)
                a3 =  1.0 ./ (1.0 + exp(-z3)); % sigmoid
                %disp(a3);
                if a3 < bestProb
                    bestProb = a3;
                    move = i;
                end
            end
        end   
end

