function result = single_mango(input1,input2)
    %load images
    addpath('./images');
    imgA = imread(input1);
    imgB = imread(input2);
    
%SINGLE_MANGO Summary of this function goes here
%   Detailed explanation goes here
    countA = runDemo(imgA);
    countB = runDemo(imgB);
    if (countA == 0 && countB < 5 && countB > 2)
        result = 1;
    elseif (countB == 0 && countA < 5 && countA > 2)
        result = 1;
    elseif (countA < 5 && countA > 2 && countB < 5 && countB > 2)
        result = 1;
    else
        result = 0;
    end
end

