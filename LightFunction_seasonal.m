function [I,g] = LightFunction(Y, param,time) 
    z = param.z;
    dz = param.dz;
    kp = param.kp;
    kw = param.kw;
    I0 = param.I0;
    
    P = Y(1:param.n);
    N = Y(param.n+1:2*param.n);

    Q = kp*dz*(cumsum(P)-P/2);                                             %Cumsum goes to the last value of P, so distract half of P(i), to have the right expression (see notes).
    grid = param.dz*0.5:param.dz:param.z-param.dz*0.5;
    
    I0_variation = 1/2*param.I0*sin((2*pi)/365.*time)+param.I0;

    I = I0_variation.*exp(-kw.*grid-Q');
    I = I';
    g=param.gmax.*min(I./(I+param.H_I), N./(N+param.H_N));
    
end
