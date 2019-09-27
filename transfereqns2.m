function posveldot=transfereqns2(t,posvel)
gravity=gravmoon(posvel);
posveldot=[posvel(3);posvel(4);gravity(1);gravity(2)];
