%% part a 
%hw4
clc
clear

L_leg = 0.9; % [m]
m_leg = 12.075; % [kg]
m_hip = 50.85; % [kg]
m_total = 2*m_leg + m_hip;

speed = [0.6416 0.6984 0.7552 0.8119 0.8687 0.9255 0.9822 1.039 1.096 ...
        1.153 1.209 1.266 1.323 1.380 1.407];
a2 = [1.5 1.745 1.99 2.296 2.541 2.847 3.092 3.337 3.582 3.765 ...
        3.949 4.071 4.255 4.316 4.378];
a4 = [0.351 0.3592 0.3673 0.3714 0.3755 0.3755 0.3714 0.3633 ...
        0.3551 0.3347 0.3143 0.2939 0.2653 0.2327 0.2122];
Ec = exp(1).^[5.815 6.234 6.59 7.037 7.343 7.74 8.073 8.429 8.777 ...
        9.187 9.621 10.02 10.71 11.46 12.23]

Z = [speed' a2' a4' Ec']
u = [];
q1 = [];
q2 = [];
leg = [];
for i=1:length(Z(:,1))
    out = walk(Z(i,2),Z(i,3),0,1)
    Z(i,5) = out.stepDuration(1);
    t = out.t;
    tnd = t/Z(i,5);
    
    
    x1 = -0.5*L_leg*sin(out.q(1,:));
    y1 = 0.5*L_leg*cos(out.q(1,:));
    
    xh = 2*x1;
    yh = 2*y1;
    
    x2 = xh + 0.5*L_leg*sin(out.q(1,:)+out.q(2,:));
    y2 = yh - 0.5*L_leg*cos(out.q(1,:)+out.q(2,:));
    
    xCOM = m_leg*(x1+x2) + m_hip*xh;
    yCOM = (m_leg*(y1+y2) + m_hip*yh)/m_total;
    
    vxCOM = [];
    vyCOM = [];
    for j = 1:length(xCOM)-1
        vxCOM(j) = (xCOM(j+1)-xCOM(j))/(t(j+1)-t(j));
        vyCOM(j) = (yCOM(j+1)-yCOM(j))/(t(j+1)-t(j));
    end
    vCOM = sqrt(vxCOM.^2 + vyCOM.^2);
    
    KE = 0.5*m_total*vCOM.^2;
    PE = m_total*9.81*yCOM;
    
    if (mod(i,2) == 0)
    figure(4)
    plot(tnd,out.u,'LineWidth',2)
    hold on
    
    figure(5)
    plot(tnd,out.q(1,:),'LineWidth',2)
    hold on
    
    figure(6)
    plot(tnd,out.q(2,:),'LineWidth',2)
    hold on
    
    figure(7)
    plot(tnd,out.dq(1,:),'LineWidth',2)
    hold on
    
    figure(8)
    plot(tnd,out.dq(2,:),'LineWidth',2)
    hold on
    
    figure(9)
    plot(tnd(1:end-1),KE)
    hold on
    
    figure(10)
    plot(tnd,PE)
    hold on
    
    figure(11)
    plot(tnd,xCOM)
    hold on
    
    figure(12)
    plot(tnd,yCOM)
    hold on
    
    leg= [leg speed(i)];
    end
   % q1 = out.q(1,:);
   % q2(i,:) = out.q(2,:);
end

%%

figure(12)
xlabel('Nondimensional Time','FontSize',18)
ylabel('y COM [m]','FontSize',18)
legend(num2str(leg(1)),num2str(leg(2)),num2str(leg(3)), ...
       num2str(leg(4)),num2str(leg(5)),num2str(leg(6)), ...
       num2str(leg(7)))
grid on







figure(4)
xlabel('Nondimensional Time','FontSize',18)
ylabel('Hip Torque [Nm]','FontSize',18)
legend(num2str(leg(1)),num2str(leg(2)),num2str(leg(3)), ...
       num2str(leg(4)),num2str(leg(5)),num2str(leg(6)), ...
       num2str(leg(7)))
title('Hip Torque vs. Time','FontSize',18)
figure(5)
xlabel('Nondimensional Time','FontSize',18)
ylabel('q1 [r]','FontSize',18)
legend(num2str(leg(1)),num2str(leg(2)),num2str(leg(3)), ...
       num2str(leg(4)),num2str(leg(5)),num2str(leg(6)), ...
       num2str(leg(7)))
title('q1 vs. Time','FontSize',18)
figure(6)
xlabel('Nondimensional Time','FontSize',18)
ylabel('q2 [rad]','FontSize',18)
legend(num2str(leg(1)),num2str(leg(2)),num2str(leg(3)), ...
       num2str(leg(4)),num2str(leg(5)),num2str(leg(6)), ...
       num2str(leg(7)))
title('q2 vs. Time','FontSize',18)
figure(7)
xlabel('Nondimensional Time','FontSize',18)
ylabel('dq1 [rad/s]','FontSize',18)
legend(num2str(leg(1)),num2str(leg(2)),num2str(leg(3)), ...
       num2str(leg(4)),num2str(leg(5)),num2str(leg(6)), ...
       num2str(leg(7)))
title('q1 Velocity vs. Time','FontSize',18)
figure(8)
xlabel('Nondimensional Time','FontSize',18)
ylabel('dq2 [rad/s]','FontSize',18)
legend(num2str(leg(1)),num2str(leg(2)),num2str(leg(3)), ...
       num2str(leg(4)),num2str(leg(5)),num2str(leg(6)), ...
       num2str(leg(7)))
title('q2 Velocity vs. Time','FontSize',18)



figure(1)
xlabel('Speed [m/s]','FontSize',18)
yyaxis left
plot(speed,a2,'b--','LineWidth',2.5)
ylabel('a2','FontSize',18)
yyaxis right 
plot(speed,a4,'r','LineWidth',2.5)
ylabel('a4','FontSize',18)
grid on


figure(2)
plot(speed,Z(:,5),'LineWidth',2.5)
xlabel('Speed [m/s]','FontSize',18)
ylabel('Step Duration [s]','FontSize',18)
grid on

figure(3) 
%plot(speed,log(Z(:,4)),'LineWidth',2.5)
semilogy(speed,Z(:,4),'LineWidth',2.5)
xlabel('Speed [m/s]','FontSize',18)
ylabel('Energy Cost [J]','FontSize',18)
grid on

