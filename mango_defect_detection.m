imagefiles = dir('*.JPG');      
nfiles = length(imagefiles);

disp(nfiles);

images = {nfiles};

for ii=1:nfiles
   currentfilename = imagefiles(ii).name;
   currentimage = imread(currentfilename);
   images{ii} = currentimage;
end

input1 = images{1};
input2 = images{2};

results = mango_defect_main(input1, input2);

disp("RESULTS");
for i=1:8
    disp(results(i));
end
    
    

