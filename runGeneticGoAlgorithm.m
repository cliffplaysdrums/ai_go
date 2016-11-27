function [theta1, theta2] = runGeneticGoAlgorithm(popSize, maxGenerations)
% For each generation, each organism will play 20 matches against each
% other organism meaning that there will be 20*((popSize^2)/2) matches per
% generation.

    numFeatures = 81; % boardsize
    numClasses = 2; % move is good or bad
    matchesToPlay = 20; % per 
    
    % now initialize each element
    % NOTE: the Organism class contains fields that are randomly set, so
    % each object should be instantiated separately. Do not try to copy an
    % Organism into the whole array
    for i = 1:(popSize) 
        population(i) = Organism(numFeatures, numClasses);
    end
    
for iter = 1:maxGenerations    
    disp(sprintf('Running generation %d', iter));
    for i = 1:popSize % for each organism
        for j = (i+1):popSize % play each organism after the current one
            for k = 1:matchesToPlay
                % switch who goes first after half the matches
                if k <= (matchesToPlay / 2)
                    winner = automatedGo(population(i), population(j));
                    if winner == 1 % i wins
                        population(i).wins = population(i).wins + 1;
                        population(j).losses = population(j).losses + 1;
                    elseif winner == 2 % j wins
                        population(j).wins = population(j).wins + 1;
                        population(i).losses = population(i).losses + 1;
                    end
                else % switch who goes first
                    winner = automatedGo(population(j), population(i));
                    if winner == 1 % j wins
                        population(j).wins = population(j).wins + 1;
                        population(i).losses = population(i).losses + 1;
                    elseif winner == 2 % i wins
                        population(i).wins = population(i).wins + 1;
                        population(j).losses = population(j).losses + 1;
                    end
                end
                
                if winner == 0; % draw
                    population(i).draws = population(i).draws + 1;
                    population(j).draws = population(j).draws + 1;
                end
                
            end
        end
    end
   
    population = evolve(population);
end

bestIdx = 1;
for i = 2:popSize
    if population(i).score > population(bestIdx).score
        bestIdx = i;
    end
end

theta1 = population(bestIdx).Theta1;
theta2 = population(bestIdx).Theta2;
end