clear all;
%define params for 441 project
s = tf('s');
Km = 4;
Tm = 50;
Tdm = 15;
Ki = -0.075;
Ti = 140;
Tdi = 25;
G1 = Km*exp(-Tdm*s) / (s*(Tm*s+1)); %disturbances
G2 = Ki/ (s*(Ti*s+1));%*exp(-Tdi*s) / (s*(Ti*s+1)); %input

%solved params via Q-design
%P = G2;
%close all;
%P = G2;
%P.InputName = 'u';
%P.OutputName = 'y';
%step(P), grid on
%P_K = -1.33e5;
%I = -555.6;
%D = -1.317e4;
%C = pidtune(P,pidstd(1,1,1),10);% pid(P_K,I,D);%pidtune(P,pidstd(1,1,1),10);%pid(P_K,I,D);

%Tpi = feedback([P*C,1],1,1,1);  % closed-loop model [ysp;d]->y
%Tpi.InputName = {'ysp' 'd'};
%opt = stepDataOptions('StepAmplitude',110);
%step(Tpi,opt), grid on
%H = 1;
%Kp = 1;
%Ki = 0;
%Kd = 0;
%C = pid(Kp,Ki,Kd);
%input = [zeros(7*60,1); 
%    25/10*ones(10,1);
%    zeros(6*60 - 10,1);
%    40/15*ones(15,1);
%    zeros(6*60 - 15,1);
%    60/20*ones(20,1);
%    zeros(5*60 - 20,1)];
%input = [zeros(7*60,1); 
%    25/10*ones(10,1);
%    zeros(6*60 - 10,1);
%    25/10*ones(10,1);
%    zeros(6*60 - 10,1);
%    25/10*ones(10,1);
%    zeros(5*60 - 10,1)]

%time = 0:(60*24 - 1);
%time = 0:(length(input) - 1);
%input_ts = timeseries(input,time);
%input_ts.TimeInfo.Units = 'minutes'
%plot(input_ts)