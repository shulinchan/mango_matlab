a = load('answer.dat');
the_answer = zeros(50,4);

for i = 1:50 
    countA = a(i,2);
    countB = a(i,3);
    the_answer(i,1) = i;
    the_answer(i,2) = a(i,2);
    the_answer(i,3) = a(i,3);
    
    %ripe is represented by 1, unripe is represented by 0
    %if side-A has 0 then stem isn't visible so only check side-B, if side-B has 3-4 then it is ripe
    %if side-B has 0 then stem isn't visible so only check side-A, if side-A has 3-4 then it is ripe
    %if both are non 0, make sure both are within range 3-4
    %else not ripe
    if (countA == 0 && countB < 5 && countB > 2)
        the_answer(i,4) = 1;
    elseif (countB == 0 && countA < 5 && countA > 2)
        the_answer(i,4) = 1;
    elseif (countA < 5 && countA > 2 && countB < 5 && countB > 2)
        the_answer(i,4) = 1;
    else
        the_answer(i,4) = 0;
    end
end

save('catagorized_answer.dat','the_answer','-ascii')