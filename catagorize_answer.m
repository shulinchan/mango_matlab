a = load('answer.dat');
the_answer = zeros(50,4);
for i = 1:50 
    countA = a(i,2);
    countB = a(i,3);
    the_answer(i,1) = i;
    the_answer(i,2) = a(i,2);
    the_answer(i,3) = a(i,3);
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