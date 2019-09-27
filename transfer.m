% probe
G=6.67e-11
rs=1.496e11 %orbit start (perihelion)
re=2.279e11 %orbit end (apohelion)
%input the initial x position, y position, x velocity and y %velocity in posvel0

rp=rs    
ra=re   
a=(rp+ra)/2
massrad=planetparameters
vi=sqrt((2*G*massrad(1))/rp-(G*massrad(1)/a))

posvel0 = [1.496e11;0;0;-vi]

%see which planet we're orbiting
%parameters are given in planet parameters


% set the time for which to work out the trajectory

tfinal=sqrt((4*pi*pi*a*a*a)/(G*massrad(1)))

% work out the initial total energy = kinetic + potential

inenergy=0.5*(posvel0(3).^2+posvel0(4).^2) -G*massrad(1)/sqrt(posvel0(1).^2+posvel0(2).^2)

% call an integrating routine to solve the differential equations 
%that are defined by a function stored in an m-file called 
%probeeqns.m with initial conditions stored in posvel0

options=odeset('RelTol',1e-8);
[t,posvel]=ode45('transfereqns',[0, tfinal], posvel0, options);
figure

% the command below plots a 2-d plot of the trajectory of the 
% probe in Cartesian coordinates x and y after using x2 and y2 
% to plot the surface of the planet (assumed spherical)

q=(0:0.01:2)*pi;
x2=massrad(2)*cos(q);
y2=massrad(2)*sin(q);
xs=rs*cos(q);
ys=rs*sin(q);
xe=re*cos(q);
ye=re*sin(q);
plot(posvel(:,1),posvel(:,2),x2,y2,xs,ys,xe,ye);
top=length(t)
finenergy=0.5*(posvel(top,3).^2+ + posvel(top,4).^2)-G*massrad(1)/sqrt(posvel(top,1).^2+posvel(top,2).^2);
accuracy=((finenergy-inenergy)/inenergy)
xlabel('x (m)')
ylabel('y (m)')
title('Earth-Mars Hohmann orbit')
grid on
legend('Rocket orbit','Sun','Earth orbit','Mars orbit','Location','Eastoutside')