function results = mango_defect_main(input1, input2)
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
    
    [areas, perimeters] = mango_defect_binary(grayscale_images, areas, perimeters);
    [solar_perimeters, defect_area_ratios] = mango_defect_solarization(solar_perimeters, grayscale_images, defect_areas, defect_perimeters, defect_area_ratios, areas, perimeters);
    [small_count, medium_count, large_count] = mango_defect_count (solar_perimeters, small_count, medium_count, large_count);
    
    results(2) = mean(defect_area_ratios);
    if (round(10 * results(2)) >= 1)
        results(1) = 1;
    else
        results(1) = 0;
    end    
    results(3) = sum(small_count(1,:));
    results(4) = sum(small_count(2,:));
    
    results(5) = sum(medium_count(1,:));
    results(6) = sum(medium_count(2,:));
    
    results(7) = sum(large_count(1,:));
    results(8) = sum(large_count(2,:));
   
end







