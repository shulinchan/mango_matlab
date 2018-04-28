function [solar_perimeters, defect_area_ratios] = mango_defect_solarization (solar_perimeters, grayscale_images, defect_areas, defect_perimeters, defect_area_ratios, areas, perimeters)
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