function count = runDemo(input)
    % Load test images.
    % Note: Must be double precision in the interval [0,1].
    % img1 = double(imread('Mango_42_B.JPG'))/255;
    %img1 = double(input)/255;
    % % img3 = double(imread('Mango_13_B.JPG'))/255;

    % Set bilateral filter parameters.
    %w     = 5;       % bilateral filter half-width
    %sigma = [3 0.1]; % bilateral filter standard deviations

    % Apply bilateral filter to each image.
    %bflt_img1 = bfilter2(img1,w,sigma);

%     img = rgb2gray(bflt_img1);
%     imga = im2bw(img,0.1);
%     figure(4); clf;
%     set(gcf,'Name','Result of changing to bw');
%     imshow(imga); axis image;
%     title('blackwhite');

%     filled_img2=imfill(imga,'holes');
%     figure(5); clf;
%     set(gcf,'Name','Result of GrayScale from Image Abstraction');
%     imshow(filled_img2); axis image;
%     title('filled_img');

%     rm_white_spots_img2=bwareafilt(filled_img2,[500 50000000000]);
%     figure(6); clf;
%     set(gcf,'Name','Result of Removing White Spots');
%     imshow(rm_white_spots_img2); axis image;
%     title('removed_white_spots');

    BW = edge(input);
%   figure(7); imshow(BW);
    Orientations = skeletonOrientation(BW,5); %5x5 box
    Onormal = Orientations+90; %easier to view normals
    Onr = sind(Onormal); %vv
    Onc = cosd(Onormal); %uu
    [r,c] = find(BW);    %row/cols
    idx = find(BW);      %Linear indices into Onr/Onc
%     figure(8); imshow(BW,[]);
    %Overlay normals to verify
%     hold on
%     quiver(c,r,-Onc(idx),Onr(idx));
    A = Orientations;
    %find all coordinates of edges
    [x,y] = find(BW);
    %find angle of the hairs

    visited_matrix = dfs(BW,x(1),y(1));

    % remove the first dummy row
    visited_matrix(1,:)=[];

    theseq = [];

    %iterate through visited_matrix
    for row = 1:size(visited_matrix,1)
        x = visited_matrix(row,1);
        y = visited_matrix(row,2);
        theseq = [theseq;[x,y,A(x,y)]];
    end

    % create absolute of the differences between points
    for row = 1:size(theseq,1)-1
        value1 = abs(theseq(row,3));
        value2 = abs(theseq(row+1,3));

        theseq(row,4) = abs(value2-value1);
    end

    % get all rows where difference is greater than 15
    rowsCorner = theseq(theseq(:,4)>15, :);

    count = cleanUpCorners(rowsCorner);
end

% %check rowsCorners 
% function count = cleanUpCorners(corners)
%     count = 0;
%     for i = 1:size(corners,1)-1
%         x1 = corners(i,1);
%         y1 = corners(i,2);
%         x2 = corners(i+1,1);
%         y2 = corners(i+1,2);
%         if (abs(x1-x2)>2 || abs(y1-y2)>2)
%             count = count + 1;
%         end
%     end
% end


% function visited_matrix = dfs(BW,x,y)
%     stack = [];
%     visited = [];
%     stack = [stack; [x,y]];
%     %dummy value so it doesn't throw an error on first run.
%     visited = [visited; [0 0]];
%     while ~isempty(stack)
%         disp('stack');
%         disp(stack);
%         % pop stack
%          v = stack(end, :);
%          disp(' v');
%          disp(v);
%          stack(end,:) = [];
%          if (~ismember(v, visited, 'rows'))
%             visited = [visited; v];
%             disp('visited');
%             disp(visited);
%             %for all edges, push to stack, these coordinates have to be in this specific order
%             neighbors = [[x-1,y];[x+1,y];[x,y+1];[x,y-1];[x-1,y+1];[x+1,y+1];[x-1,y-1];[x+1,y-1]];
%             disp(neighbors);
%             for i = 1:8
%                 x = neighbors(i,1);
%                 y = neighbors(i,2);
%                 % break once it finds one
%                 if BW(x, y) == 1 && ~ismember([x,y], visited, 'rows')
%                     stack = [stack; [x,y]];
%                     break;
%                 end
%             end
%         end   
%     end
%     visited_matrix = visited;
% end