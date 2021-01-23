function S = evaluatePolicy(P,numSteps)
S = [];
for j = 1:length(P(:,1))
    avet = 0;
    for k = 1:3
    out = walk(P(j,1),P(j,2),1,numSteps);
    avespeed = out.aveSpeed;
    ave = 0;
    for i=1:length(avespeed)
        if (isnan(avespeed(i)))
            ave = 0;
        else 
            ave = ave + avespeed(i);
        end
    end
    ave = ave/length(avespeed);
    avet = avet + ave;
    end
    avet = avet/3
    S = [S ; avet];
end

end

