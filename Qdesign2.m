%% author: Matt Cordoba
% email: cordobamatt@gmail.com

%% Design a Q-design controller without an integrator and an integrator
%  for a fixed bw and zeta.  The solved solution is then auto-loaded by 
% Simulink for testing.
%Q-design for fixed bandwidth and zeta
bw = 1;%0.105;% part 1 - 0.105;
zeta = 0.7;% part 1 - 6;%0.7;
syms x;
a = expand((x^2 + 2*bw*zeta*x + bw^2)*(x+bw));
c = coeffs(a);
iT = -1/Ti;
beta = (((iT + bw)*(iT^2 + 2 * zeta * bw *iT + bw^2) / bw^3) - 1) / iT;

%%w/o integrator
Q_simple_num = expand(bw^2*(x)*(Ti*x+1));
Q_simple_den = expand(Ki*(x^2+2*bw*zeta*x + bw^2));
s_num = [0 double(coeffs(Q_simple_num))];
sn2 = s_num(2);
sn1 = s_num(1);
sn0 = 0;
s_den = double(coeffs(Q_simple_den));
sd2 = s_den(3);
sd1 = s_den(2);
sd0 = s_den(1);
%w integrator
Q_i_num = expand((bw^3*x*(Ti*x+1)*(beta*x+1)));
Q_i_den = expand(Ki*(x^2 + 2*bw*zeta*x + bw^2)*(x+bw));
i_num = [0 double(coeffs(Q_i_num))];
i_den = double(coeffs(Q_i_den));
n4 = i_num(3);
n3 = i_num(2);
n2 = i_num(1);
n1 = 0;
d1 = i_den(1);
d2 = i_den(2);
d3 = i_den(3);
d4 = i_den(4);
