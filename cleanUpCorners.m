%check rowsCorners
function count = cleanUpCorners(corners)
    count = 0;
    for i = 1:size(corners,1)-1
        x1 = corners(i,1);
        y1 = corners(i,2);
        x2 = corners(i+1,1);
        y2 = corners(i+1,2);
        if (abs(x1-x2)>2 || abs(y1-y2)>2)
            count = count + 1;
        end
    end
end
