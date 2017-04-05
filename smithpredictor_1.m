% Process
clear all;
s = tf('s');
Km = 4;
Tm = 50;
Tdm = 15;
Ki = -0.075;
Ti = 140;
Tdi = 25;
F = 1/(20*s+1);
F.InputName = 'dy';
F.OutputName = 'dp';
P = Ki*exp(-Tdi*s)/ (s*(Ti*s+1));
P.InputName = 'u';
P.OutputName = 'y0';

% Prediction model
Gp = Ki/ (s*(Ti*s+1));
Gp.InputName = 'u';
Gp.OutputName = 'yp';

Dp = exp(-Tdi*s)
Dp.InputName = 'yp'; Dp.OutputName = 'y1';

% Overall plant
S1 = sumblk('ym = yp + dp');
S2 = sumblk('dy = y0 - y1');
Plant = connect(P,Gp,Dp,F,S1,S2,'u','ym');

C = pidtune(Plant,pidstd(1,1,1),0.0000001);
C.InputName = 'e';
C.OutputName = 'u';
C

Sum1 = sumblk('e = ysp - yp - dp');
Sum2 = sumblk('y = y0 + d');
Sum3 = sumblk('dy = y - y1');
T = connect(P,Gp,Dp,C,F,Sum1,Sum2,Sum3,{'ysp','d'},'y');
opt = stepDataOptions('StepAmplitude',110);
step(T,opt);
grid on;