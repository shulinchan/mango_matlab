% http://article.sciencepublishinggroup.com/pdf/10.11648.j.ajai.20170101.12.pdf

imagefiles = dir('*.JPG');      
nfiles = length(imagefiles);

disp(nfiles);

images = {nfiles};

load binary_areas.dat
areas = binary_areas;
load binary_perimeters.dat
perimeters = binary_perimeters;

defect_areas = 1:nfiles;
defect_perimeters = 1:nfiles;

defect_areas_ratios = 1:nfiles;
% defect_perimeters_ratios = 1:nfiles;

for ii=1:nfiles
   currentfilename = imagefiles(ii).name;
   currentimage = imread(currentfilename);
   images{ii} = currentimage;
end


count = 1;
for i=1:nfiles
    white_pixels = 0;
%     binary_image = images{i} > (0.50 * 255);
    binary_image = images{i};
    [r, c] = size(binary_image);
    for x=1:r
        for y=1:c
            if binary_image(x, y) > 80
                binary_image(x, y) = 255;
                white_pixels = white_pixels + 1;
            end
        end
    end
    binary_perimeter = edge(binary_image,'sobel');
    
%     binary_image2 = bwareafilt(binary_image, 1);
%     binary_perimeter = bwperim(binary_image, 4);
    
    binary_pixels = sum(binary_image(:));
    perimeter_pixels = sum(binary_perimeter(:));

    defect_areas(i) = areas(i) - white_pixels;
    defect_perimeters(i) = perimeter_pixels - perimeters(i);
    
    defect_areas_ratios(i) = defect_areas(i) / areas(i);
% 
%     disp(defect_areas(i));
%     disp(areas(i));
%     
%     disp(defect_perimeters(i));
%     disp(perimeters(i));

    if (mod(count, 2))
        letter = 'A';
    else
        letter = 'B';
    end
    count_half = round(count/2);
    count = count + 1;
    
    imwrite(binary_image, sprintf('image_defect_%.02d_%c.jpg', count_half, letter));
    imwrite(binary_perimeter, sprintf('image_defect_perimeter_%.02d_%c.jpg', count_half, letter));
end

save binary_defect_areas_2.dat defect_areas -ascii
save binary_defect_perimeters_2.dat defect_perimeters -ascii
save binary_defect_areas_ratios_2.dat defect_areas_ratios -ascii



