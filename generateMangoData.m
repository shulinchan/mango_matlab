% Get list of all jpg files in the images directory
addpath('./images');
imagefiles = dir('./images/*.jpg');
nfiles = length(imagefiles);

%create cell array to store all the data
allData = cell(nfiles,4);

%populate cell array with data in the following format:
%imgName,imgFeatureVectors,defects,maturity
for i=1:nfiles
    fileName = imagefiles(i).name;
    allData{i,1} = fileName;
    allData{i,2} = getFeatures(100,imread(fileName));
    
    %depending on filename labelling
    %set whether defected/noDefect and mature/immature
    fLen = length(fileName);
    
    %'N' is No Defect
    %'D' is Defect
    if fileName(fLen-5) == 'N'
        allData{i,3} = 'N';
    elseif fileName(fLen-5) == 'D'
        allData{i,3} = 'D';
    end
    
    %'M' is Mature
    %'I' is Immature
    if fileName(fLen-4) == 'M'
        allData{i,4} = 'M';
    elseif fileName(fLen-4) == 'I'
        allData{i,4} = 'I';
    end
end

%save mangoColorFV.dat allData -ascii DOESNT WORK
save mangoColorFV.mat allData