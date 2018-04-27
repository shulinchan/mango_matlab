%generates a black/white image using bilateral filtering
%black -> background pixel
%white -> mango pixel
function final = getRelevantPixels(image)
    %Note: Must be double precision in the interval [0,1].
    img1 = double(image)/255;

    % Set bilateral filter parameters.
    w     = 5;       % bilateral filter half-width
    sigma = [3 0.1]; % bilateral filter standard deviations

    % Apply bilateral filter to each image.
    bflt_img1 = bfilter2(img1,w,sigma);
    img = im2bw(rgb2gray(bflt_img1),0.1);
    filled_img = imfill(img,'holes');
    final = bwareafilt(filled_img,[500 50000000000]);
end