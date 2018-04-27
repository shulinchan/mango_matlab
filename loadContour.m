delete contour*.m
imagebwfiles = dir('blackwhite*.jpg');
nbwfiles = length(imagebwfiles);

for i=1:nbwfiles
    currentfilename = imagebwfiles(i).name;
    currentimage = imread(currentfilename);
    bwimages{i} = currentimage; 
end

for i=1:nbwfiles
    %contour line
    contour = imcontour(bwimages{i});
    [X,Y,Z] = contour;
    filename = sprintf('contour%.02d.m', i);
    save(filename, 'contour', '-ascii')
end

%figure, scatter(contour(1,:),contour(2,:))