%% ME 597 HW 4
% Bader AlAttar
clc
clear

L_leg = 0.9; % [m]
m_leg = 12.075; % [kg]
m_hip = 50.85; % [kg]
% HZD based control

noise = 0;
numSteps = 1;

n = 50;
a2min = 1.5;
a2max=  4.5;
a4min = 0.2;
a4max = 0.4;
a4range = a4max - a4min;
a2range = a2max - a2min;
r =[0];
for i = 1:n-1
    r(i+1) = r(i) + 1/i;
end
r = r/max(r)
a2t = flip(flip(r)*a2range + a2min)
a4t = r*a4range + a4min
a2 = linspace(1.5,4.5,n);
a4 = linspace(0.2,0.4,n);
[A2 A4] = meshgrid(a2,a4);

speed= [];
stepDuration = [];
energyCost = [];

for j = 1:n  % a2
    for k = 1:n  % a4
        
        out = walk(a2(j),a4(k),noise,numSteps);
        if (out.fell)
            speed(j,k) = NaN;
            stepDuration(j,k) = NaN;
            energyCost(j,k) = NaN;
        else
            speed(k,j) = out.aveSpeed;
            stepDuration(k,j) = out.stepDuration;

            I = 0;
            for i=1:length(out.u)-1
                In = abs( out.u(i)*out.dq(2,i) );
                I = I + In*(out.t(i+1)-out.t(i));
            end
            energyCost(k,j) = I/stepDuration(1);
        end
    end
end

% j a2
% k a4

%%

energyCost = energyCost%/max(max(energyCost))
figure(1)
[cs hs] = contourf(A2,A4,speed,10)
xlabel('a_{2}','FontSize',18)
ylabel('a_{4}','FontSize',18)
%title('Speed','FontSize',18)
clabel(cs,hs)
colorbar
figure(2)
[csd hsd] =contourf(A2,A4,stepDuration,10)
xlabel('a_{2}','FontSize',18)
ylabel('a_{4}','FontSize',18)
%title('Step Duration','FontSize',18)
clabel(csd,hsd)
colorbar
figure(3)
[ces hes] = contourf(A2,A4,log(energyCost),10)
xlabel('a_{2}','FontSize',18)
ylabel('a_{4}','FontSize',18)
%title('Energy Cost','FontSize',18)
clabel(ces,hes)
colorbar


figure(4)
subplot(1,2,1)
Ec = energyCost(:);
sp = speed(:);
scatter(sp,Ec)
xlabel('Speed [m/s]','FontSize',18)
ylabel('Energy Cost [J]','FontSize',18)
%title('Energy Cost','FontSize',18)
grid on
subplot(1,2,2)
scatter(sp,Ec)
axis([1.2 1.38 1*10^4 8*10^4 ])
xlabel('Speed [m/s]','FontSize',18)
ylabel('Energy Cost [J]','FontSize',18)

figure(5)
[cf hf ] = contourf(speed,stepDuration, log(energyCost),10)

%% 
figure(5)
contourf(stepDuration,speed,energyCost,200)

figure(6)
contourf(A2,A4,speed,10)
hold on
colorbar
hold on
contourf(A2,A4,energyCost,10)
hold on
colorbar

figure(9)
[C1 h1] = contourf(A2,A4,log(energyCost),15)
hold on 
[C2 h2] = contour(A2,A4,speed,15,'LineWidth',3)
clabel(C2,h2)
%% 
A2c = A2(:);
A4c = A4(:);
spc = speed(:);
ecc = energyCost(:);
sdc = stepDuration(:);
X = [A2c A4c spc sdc ecc ] ;
X = sortrows(X,3);
X(:,6) = X(:,5)/max(ecc);

thresh = min(spc);
for i = X(:,3)
    
end
figure(7)
histogram()