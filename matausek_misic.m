phi =   1.117; %rad
tau = Tdi;
alpha = 0.5;
Td = alpha * tau;
Tf = Td / 10;
Kp = -0.1;%-0.1;
Tr = Ti;
Kr = -0.1;%1 / (Kp*Tr);
K0 = ((pi/2) - phi) / (Kp*tau*sqrt((1-alpha)^2 + (pi/2 - phi)^2*alpha^2));
syms x;
F_n = expand(K0*(Td*x+1));
F_d = expand(Tf*x+1);
F_num = double(coeffs(F_n));
F_den = double(coeffs(F_d));