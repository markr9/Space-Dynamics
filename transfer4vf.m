% probe
G=6.67e-11
rearth=1.496e11 
rmer=5.791e10
rmar=2.279e11
rjup=7.786e11
rura=2.873e12
rnep=4.495e12
massrad=planetparameters2
%input the initial x position, y position, x velocity and y %velocity in posvel0
order=[rearth,rmer,rnep,rmer,rura,rmer,rjup,rmer,rmar,rearth]
time=length(order)
i=1
tot=0

q=(0:0.01:2)*pi;
x2=massrad(2)*cos(q);
y2=massrad(2)*sin(q);
xearth=rearth*cos(q);
yearth=rearth*sin(q);
xmer=rmer*cos(q);
ymer=rmer*sin(q);
xmar=rmar*cos(q);
ymar=rmar*sin(q);
xjup=rjup*cos(q);
yjup=rjup*sin(q);
xura=rura*cos(q);
yura=rura*sin(q);
xnep=rnep*cos(q);
ynep=rnep*sin(q);
plot(x2,y2,xearth,yearth,xmer,ymer,xmar,ymar,xjup,yjup,xura,yura,xnep,ynep);
hold on
while i<(length(order))
    
    rp=order(i)    %orbit start (perihelion)
    ra=order(i+1)    %orbit end (apohelion)
    a=(rp+ra)/2
    vi=sqrt((2*G*massrad(1))/rp-(G*massrad(1)/a))

    posvel0 = [(-1)^(i+1)*order(i);0;0;(-1)^i*vi]

    %see which planet we're orbiting
    %parameters are given in planet parameters


    % set the time for which to work out the trajectory

    tfinal=sqrt((4*pi*pi*a*a*a)/(G*massrad(1)))/2

    % work out the initial total energy = kinetic + potential

    inenergy=0.5*(posvel0(3).^2+posvel0(4).^2) -G*massrad(1)/sqrt(posvel0(1).^2+posvel0(2).^2)

    % call an integrating routine to solve the differential equations 
    %that are defined by a function stored in an m-file called 
    %probeeqns.m with initial conditions stored in posvel0

    options=odeset('RelTol',1e-8);
    [t,posvel]=ode45('transfereqns3',[0, tfinal], posvel0, options);
    figure(1)

    % the command below plots a 2-d plot of the trajectory of the 
    % probe in Cartesian coordinates x and y after using x2 and y2 
    % to plot the surface of the planet (assumed spherical)
    plot(posvel(:,1),posvel(:,2))
    tot=tfinal+tot %total time
    time(i)=tfinal/(60*60*24*365.25)
    i=i+1;
end

top=length(t)
finenergy=0.5*(posvel(top,3).^2+ + posvel(top,4).^2)-G*massrad(1)/sqrt(posvel(top,1).^2+posvel(top,2).^2);
accuracy=((finenergy-inenergy)/inenergy)
xlabel('x (m)')
ylabel('y (m)')
title('Hohmann orbit trip')
grid on
legend('Sun','Earth orbit','Mercury orbit','Mars orbit','Jupiter orbit','Uranus orbit','Neptune orbit','Rocket orbit (Earth-Mer)','(Mer-Nep)','(Nep-Mer)','(Mer-Ura)','(Ura-Mer)','(Mer-Jup)','(Jup-Mer)','(Mer-Mar)','(Mar-Earth)','Location','Eastoutside')
hold off
tot
totyr=tot/(60*60*24*365.25) %years
time %time for each trip