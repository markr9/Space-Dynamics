function posveldot=transfereqns3(t,posvel)
gravity=gravsun(posvel);
posveldot=[posvel(3);posvel(4);gravity(1);gravity(2)];
