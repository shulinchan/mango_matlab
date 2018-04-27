%compares 2 feature vectors with euclidean distance formula
function diff = compareFeatures(f1,f2)
    diff = 0;
    [r,~] = size(f1);
    
    %weights for importance of vector elements
    %Default: [1 1 1 1 1 1 1 1 1 1 1 1]
    %1st Iteration: [2 2 2 2 0.25 0.25 0.25 0.25 0.25 0.25 0.25 0.25]
    weights = [1000 1 0.05 0.05 100 1 0.05 0.05 100 1 0.05 0.05];
    
    %get the ith row of each set of feature vectors
    %compare them using sqrt(sum((v1-v2).^2))
    %add the difference to the total difference
    for i =1:r
        %get corresponding feature vectors
        v1 = f1(i,:);
        v2 = f2(i,:);
        
        %include weights to sqDiff
        sqDiff = (v1 - v2) .^ 2;
        weightedSqDiff = sqDiff .* weights;
        
        %keep track of cumulative difference
        diff = diff + sqrt(sum(weightedSqDiff));
    end
end