
% Y = [-3.4; 0.85]
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

% K=0.1, Td=0.1, Ti=4 - całkiem dobre globalne parametry
pid(0.1, 0.1, 4, y_zad, 1);

% D=89
dmc(89, 10, 10, 1, y_zad, 1);
