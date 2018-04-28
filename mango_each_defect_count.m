function [round_number, long_number] = mango_each_defect_count(image, lowerbound, upperbound)

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
