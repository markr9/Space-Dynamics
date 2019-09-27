%A routine for working out the coordinates of the centre of mass of the
%space station modules.
clear all
syms totalmass
%This makes sure that all our variables are reset and defines a total mass
%scalar variable
modules=[2,3,-1,0;4,-3,1,1;3,-2,0,1;3,1,-5,0;2,0,2,1;9,1,1,-1]
%This line defines a 6 x 4 array. Each row of the array represents one of the
%space station modules. The first column is mass, the second the x location, the
%third the y location and the fourth the z location
cofmcoords=zeros(1,3)
totalmass=0
%This defines a 1 x 3 row vector called cofmcoords which is initialised
%with all its entries equal to zero. In Matlab, when you introduce an array
%you must initially set the values of its entries in this or a similar way.
for n=1:6
    totalmass=totalmass+modules(n,1)
    % This loop cycles through the modules
    for i=1:3
        % This loop cycles through the three coordinates
        cofmcoords(i)=cofmcoords(i)+modules(n,1).*modules(n,i+1)
        % The . serves an important purpose in the last term - it makes
        % sure that the multiplication is simply of elements of the
        % modules array NOT matrix multiplication.
    end
end
%This line prints out the final value of cofmcoords. Note when you run this
%m-file that the intermediate calculation of the centre of mass is
%presented. To suppress this you add a semi-colon at the end of the line
%e.g. cofmcoords(i)=cofmcoords(i)+modules(n,1).*modules(n,i+1);
cofmcoords_f=cofmcoords/totalmass