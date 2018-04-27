addpath('./images');
imagefiles = dir('./images/*.jpg');
nfiles = length(imagefiles);

for i=1:nfiles
    fileName = imagefiles(i).name;
    fLen = length(fileName);
    if fileName(fLen-6) == 'A'
        cbirMangoClassifier(fileName);
    end
end

%a = imread('Mango_08_ADM.JPG');
%bs = imread('Mango_08_BDM.JPG');
%figure; imshow(a);
%b = rgb2hsv(a);
%figure; imshow(b);
%c = getRelevantPixels(a) * 255;
%figure; imshow(a);
%figure; imshow(bs);