imagefiles = dir('*.JPG');      
nfiles = length(imagefiles);    % Number of files found

disp(nfiles);

images = {nfiles};

for ii=1:nfiles
   currentfilename = imagefiles(ii).name;
   currentimage = imread(currentfilename);
   images{ii} = currentimage;
end


count = 1;
for i=1:nfiles
%     [~, threshold] = edge(images{i}, 'sobel');
%     fudgeFactor = .5;
%     edge_filter = edge(images{i},'sobel', threshold * fudgeFactor);
%     contour_filter = imcontour(edge_filter);
    contour_filter = rgb2gray(images{i});
    if (mod(count, 2))
        letter = 'A';
    else
        letter = 'B';
    end
    count_half = round(count/2);
    count = count + 1;
    
    imwrite(contour_filter, sprintf('binary_edge_%.02d_%c.jpg', count_half, letter));
end


