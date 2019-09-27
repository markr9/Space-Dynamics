%denstiy as a function of scale height
%parameters
H=1;
rho0=1.2 %kg/m^3
h=0:0.001:8*H;
%equations
rho_h=rho0*exp(-h/H);
%plot
figure(1)
plot(h,rho_h)
xlabel('height (h/H)')
ylabel('density (kg/m^3)')
title('Density with height')
grid on