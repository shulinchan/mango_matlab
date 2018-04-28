addpath('./images');
imagefiles = dir('./images/*.jpg');
nfiles = length(imagefiles);

for i=1:nfiles
    fileName = imagefiles(i).name;
    fLen = length(fileName);
    if fileName(fLen-6) == 'A'
        fileName2 = fileName;
        fileName2(fLen-6) = 'B';
        result = cbirMangoClassifier(fileName,fileName2);
        
        %print results
        disp(fileName);
        disp(result);
    end
end