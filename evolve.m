function newPopulation = evolve(oldPopulation)

% ensure random sequences aren't repeated in different executions
rng('shuffle'); 
n = size(oldPopulation(1).Theta1, 1);
k = size(oldPopulation(1).Theta2, 1);
idx = 0;

mutationProb = 0.01;
popSize = length(oldPopulation);

totalScore = 0;
for i = 1:popSize
    totalScore = totalScore + oldPopulation(i).score;
end

% sort old population from greatest to least score
[~, sortedIndices] = sort([oldPopulation.score], 'descend');
oldPopulation = oldPopulation(sortedIndices);

% always retain the 2 best performing organisms intact
    newPopulation(1) = copyOrganism(oldPopulation(1));
    newPopulation(2) = copyOrganism(oldPopulation(2));

% There are many ways to evolve the population

%disp('Performing CrossOver');
% Version 1 - Crossover
for i = 2:((popSize) / 2)
    % find parent 1
    %disp('Start');
    randNum = rand();
    if randNum > (totalScore / (totalScore * (1 + mutationProb)))
        % mutate
        parent1 = Organism(n, k);
    else % perform normal crossover
        previousProb = 0;
        idx = 1;
        parent1 = oldPopulation(idx);
        while randNum > ( (parent1.score + previousProb) ...
                / (totalScore * (1 + mutationProb)) ) && (idx <= popSize)
            previousProb = previousProb + parent1.score;
            idx = idx + 1;
            parent1 = oldPopulation(idx);
        end
    end
    
    % find parent 2
    tempTotal = totalScore - parent1.score;
    parent1Idx = idx;
    randNum = rand();
    if randNum > (tempTotal / (tempTotal * (1 + mutationProb)))
        % mutate
        parent2 = Organism(n, k);
    else % perform normal crossover
        previousProb = 0;
        idx = 1;
        if parent1Idx == idx
            % skip
            idx = idx + 1;
        end
        parent2 = oldPopulation(idx);
        while randNum > ( (parent2.score + previousProb) ...
                / (tempTotal * (1 + mutationProb)) ) && (idx <= popSize)
            if idx ~= parent1Idx
                previousProb = previousProb + parent2.score;
            end
            idx = idx + 1;
            parent2 = oldPopulation(idx);
        end
    end
    
    % now perform cross over
    thetaSize = length(parent1.Theta1(:));
    randStart = ceil(rand() * thetaSize);
    randStop = ceil(rand() * thetaSize);
    if randStop < randStart
        temp = randStop;
        randStop = randStart;
        randStart = temp;
    end
    
    % create new organisms
    offSpring = copyOrganism(parent1);
    offSpring2 = copyOrganism(offSpring);
    
    % first child
    offSpring.Theta1(1:randStart) = parent2.Theta1(1:randStart);
    offSpring.Theta1(randStart+1:randStop) = parent1.Theta1(randStart+1:randStop);
    offSpring.Theta1(randStop+1:end) = parent2.Theta1(randStop+1:end);
    % second child
    offSpring2.Theta1(1:randStart) = parent1.Theta1(1:randStart);
    offSpring2.Theta1(randStart+1:randStop) = parent2.Theta1(randStart+1:randStop);
    offSpring2.Theta1(randStop+1:end) = parent1.Theta1(randStop+1:end);
    
    % repeat for Theta2
    thetaSize = length(parent1.Theta2(:));
    randStart = ceil(rand() * thetaSize);
    randStop = ceil(rand() * thetaSize);
    if randStop < randStart
        temp = randStop;
        randStop = randStart;
        randStart = temp;
    end
    
    % first child
    offSpring.Theta2(1:randStart) = parent2.Theta2(1:randStart);
    offSpring.Theta2(randStart+1:randStop) = parent1.Theta2(randStart+1:randStop);
    offSpring.Theta2(randStop+1:end) = parent2.Theta2(randStop+1:end);
    % second child
    offSpring2.Theta2(1:randStart) = parent1.Theta2(1:randStart);
    offSpring2.Theta2(randStart+1:randStop) = parent2.Theta2(randStart+1:randStop);
    offSpring2.Theta2(randStop+1:end) = parent1.Theta2(randStop+1:end);
    
    idx = i*2 - 1;
    newPopulation(idx) = copyOrganism(offSpring);
    idx = idx + 1;
    newPopulation(idx) = copyOrganism(offSpring2);
    %disp('Done');
end
%disp('CrossOver Complete');
end