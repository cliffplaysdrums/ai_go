function [theta1, theta2] = randomThetas(theta1Dim, theta2Dim)
    thetaMin = -2.5;
    thetaMax = 2.5;
    
    rng('shuffle');
    
    theta1 = thetaMin + thetaMax * 2 * rand(theta1Dim(1), theta1Dim(2));
    theta2 = thetaMin + thetaMax * 2 * rand(theta2Dim(1), theta2Dim(2));
end