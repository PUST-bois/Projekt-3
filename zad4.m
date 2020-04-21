%% Y zadane
y_zad = zeros(1000, 1);
y_zad(101:200) = -1;
y_zad(201:300) = -2;
y_zad(301:400) = -0.7;
y_zad(401:500) = 0.08;
y_zad(501:600) = -1.3;
y_zad(601:700) = -2.5;
y_zad(701:800) = -0.5;
y_zad(801:900) = -3.4;
y_zad(901:1000) = 0;

%% Optymalizacja PID
% Fmincon
% wartosci poczatkowe
x0 = [0.5, 50, 1];
A = [];
b = [];
Aeq = [];
beq = [];
lb = [0, 0, 0];
ub = [];
params = fmincon(@pid_opt, x0, A, b, Aeq, beq, lb, ub);
K = params(1);  % 0.3747
Ti = params(2); % 10.1761
Td = params(3); % 0.3185
e = pid(K, Td, Ti, y_zad, 1);
disp(e)
%% GA
nvars = 3;
A = [];
b = [];
Aeq = [];
beq = [];
lb = [0, 0, 0];
ub = [];
nonlcon = [];
params = ga(@pid_opt, nvars, A, b, Aeq, beq, lb, ub);
% 0.3747   10.1768    0.3184
K = params(1);
Ti = params(2);
Td = params(3);
e = pid(K, Td, Ti, y_zad, 1);
disp(e)
%% Optymalizacja DMC
% GA (fmincon nie ma mozliwosci zalozenia calkowitych liczb)
nvars = 4;
A = [];
b = [];
Aeq = [];
beq = [];
lb = [1, 1, 1, 0];
ub = [89, 89, 89];
nonlcon = [];
IntCon = [1, 2, 3]; % ograniczenie do calkowitych
params = ga(@dmc_opt, nvars, A, b, Aeq, beq, lb, ub, nonlcon, IntCon);

D = params(1);
N = params(2);
Nu = params(3);
lambda = params(4);
e = dmc(D, N, Nu, lambda, y_zad, 1);
disp(e)