imagefiles = dir('*.JPG');      
nfiles = length(imagefiles);

disp(nfiles);

images = {nfiles};

for ii=1:nfiles
   currentfilename = imagefiles(ii).name;
   currentimage = imread(currentfilename);
   images{ii} = currentimage;
end

input1 = images{1};
input2 = images{2};

results = defect(input1, input2);

disp("RESULTS");
for i=1:8
    disp(results(i));
end
    
    

function results = defect(input1, input2)
    images = {input1, input2};
    grayscale_images = {2};
    solar_perimeters= {2};
    
    areas = 1:2;
    perimeters = 1:2;
    
    defect_areas = 1:2;
    defect_perimeters = 1:2;
    
    defect_area_ratios = 1:2;
    
    small_count = zeros(2,2);
    medium_count = zeros(2,2);
    large_count = zeros(2,2);
    
    results = 1:8;

    for i=1:2
        grayscale_images{i} = rgb2gray(images{i});
    end
    
    [areas, perimeters] = binary(grayscale_images, areas, perimeters);
    [solar_perimeters, defect_area_ratios] = solarization(solar_perimeters, grayscale_images, defect_areas, defect_perimeters, defect_area_ratios, areas, perimeters);
    [small_count, medium_count, large_count] = all_defect_count (solar_perimeters, small_count, medium_count, large_count);
    
    results(2) = mean(defect_area_ratios);
    results(1) = round(10 * results(2));
    
    results(3) = sum(small_count(1,:));
    results(4) = sum(small_count(2,:));
    
    results(5) = sum(medium_count(1,:));
    results(6) = sum(medium_count(2,:));
    
    results(7) = sum(large_count(1,:));
    results(8) = sum(large_count(2,:));
   
end

function [areas, perimeters] = binary (grayscale_images, areas, perimeters)

    for i=1:2 
        binary_image = grayscale_images{i} > (0.10 * 255);
        binary_image2 = bwareafilt(binary_image, 1);
        binary_perimeter = bwperim(binary_image2, 4);

        binary_pixels = sum(binary_image2(:));
        perimeter_pixels = sum(binary_perimeter(:));

        areas(i) = binary_pixels;
        perimeters(i) = perimeter_pixels;        
    end

end

function [solar_perimeters, defect_area_ratios] = solarization (solar_perimeters, grayscale_images, defect_areas, defect_perimeters, defect_area_ratios, areas, perimeters)
    for i=1:2
        white_pixels = 0;
        solar_image = grayscale_images{i};
        [r, c] = size(solar_image);
        
        for x=1:r
            for y=1:c
                if solar_image(x, y) > 80
                    solar_image(x, y) = 255;
                    white_pixels = white_pixels + 1;
                end
            end
        end

        solar_perimeter = edge(solar_image,'sobel');
        solar_perimeters{i} = solar_perimeter;
        perimeter_pixels = sum(solar_perimeter(:));

        defect_areas(i) = areas(i) - white_pixels;
        defect_perimeters(i) = perimeter_pixels - perimeters(i);
        defect_area_ratios(i) = defect_areas(i) / areas(i);

    end
end

function [small_count, medium_count, large_count] = all_defect_count (solar_perimeters, small_count, medium_count, large_count)

    for i=1:2
        I_imfill = imfill(solar_perimeters{i}, 'holes');

        h = ones(2, 2) / 2;
        I_filter = imfilter(I_imfill, h);
        
        [round_number, long_number] = defect_count(I_filter, 0, 200);
        
        small_count(i, 1) = round_number;
        small_count(i, 2) = long_number;

        [round_number, long_number] = defect_count(I_filter, 201, 500);
        
        medium_count(i, 1) = round_number;
        medium_count(i, 2) = long_number;
        
        [round_number, long_number] = defect_count(I_filter, 501, 5000);
        
        large_count(i, 1) = round_number;
        large_count(i, 2) = long_number;
    end
end

function [round_number, long_number] = defect_count(image, lowerbound, upperbound)

    certain_defects = bwareafilt(image,[lowerbound upperbound]);
    certain_defect_perimeters = bwperim(certain_defects, 4);
    
    perimeter_pixels = sum(certain_defect_perimeters(:));

    
    cc = bwconncomp(certain_defects);
    number  = cc.NumObjects;

    if (number == 0)
        average_perimeter = 0;
    else
        average_perimeter = perimeter_pixels / number;
    end
    
    round_defect = bwareafilt(certain_defect_perimeters,[0 round(average_perimeter)]);
    long_defect = bwareafilt(certain_defect_perimeters,[round(average_perimeter) round(average_perimeter * 2)]);

    round_cc = bwconncomp(round_defect);
    round_number = round_cc.NumObjects;
    
    long_cc = bwconncomp(long_defect);
    long_number = long_cc.NumObjects;
    
end
