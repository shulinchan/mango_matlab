delete blackwhite*.jpg

imagefiles = dir('grayscale*.jpg');
nfiles = length(imagefiles);

% convert all images to black and white and then take contour
for i=1:nfiles
   currentfilename = imagefiles(i).name;
   currentimage = imread(currentfilename);
   images{i} = currentimage;
   
   %blackwhite
   blackwhite = im2bw(images{i}, 0.2);
   imwrite(blackwhite, sprintf('blackwhite%.02d.jpg', i));
end
