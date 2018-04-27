% http://article.sciencepublishinggroup.com/pdf/10.11648.j.ajai.20170101.12.pdf

imagefiles = dir('*.JPG');      
nfiles = length(imagefiles);

disp(nfiles);

images = {nfiles};

% load binary_areas.dat
% areas = binary_areas;
% load binary_perimeters.dat
% perimeters = binary_perimeters;
% 
% defect_areas = 1:nfiles;
% defect_perimeters = 1:nfiles;
% 
% defect_areas_ratios = 1:nfiles;
% defect_perimeters_ratios = 1:nfiles;

for ii=1:nfiles
   currentfilename = imagefiles(ii).name;
   currentimage = imread(currentfilename);
   images{ii} = currentimage;
end


count = 1;
for i=2:2

    binary_image = images{i};
    
    I_binarize = imbinarize(binary_image);
    I_imfill = imfill(I_binarize, 'holes');

    h = ones(2, 2) / 2;
    I_filter = imfilter(I_imfill, h);
%     I_filter = I_imfill;
    
    if (mod(count, 2))
        letter = 'A';
    else
        letter = 'B';
    end
    count_half = round(count/2);
    count = count + 1;
    
    small_defect = defect_count(letter, count_half, 'Small', I_filter, 0, 200);
    medium_defect = defect_count(letter, count_half, 'Medium', I_filter, 201, 500);
    large_defect = defect_count(letter, count_half, 'Large', I_filter, 501, 2000);
    
    imwrite(I_filter, sprintf('image_defect_perimeters_count_%.02d_%c.jpg', count_half, letter));
%     imwrite(binary_perimeter, sprintf('image_defect_perimeter_%.02d_%c.jpg', count_half, letter));
end

function number = defect_count(letter, count_half, defect, image, lowerbound, upperbound)
    % Gets all the items within a certain gym.
%     certain_defects = xor(bwareaopen(image, lowerbound),  bwareaopen(image, upperbound));
    certain_defects = bwareafilt(image,[lowerbound upperbound]);
    certain_defect_perimeters = bwperim(certain_defects, 4);
    
    area_pixels = sum(certain_defects(:));
    perimeter_pixels = sum(certain_defect_perimeters(:));
%     ratio = area_pixels / perimeter_pixels;

    
%     small_ratios = xor(bwareaopen(certain_defect_perimeters, 0), bwareaopen(certain_defect_perimeters, 1));
    

%     figure;
%     imshowpair(certain_defects, certain_defect_perimeters, 'montage');

    % Counts the items and displays it.
    cc = bwconncomp(certain_defects);
    number  = cc.NumObjects;
    
    fprintf('%s(s): %d, Area Pixels: %d, Perimeter Pixels: %d\n', defect, number, area_pixels, perimeter_pixels);

    average_perimeter = perimeter_pixels / number;
    
%     small_ratios = xor(bwareaopen(certain_defect_perimeters, 0), bwareaopen(certain_defect_perimeters, round(average_perimeter)));
%     large_ratios = xor(bwareaopen(certain_defect_perimeters, round(average_perimeter)), bwareaopen(certain_defect_perimeters, perimeter_pixels));

    small_ratios = bwareafilt(certain_defect_perimeters,[0 round(average_perimeter)]);
    large_ratios = bwareafilt(certain_defect_perimeters,[round(average_perimeter) round(average_perimeter * 2)]);

%     figure;
%     imshowpair(small_ratios, large_ratios, 'montage');

    imwrite(small_ratios, sprintf('image_defect_perimeters_%.02d_%c_%s_small.jpg', count_half, letter, defect));
    imwrite(large_ratios, sprintf('image_defect_perimeters_%.02d_%c_%s_large.jpg', count_half, letter, defect));

    
end

% save binary_defect_areas_2.dat defect_areas -ascii
% save binary_defect_perimeters_2.dat defect_perimeters -ascii
% save binary_defect_areas_ratios_2.dat defect_areas_ratios -ascii



