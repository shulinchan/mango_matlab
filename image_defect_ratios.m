load binary_defect_areas_ratios_new.dat
areas = binary_defect_areas_ratios_new;

% load binary_defect_areas_new.dat
% areas = binary_defect_areas_new;
% 
% load binary_areas.dat
% areas_binary = binary_areas;

disp(length(areas));

count = 1;
for i=1:length(areas)
    if (mod(count, 2))
        letter = 'A';
    else
        letter = 'B';
    end
    count_half = round(count/2);
    count = count + 1;
    
%     fprintf('mango_area_%.02d_%c = %.3f\n', count_half, letter, areas_binary(i));
    fprintf('mango_defect_area_%.02d_%c = %.3f\n', count_half, letter, areas(i));

end