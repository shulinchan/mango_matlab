% Get list of all BMP files in this directory
% DIR returns as a structure array.  You will need to use () and . to get
% the file names.
imagefiles = dir('*.jpg');      
nfiles = length(imagefiles);    % Number of files found

for ii=1:nfiles
   currentfilename = imagefiles(ii).name;
   fileNames{ii} = currentfilename;
   currentimage = imread(currentfilename);
   images{ii} = currentimage;
end

for i=1:nfiles
    grayscale = rgb2gray(images{i});
    imwrite(grayscale, sprintf('gray%.02d.jpg', i));
end

for j=1:nfiles
    blackwhite = im2bw(images{j}, 0.5);
    imwrite(blackwhite, sprintf('blackwhite%.02d.jpg', j));
end
