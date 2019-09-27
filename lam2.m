% points
ar=1 %array or single value
p1=[45,90,0  ,180,90 ,270,0  ,240,90 ,190,30 ,170,30, 190,330,30 ,200,340,260,10 ,20 ,300,150,340,350,10 ,60 ,156,200,300]%[0,60,0,120,0,180,0,240,0,300,-180,180]
p2=[90,45,180,360,270,90, 120,360,170,270,170,30 ,190,30 ,30 ,330,340,200,10, 260,300,20 ,340,150,10 ,350,225,219,300,200]%[60,0,120,0,180,0,240,0,300,0,180,-180]
%half orbits x4, quarter orbits x6 (2/3 symetric), 4 cases, 4 case alt
T=zeros(length(p1));
gktp1=p1*pi/180
gktp2=p2*pi/180

% plot ellipse of orbit
gkt=0:pi/180:2*pi; %theata
a=1.496e11 %semi-major axis
e=0.5 %eccentricity
p=a*(1-e^2)
r=p./(1+e*cos(gkt));
x=r.*cos(gkt);
y=r.*sin(gkt);
plot(x,y)
xlabel('x (m)')
ylabel('y (m)')
title('Lambert theory')
grid on
hold on
G=6.67e-11;
M=1.989e30;
P=sqrt((4*pi*pi*a*a*a)/(G*M)) %peroid
P=P/(60*60*24*365.25) %second to year conversion

% d and r1 and r2
r1=p./(1+e*cos(gktp1))
r2=p./(1+e*cos(gktp2))
d=sqrt(r1.*r1+r2.*r2-2*r1.*r2.*cos(gktp2-gktp1))
f=acos(1-(r1+r2+d)/(2*a))
g=acos(1-(r1+r2-d)/(2*a))
%choose case
i=1;
while i<=length(p1)
    if (gktp2(i)>=gktp1(i))
        if (gktp1(i)<=pi & gktp2(i)<=pi) | (gktp1(i)>=pi & gktp2(i)>=pi)
            Ta=P/(2*pi)*((f(i)-sin(f(i)))-(g(i)-sin(g(i))))
            T(i)=Ta;
        else
            Tb=P/(2*pi)*(2*pi-(f(i)-sin(f(i)))-(g(i)-sin(g(i))))
            T(i)=Tb;
        end
    elseif (gktp1(i)<=pi & gktp2(i)<=pi) | (gktp1(i)>=pi & gktp2(i)>=pi)
        Tc=P/(2*pi)*(2*pi-(f(i)-sin(f(i)))+(g(i)-sin(g(i))))
        T(i)=Tc;
    else
        Td=P/(2*pi)*((f(i)-sin(f(i)))+(g(i)-sin(g(i))))
        T(i)=Td;
    end
    i=i+1;
end
if ar==1 %matches the opposite halves to orbit to see is they give P (as long as next to each other in array)
    j=1;
    while j<=length(p1)
        TT=T(j)+T(j+1)
        j=j+2;
    end
end
Pyr=P
%plot points
r11=p./(1+e*cos(gktp1));
r22=p./(1+e*cos(gktp2));
x1=r11.*cos(gktp1);
x2=r22.*cos(gktp2);
y1=r11.*sin(gktp1);
y2=r22.*sin(gktp2);
plot(x1,y1,'o',x2,y2,'x')
legend('Orbit','P1 points','P2 points','Location','Eastoutside')
hold off