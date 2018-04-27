delete corner*.m
imagebwfiles = dir('blackwhite*.jpg');
nbwfiles = length(imagebwfiles);

for i=1:nbwfiles
    currentfilename = imagebwfiles(i).name;
    currentimage = imread(currentfilename);
    bwimages{i} = currentimage; 
end

for i=1:nbwfiles
    %contour line
    c = corner(bwimages{i},4);
    filename = sprintf('corner%.02d.m', i);
    save(filename, 'c', '-ascii')
end

%figure, scatter(c(:,1),c(:,2))