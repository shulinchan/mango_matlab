a = 1:50;
the_answer = zeros(50,4);
addpath('DB_Mango');

for i = 1:50
    str1a = 'Mango_0';
    str1b = 'Mango_';
    str2 = num2str(i);
    strA = strcat(str1a, str2);
    strB = strcat(str1b, str2);
    str3 = '_A.JPG';
    str4 = '_B.JPG';
    if i < 10
        filename = strcat(strA, str3);
        countA = runDemo(getRelevantPixels(imread(filename)));
        filename = strcat(strA, str4);
        countB = runDemo(getRelevantPixels(imread(filename)));
    else 
        filename = strcat(strB, str3);
        countA = runDemo(getRelevantPixels(imread(filename)));
        filename = strcat(strB, str4);
        countB = runDemo(getRelevantPixels(imread(filename)));
    end
    the_answer(i,1) = i;
    the_answer(i,2) = countA;
    the_answer(i,3) = countB;
        
end

save('answer.dat','the_answer','-ascii')