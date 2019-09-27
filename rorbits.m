%location
lat1=input('Start location lat (decimal degrees): ')*pi/180;
lat2=input('Finish location lat (decimal degrees): ')*pi/180;
lon1=input('Start location lon (decimal degrees): ')*pi/180;
lon2=input('Finish location lon (decimal degrees): ')*pi/180;
psi=2*asin(sqrt(sin((lat2-lat1)/2)^2+cos(lat1)*cos(lat2)*sin((lon2-lon1)/2)^2)); %psi change
psideg=psi*180/pi %in degrees
dist=6371e3*psi; %[m]
distkm=dist/1000
%parameters
G=6.67e-11;
M=5.972e24;
mach=input('Mach number: ');
v=mach*343 %[m/s]
alt=input('Altitude (m): '); %80km
r=alt+6371e3;
Q=(v^2*r)/(G*M);
RHS=(2-Q)/Q*sin(psi/2); %LHS=sin(2*boa+psi/2)=a
a=asin(RHS); %low
aa=pi-a; %high
b=a-psi/2; %b=boa, boa=a-psi/2 all /2
bb=aa-psi/2;
burnoutangle=b/2*180/pi;
boa=bb/2*180/pi;
a*180/pi
aa*180/pi
disp('burnout angle')
disp(burnoutangle) %low
disp(boa) %high
%highest point on orbit
sa=r/(2*Q); %a
e1=sqrt(1+Q*(Q-2)*cos(b/2)); %eccenticity, low
e2=sqrt(1+Q*(Q-2)*cos(bb/2)); %high
ap1=sa*(1+e1)
ap2=sa*(1+e2)
aph1=sa*(1-e1)-6371e3
aph2=sa*(1-e2)-6371e3
disp('semi-major axis (a)')
disp(sa)
disp('eccentricty')
disp(e1)
disp(e2)
disp('apogee')
disp((ap1-6371e3)/1000) %low
disp((ap2-6371e3)/1000) %high
%orbit
p1=sa*(1-e1*e1);
p2=sa*(1-e2*e2);
n=100;
t=0:pi/n:2*pi;
r1=p1./(1+e1*cos(t));
r2=p2./(1+e2*cos(t));
figure(1)
polar(t,r1);
hold on
polar(t,r2);
t2=0:1:360;
t2=t2./180.*pi;
earth=ones(1,361);
earth=earth*6371e3;
polar(t2,earth);
hold off
figure(2)
plot(t,r1);
hold on
plot(t,r2);
plot(t2,earth);
hold off
grid on