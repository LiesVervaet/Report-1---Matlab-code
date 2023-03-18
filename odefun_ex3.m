function [y] = odefun_ex3(t,Y,param)
v = param.v;                        %m*d^-1, transform from m*h^-1
D = param.D;                        %m²*d^-1, transform from cm²*s^-1
dz = param.dz;
z = param.z;                        %m
Nb = param.Nb; 
H_N = param.H_N;
H_I = param.H_I;
eta = param.eta;
alpha = param.alpha;
n = z/dz;

P = Y(1:n);
N = Y(n+1:2*n);

J_p = zeros(1,n+1);
J_n = zeros(1,n+1);

%Flux of phytoplankton
%Closed boundary condition
J_p(1) = 0;
J_p(n+1) = 0;

   for i = 2:n  
       Ja_p(i) = v.*P(i-1);
       Jd_p(i) = -D.*(P(i)-P(i-1))/dz;
       J_p(i) = Ja_p(i) + Jd_p(i);
   end

%Flux of nutrients
%Boundary condition

J_n(1) = 0;
J_n(n+1) = -D*(Nb-N(end))/dz;

  for i = 2:n  
       Jd_n(i) = -D.*(N(i)-N(i-1))./dz;
       J_n(i) = Jd_n(i);
   end


   [I,g] = LightFunction(Y,param);
   I = I';
   dpdt = -(J_p(2:n+1)-J_p(1:n))/dz+((g-param.m).*P)';

   dndt = (-alpha*(g.*P)+eta*alpha*param.m*(P))' - (J_n(2:n+1)-J_n(1:n))/dz;

   dydt = [dpdt'; dndt'];
   y = dydt;
end
