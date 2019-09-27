%mass input
modules=[2,3,-1,0;4,-3,1,1;3,-2,0,1;5,1,-5,0;2,0,2,1;9,1,1,-1] %[m,x,y,z;1,2,3,4;]
%CoM change
com=[0.0800,-0.4000,0]
mtot=0;
m=1; x=2; y=3; z=4;
for w=1:6
    modules(w,x)=modules(w,x)-com(1);
    modules(w,y)=modules(w,y)-com(2);
    modules(w,z)=modules(w,z)-com(3);
end
modules
for k=1:6
    mtot=mtot+modules(k,m); %finds the total mass
end
mtot
%I tensor
%find elements
a=0; b=0; c=0; d=0; e=0; f=0; g=0; h=0; i=0;
for j=1:6
    aa=modules(j,m)*(modules(j,y)^2+modules(j,z)^2);
    a=a+aa;
    bb=modules(j,m)*modules(j,x)*modules(j,y);
    b=b+bb;
    cc=modules(j,m)*modules(j,x)*modules(j,z);
    c=c+cc;
    dd=bb;
    d=d+dd;
    ee=modules(j,m)*(modules(j,x)^2+modules(j,z)^2);
    e=e+ee;
    ff=modules(j,m)*modules(j,y)*modules(j,z);
    f=f+ff;
    gg=cc;
    g=g+gg;
    hh=ff;
    h=h+hh;
    ii=modules(j,m)*(modules(j,x)^2+modules(j,y)^2);
    i=i+ii;
end
a,b,c,d,e,f,g,h,i
I=[a,-b,-c;-d,e,-f;-g,-h,i]
%eign- values+vectors
[V,D]=eig(I) %V=vector, D=values
%plot
X=zeros(1,6);
Y=zeros(1,6);
Z=zeros(1,6);
for q=1:6
    X(q)=modules(q,x);
    Y(q)=modules(q,y);
    Z(q)=modules(q,z);
end
%vectors plot
m=[0,0,0;V(1,1),V(2,1),V(3,1)]*D(1,1);
n=[0,0,0;V(1,2),V(2,2),V(3,2)]*D(2,2);
o=[0,0,0;V(1,3),V(2,3),V(3,3)]*D(3,3);
figure
plot3(X,Y,Z,'o',m(1:2,1),m(1:2,2),m(1:2,3),n(1:2,1),n(1:2,2),n(1:2,3),o(1:2,1),o(1:2,2),o(1:2,3))
grid on
xlabel('x (m)')
ylabel('y (m)')
zlabel('z (m)')
legend('mass','vecotr 1','vector 2','vector 3')