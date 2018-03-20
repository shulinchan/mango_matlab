imagefiles = dir('*.JPG');      
nfiles = length(imagefiles);

for ii=1:nfiles
   currentfilename = imagefiles(ii).name;
   currentimage = imread(currentfilename);
   images{ii} = currentimage;
end

%grayscale
for ii=1:nfiles
   grayscale = rgb2gray(images{i});
   imwrite(grayscale, sprintf('gray%.02d.jpg', i));
end

%blackwhite
for i=1:nfiles
    blackwhite = im2bw(images{i}, 0.5);
    imwrite(blackwhite, sprintf('blackwhite%.02d.jpg', i));
end