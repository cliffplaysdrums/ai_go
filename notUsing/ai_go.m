function ai_go()
% Automates the game. Prompts the user for board size.
% Moves should be entered as 2-element arrays

    size = input('Enter game board size: ');
    board_state = new_game(size);
    
    disp(board_state);
    disp(' ');
    
    color = 'b';
    exit = false;
    while ~exit
        point = input('Enter your move: ');
        clc;
        try
            ex = strcmpi(point, 'exit');
                if ex
                    exit = true;
                end
        catch err
        end
        
        if ~exit
            [board_state placed] = place_piece(board_state, point, color);
            disp(sprintf('Last move: [%d,%d]', point(1), point(2)));
            disp(board_state);
        
            % swap players
            if strcmpi(color, 'b')
                color = 'w';
            else
                color = 'b';
            end
        end
    end
    
end