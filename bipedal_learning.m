clc
clear

%% 

clc
clear
numPolicy = 10;  % number of policies to randomly generate each round
numIter = 15;
eta = 0.05;
numSteps = 5;
q10 = 3;  %% Initial q1 parameter
q20 = .4;  % Initial q2 parameter

pi = [q10 q20]; % Initial Policy

e = 0.05; % pertrubation ( + 0 - )
avefinal = [];
for j = 1:numIter
Policies = [];
for i=1:numPolicy
    r1 = rand;
    r2 = rand;
    if (r1 < 0.33) 
       Policies(i,1) = pi(1) + e;
    elseif (r1 < 0.66) 
       Policies(i,1) = pi(1) - e;    
    else 
       Policies(i,1) = pi(1);     
    end
    
    if (r2 < 0.33) 
       Policies(i,2) = pi(2) + e;
    elseif (r2 < 0.66) 
       Policies(i,2) = pi(2) - e;    
    else 
       Policies(i,2) = pi(2);     
    end
    
    
end
aveSpeed = [];
zeroit=0;
fell = [];
for i = 1:numPolicy
    out = walk(Policies(i,1),Policies(i,2),1,numSteps)
    for k = 1:length(out.aveSpeed)
        if isnan(out.aveSpeed(k)) 
            zeroit = 1;
        end
    end
    if (zeroit == 1)
        aveSpeed = [aveSpeed ; zeros(1,numSteps)];
    else 
         aveSpeed = [aveSpeed; out.aveSpeed ];
    end
    zeroit = 0;
    fell = [fell out.fell];
end

for i= 1:numPolicy
aveSt(i) = mean(aveSpeed(i,:));
end
q1plusave = 0;
q1minusave = 0;
q1zeroave = 0;
q2plusave = 0;
q2minusave = 0;
q2zeroave = 0;
n1z= 0;
n1p= 0;
n1m= 0;
n2z= 0;
n2p= 0;
n2m = 0;
for i=1:numPolicy

    if (Policies(i,1) > pi(1)) 
        if (fell(i) == 1) 
            q1plusave = q1plusave -1;
            
        else 
        q1plusave = q1plusave + aveSt(i);
        end
        n1p = n1p + 1;
    elseif (Policies(i,1) < pi(1))
        if (fell(i) == 1)
            q1minusave = q1minusave -1;
        else 
        q1minusave = q1minusave + aveSt(i);
        end
           n1m = n1m + 1;
    else
        if (fell(i) == 1) 
                    q1zeroave = q1zeroave -1;
        else  
        q1zeroave = q1zeroave + aveSt(i);
        end
           n1z = n1z + 1;
    end
    
    if (Policies(i,2) > pi(2)) 
        if (fell(i) == 1)
           q2plusave = q2plusave -1;
        else
        q2plusave = q2plusave + aveSt(i);
        end
           n2p = n2p + 1;
    elseif (Policies(i,2) < pi(2))
        if (fell(i) == 1)
           q2minusave = q2minusave -1; 
        else 
        q2minusave = q2minusave + aveSt(i);
        end
           n2m = n2m + 1;
    else
        if (fell(i) == 1)
        q2zeroave = q2zeroave - 1;
        else
        q2zeroave = q2zeroave + aveSt(i);
        end
           n2z = n2z + 1;
    end
end

if (n1p > 0) 
q1plusave = q1plusave/n1p;
else 
    q1plusave = 0;
end
if (n1m >0)
q1minusave = q1minusave/n1m;
else 
    q1minusave = 0;
end
if (n1z > 0 )
q1zeroave = q1zeroave/n1z;
else
    q1zeroave = 0;
end
if (n2p > 0) 
q2plusave = q2plusave/n2p;
else 
    q2plusave = 0;
end
if (n2m > 0 )
q2minusave = q2minusave/n2m;
else 
    q2minusave = 0;
end
if (n2z > 0 )
q2zeroave = q2zeroave/n2z;
else 
q2zeroave = 0;
end
A = [0 0];
if (q1zeroave > q1minusave && q1zeroave > q1plusave )
    A(1) = 0;
else 
    A(1) = q1plusave - q1minusave;
    
end

if (q2zeroave > q2minusave && q2zeroave > q2plusave )
    A(2) = 0;
else 
    A(2) = q2plusave - q2minusave;
end
    
Al = sqrt(A(1)^2 + A(2)^2);
if (Al ~= 0 )
    A = A/Al*eta;
else 
    A = [0 0];
end

pi = pi + A
if (isnan(A)) 
    break;
end
outf = walk(pi(1),pi(2),1,numSteps);
avefinal = [avefinal mean(outf.aveSpeed) ];
end

t = linspace(1,numIter,numIter)
plot(t,avefinal)
