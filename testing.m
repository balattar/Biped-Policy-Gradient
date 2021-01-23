clc
clear


pi = [2 0.3]; % initial parameters

e = [0.5 0.1]; % random pertrubation value

numPolicy = 3;
numSteps = 5;
numIter = 15;

Spiupdate = [];
pit = [pi];
for i = 1:numIter
P = generatePolicy(pi,e,numPolicy);
Spi = evaluatePolicy(pi,numSteps);
Spiupdate = [Spiupdate Spi];
Score = evaluatePolicy(P,numSteps);
A = adjustmentvector(pi,P,Score,Spi);

pi = pi + A.*e;
pit = [pit ; pi];
plot(linspace(1,i,i),Spiupdate)
end
Spi = evaluatePolicy(pi,numSteps);
Spiupdate = [Spiupdate Spi];

figure(1)
plot(linspace(1,i+1,i+1),Spiupdate)
