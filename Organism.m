classdef Organism
    properties
        Theta1;
        Theta2;
        wins;
        losses;
        draws;
    end
    properties (Dependent)
        score
    end
    
    methods
        % constructor
        function obj = Organism(n, k)
            % n is number of features
            % k is number of classes
            [obj.Theta1, obj.Theta2] = randomThetas([n,n+1], [k,n+1]);
            obj.wins = 0;
            obj.losses = 0;
            obj.draws = 0;
        end
        
        % copy constructor
        function obj = copyOrganism(other)
            obj = Organism(size(other.Theta1, 1), size(other.Theta2, 1));
            obj.Theta1 = other.Theta1;
            obj.Theta2 = other.Theta2;
            obj.wins = 0;
            obj.losses = 0;
            obj.draws = 0;
        end
        
        % helper function to generate random theta matrix
        function [theta1, theta2] = randomThetas(theta1Dim, theta2Dim)
            thetaMin = -2.5;
            thetaMax = 2.5;
    
            rng('shuffle');
            theta1 = thetaMin + thetaMax * 2 * rand(theta1Dim(1), theta1Dim(2));
            theta2 = thetaMin + thetaMax * 2 * rand(theta2Dim(1), theta2Dim(2));
        end
        
        function score = get.score(obj)
            % returns score from 0-1
            score = (obj.wins + (obj.draws / 2)) ...
                / (obj.wins+obj.losses+obj.draws);
        end
        
    end
end