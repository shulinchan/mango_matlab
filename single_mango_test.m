addpath('./images');
imagefiles = dir('./images/*.jpg');
nfiles = length(imagefiles);

defectCorrect = 0;
maturityCorrect = 0;

for i=1:nfiles
    fileName = imagefiles(i).name;
    fLen = length(fileName);
    if fileName(fLen-6) == 'A'
        fileName2 = fileName;
        fileName2(fLen-6) = 'B';
        result = single_mango(fileName,fileName2);
        
        %set results
        def1 = 'N';
        mat1 = 'I';
        def2 = 'N';
        mat2 = 'I';
        if result(1,1) == 1
            mat1 = 'M';
        end
        if result(1,2) == 1
            def1 = 'D';
        end
        if fileName(fLen-4) == 'M'
            mat2 = 'M';
        end
        if fileName(fLen-5) == 'D'
            def2 = 'D';
        end
        
        %print results
        formatSpec = '%s --> Prediction: %c %c Actual: %c %c\n';
        fprintf(formatSpec,fileName,def1,mat1,def2,mat2);
        
        %increment counts
        if def1 == def2
            defectCorrect = defectCorrect + 1;
        end
        if mat1 == mat2
            maturityCorrect = maturityCorrect + 1;
        end
    end
end

%print correctness
formatSpec = 'Defectedness: %d/%d\n';
formatSpec2 = 'Maturity: %d/%d';
fprintf(formatSpec,defectCorrect,nfiles/2);
fprintf(formatSpec2,maturityCorrect,nfiles/2);