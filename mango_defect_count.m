function [small_count, medium_count, large_count] = mango_defect_count (solar_perimeters, small_count, medium_count, large_count)

    for i=1:2
        I_imfill = imfill(solar_perimeters{i}, 'holes');

        h = ones(2, 2) / 2;
        I_filter = imfilter(I_imfill, h);
        
        [round_number, long_number] = mango_each_defect_count(I_filter, 0, 200);
        
        small_count(i, 1) = round_number;
        small_count(i, 2) = long_number;

        [round_number, long_number] = mango_each_defect_count(I_filter, 201, 500);
        
        medium_count(i, 1) = round_number;
        medium_count(i, 2) = long_number;
        
        [round_number, long_number] = mango_each_defect_count(I_filter, 501, 5000);
        
        large_count(i, 1) = round_number;
        large_count(i, 2) = long_number;
    end
end