%% author: Matt Cordoba
% email: cordobamatt@gmail.com

%% Design a Q-design controller without an integrator and an integrator
%  for a fixed bw and zeta.  The solved solution is then auto-loaded by 
% Simulink for testing.
%Q-design for fixed bandwidth and zeta
bw = 0.09;%0.089;%1/100;%;0.105;%10;%%0.00803;
zeta = 6;%6;%0.7;%80;%0.7;
syms x;
a = expand((x^2 + 2*bw*zeta*x + bw^2)*(x+bw));
c = coeffs(a);
beta = c(2) / bw^3;

%%w/o integrator
Q_simple_num = expand(bw^2*(x)*(Ti*x+1));
Q_simple_den = expand(Ki*(x^2+2*bw*zeta*x + bw^2));
s_num = [0 double(coeffs(Q_simple_num))]; %load by simulink
sn2 = s_num(2);
sn1 = s_num(1);
sn0 = 0;
s_den = double(coeffs(Q_simple_den)); %load by simulink
sd2 = s_den(3);
sd1 = s_den(2);
sd0 = s_den(1);

%with integrator term forced in Q-design
Q_i_num = expand(((bw^3/Ki)*x*(Ti*x+1)*(beta*x+1)));
Q_i_den = expand((x^2 + 2*bw*zeta*x + bw^2)*(x+bw));
i_num = double(coeffs(Q_i_num));
i_den = double(coeffs(Q_i_den));
n4 = i_num(3);
n3 = i_num(2);
n2 = i_num(1);
n1 = 0;
d1 = i_den(1);
d2 = i_den(2);
d3 = i_den(3);
d4 = i_den(4);
%load vars via simulink

%synthesize a simple controller C, for the simple Q (w/o integrator)
C_simple_num = expand(bw^2*(Ti*x+1));
C_simple_den = expand(Ki*(x+2*bw*zeta));
s_num_c = double(coeffs(C_simple_num)); %load by simulink
s_den_c = double(coeffs(C_simple_den)); %load by simulink