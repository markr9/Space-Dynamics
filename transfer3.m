% probe
G=6.67e-11
massrad=planetparameters
vh=823
a=(G*massrad(1))/vh^2
e=1+massrad(2)/a
beta=acos(1/e)
rs=massrad(2) %orbit start (perihelion)
%input the initial x position, y position, x velocity and y %velocity in posvel0

vi=sqrt(vh^2+(2*G*massrad(1))/massrad(2))
m6=6*rs %6 moon radii

posvel0 = [-1738000*cos(beta);1738000*sin(beta);vi*sin(beta);vi*cos(beta)]

%see which planet we're orbiting
%parameters are given in planet parameters


% set the time for which to work out the trajectory

tfinal=7073

% work out the initial total energy = kinetic + potential

inenergy=0.5*(posvel0(3).^2+posvel0(4).^2) -G*massrad(1)/sqrt(posvel0(1).^2+posvel0(2).^2)

% call an integrating routine to solve the differential equations 
%that are defined by a function stored in an m-file called 
%probeeqns.m with initial conditions stored in posvel0

options=odeset('RelTol',1e-8);
[t,posvel]=ode45('transfereqns2',[0, tfinal], posvel0, options);
figure

% the command below plots a 2-d plot of the trajectory of the 
% probe in Cartesian coordinates x and y after using x2 and y2 
% to plot the surface of the planet (assumed spherical)

q=(0:0.01:2)*pi;
x2=massrad(2)*cos(q);
y2=massrad(2)*sin(q);
m6x=m6*cos(q);
m6y=m6*sin(q);
x=0:-1e6:-2e6;
y=0:1e6:2e6;
plot(posvel(:,1),posvel(:,2),x2,y2,m6x,m6y,x,y);
top=length(t)
finenergy=0.5*(posvel(top,3).^2+ + posvel(top,4).^2)-G*massrad(1)/sqrt(posvel(top,1).^2+posvel(top,2).^2);
accuracy=((finenergy-inenergy)/inenergy)
xlabel('x (m)')
ylabel('y (m)')
title('Moon Hyperbolic orbit')
grid on
legend('Rocket orbit','Moon','6 Moon radii limit','Location','Eastoutside')