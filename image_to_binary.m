imagefiles = dir('*.JPG');      
nfiles = length(imagefiles);    % Number of files found

images = {nfiles};
areas = 1:nfiles;
perimeters = 1:nfiles;

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
    binary_image = images{i} > (0.10 * 255);
    binary_image2 = bwareafilt(binary_image, 1);
    binary_perimeter = bwperim(binary_image2, 4);
    
    numberOfPixels = numel(binary_image2);
    binary_pixels = sum(binary_image2(:));
    perimeter_pixels = sum(binary_perimeter(:));
    
    areas(i) = binary_pixels;
    perimeters(i) = perimeter_pixels;
    disp(areas(i));
    disp(perimeters(i));

    if (mod(count, 2))
        letter = 'A';
    else
        letter = 'B';
    end
    count_half = round(count/2);
    count = count + 1;
    
    imwrite(binary_image2, sprintf('binary_image_%.02d_%c.jpg', count_half, letter));
%     imwrite(binary_perimeter, sprintf('binary_image_%.02d_%c.jpg', count_half, letter));
end

save binary_areas.dat areas -ascii
save binary_perimeters.dat perimeters -ascii


