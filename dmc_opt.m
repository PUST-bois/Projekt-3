function dmc_error = dmc_opt(params)

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

D = params(1);
N = params(2);
Nu = params(3);
lambda = params(4);
dmc_error = dmc(D, N, Nu, lambda, y_zad, 0);