function [I,g] = LightFunction_2(P, param) 
    z = param.z;
    dz = param.dz;
    kp = param.kp;
    kw = param.kw;
    I0 = param.I0;

    Q = kp*dz*(cumsum(P)-P/2);            %Cumsum goes to the last value of P, so distract half of P(i), to have the right expression (see notes).
    grid = param.dz*0.5:param.dz:param.z-param.dz*0.5;


    I = I0.*exp(-kw.*grid-Q);
  
end