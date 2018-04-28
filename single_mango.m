function result = single_mango(input1,input2)
    %SINGLE_MANGO Summary of this function goes here
    %Detailed explanation goes here
    
    %load images
    addpath('./images');
    addpath('./unclassified_images');
    imgA = imread(input1);
    imgB = imread(input2);
    
    %run bilateral filter
    aBilat = getRelevantPixels(imgA);
    bBilat = getRelevantPixels(imgB);
    
    %cbir to classify maturity
    cbirClassification = cbirMangoClassifier(imgA,imgB,aBilat,bBilat);
    
    %stem to classify maturity
    countA = runDemo(aBilat);
    countB = runDemo(bBilat);
    
    %ripe is represented by 1, unripe is represented by 0
    %if side-A has 0 then stem isn't visible so only check side-B, if side-B has 3-4 then it is ripe
    %if side-B has 0 then stem isn't visible so only check side-A, if side-A has 3-4 then it is ripe
    %if both are non 0, make sure both are within range 3-4
    %else not ripe
    if (countA == 0 && countB < 5 && countB > 2)
        result = 1;
    elseif (countB == 0 && countA < 5 && countA > 2)
        result = 1;
    elseif (countA < 5 && countA > 2 && countB < 5 && countB > 2)
        result = 1;
    else
        result = 0;
    end
    
    disp(result);
    disp(cbirClassification);
end

