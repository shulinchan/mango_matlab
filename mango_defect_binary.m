function [areas, perimeters] = mango_defect_binary (grayscale_images, areas, perimeters)

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