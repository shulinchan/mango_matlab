function cbirMangoClassifier(fileName)
    % Get list of all jpg files in the images directory
    addpath('./images');
    addpath('./unclassified_images');

    %load saved feature vector data
    data = load('mangoColorFV.mat');
    datasetFV = data.allData;
    dLen = length(datasetFV)/2;

    %check if file exists
    if exist(fileName, 'file') == 2
        %Get features for corresponding A/B files
        fLen = length(fileName);
        fileName(fLen-6) = 'A';
        imgA = getFeatures(100,imread(fileName));
        fileName(fLen-6) = 'B';
        imgB = getFeatures(100,imread(fileName));

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
        points = 0;
        maturity = diffRank{1,4};
        for j=2:6
            if diffRank{j,4} == maturity
                points = points + (8 - j);
            end
        end
        disp(strcat(fileName,'||',maturity,'||',num2str(points),'/20'));
    else
        %let the user know the file wasn't found
        fprintf('Was unable to find specified file.');
    end
end