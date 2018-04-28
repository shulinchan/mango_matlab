%returns a number of specified feature vectors('bins')
%for a specific mango image ('mango')
%taking into account certain 'important' pixels
function features = getFeatures(bins,mango,important)
    %convert mango to hsv
    hsvMango = rgb2hsv(mango);
    [r,c] = size(mango);
    c = c/3; %since c has 3 channels and we just want the column count
    
    %get relevant pixels using bilateral filtering
    totalPixels = sum(sum(important));

    %separate values for h/s/v
    hImage = hsvMango(:, :, 1);
    sImage = hsvMango(:, :, 2);
    vImage = hsvMango(:, :, 3);
    
    %create vectors to add important values
    h = zeros(totalPixels,1);
    s = zeros(totalPixels,1);
    v = zeros(totalPixels,1);
    count = 1;
    
    %for each point equal to 1 in the 'important' matrix
    %add corresponding points to the h/s/v vectors
    for i=1:r
        for j=1:c
            if important(i,j) == 1
                h(count,1) = hImage(i,j);
                s(count,1) = sImage(i,j);
                v(count,1) = vImage(i,j);
                count = count + 1;
            end
        end
    end
    
    %sort the h/s/v vectors
    hSorted = sortrows(h)';
    sSorted = sortrows(s)';
    vSorted = sortrows(v)';

    %generate feature vectors for N bins (calculate mean/std/skew/kurtosis)
    %each image has a matrix of features [Nx12]
    %row# = bin number (so 1st row includes statistics for bin1)
    %each column is a different combination of (h/s/v + statistic)
    features = zeros(bins,12);

    %figure out how many per bin (for 1000 bins)
    perBin = floor(totalPixels/bins);

    %calculate statistics for each bin
    for i=0:(bins-1)
        if i == bins-1
            h = hSorted((perBin*i)+1:end);
            s = sSorted((perBin*i)+1:end);
            v = vSorted((perBin*i)+1:end);

            features(i+1,1) = mean(h);
            features(i+1,2) = std(h);
            features(i+1,3) = skewness(h);
            features(i+1,4) = kurtosis(h);

            features(i+1,5) = mean(s);
            features(i+1,6) = std(s);
            features(i+1,7) = skewness(s);
            features(i+1,8) = kurtosis(s);

            features(i+1,9) = mean(v);
            features(i+1,10) = std(v);
            features(i+1,11) = skewness(v);
            features(i+1,12) = kurtosis(v);
        else
            h = hSorted((perBin*i)+1:perBin*(i+1));
            s = sSorted((perBin*i)+1:perBin*(i+1));
            v = vSorted((perBin*i)+1:perBin*(i+1));

            features(i+1,1) = mean(h);
            features(i+1,2) = std(h);
            features(i+1,3) = skewness(h);
            features(i+1,4) = kurtosis(h);

            features(i+1,5) = mean(s);
            features(i+1,6) = std(s);
            features(i+1,7) = skewness(s);
            features(i+1,8) = kurtosis(s);

            features(i+1,9) = mean(v);
            features(i+1,10) = std(v);
            features(i+1,11) = skewness(v);
            features(i+1,12) = kurtosis(v);
        end
    end

    %remove NaN values as they affect calculation later
    for ii=1:bins
        for jj=1:12
            if isnan(features(ii,jj))
                features(ii,jj) = 0;
            end
        end
    end
end