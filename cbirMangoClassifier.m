function mThenI = cbirMangoClassifier(file1,file2,file1Bilat,file2Bilat)
    %load saved feature vector data
    data = load('mangoColorFV.mat');
    datasetFV = data.allData;
    dLen = length(datasetFV)/2;
    
    %set up return variable
    %of format [mature-points immature-points]
    mThenI = zeros(1,2);
    
    %Get features for corresponding A-side/B-side files
    imgA = getFeatures(100,file1,file1Bilat);
    imgB = getFeatures(100,file2,file2Bilat);

    %do comparison between the data and loaded images
    diffRank = cell(dLen,4);
    for i=1:dLen
        %get A and B for each image in datasetFV
        dataA = datasetFV{(i*2)-1,2};
        dataB = datasetFV{i*2,2};

        %Difference for A vs A, B vs B
        d1 = compareFeatures(imgA,dataA) + compareFeatures(imgB,dataB);

        %Difference for A vs B, B vs A
        d2 = compareFeatures(imgA,dataB) + compareFeatures(imgB,dataA);

        %store the minimum distance
        diffRank{i,1} = min(d1,d2);

        %re-store the other variables
        diffRank{i,2} = datasetFV{(i*2)-1,1};
        diffRank{i,3} = datasetFV{i*2,3};
        diffRank{i,4} = datasetFV{i*2,4};
    end

    %output a ranked a list of classifications
    diffRank = sortrows(diffRank,'ascend');
    %disp(diffRank);

    %get classification result
    iPoints = 0;
    mPoints = 0;
    for j=2:6
        if diffRank{j,4} == 'M'
            mPoints = mPoints + (8 - j);
        else
            iPoints = iPoints + (8 - j);
        end
    end

    %set return mature-points and immature-points
    mThenI(1,1) = mPoints;
    mThenI(1,2) = iPoints;
end