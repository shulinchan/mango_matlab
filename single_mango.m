function results = single_mango(input1,input2)
    %Takes 2 images of mangos as input
    %uses cbir, stem analysis, and defect detection
    %outputs vector of statistics/classification data
    
    %instantiate vector to return 'results': 
    %maturity (index 1) and defect (index 2) classification 
    %ratio of defects (index 3)
    %6 counts of different types of defects (indices 4-9)
    results = zeros(1,9);
    
    %load images
    addpath('./images');
    addpath('./unclassified_images');
    addpath('./DB_Mango');
    imgA = imread(input1);
    imgB = imread(input2);
    
    %run bilateral filter
    aBilat = getRelevantPixels(imgA);
    bBilat = getRelevantPixels(imgB);
    
    %defect detection
    %1 is defected and 0 is not defected
    defects = mango_defect_main(imgA,imgB);
    for i=1:8
        results(1,i+1) = defects(i);
    end
    
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
    result = 0;
    if (countA == 0 && countB < 5 && countB > 2)
        result = 1;
    elseif (countB == 0 && countA < 5 && countA > 2)
        result = 1;
    elseif (countA < 5 && countA > 2 && countB < 5 && countB > 2)
        result = 1;
    else
        result = 0;
    end
    
    %combine maturity results from 2 sources
    %if confident in color result, return color result
    %else return stem result
    if (cbirClassification(1,1) > 15) || (cbirClassification(1,1) > 15 && result == 2)
        results(1,1) = 1;
    elseif (cbirClassification(1,2) > 15) || (cbirClassification(1,2) > 15 && result == 2)
        results(1,1) = 0;
    else
        results(1,1) = result;
    end
    
    disp(results)
end

