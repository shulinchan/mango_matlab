delete grayscale*.jpg
imagebwfiles = dir('Mango_*.JPG');
nfiles = length(imagefiles);

for i=1:nfiles
    currentfilename = imagefiles(i).name;
    currentimage = imread(currentfilename);
    images{i} = currentimage; 
    
    %grayscale
    grayscale = rgb2gray(images{i});
    imwrite(grayscale, sprintf('grayscale%.02d.jpg', i));
end