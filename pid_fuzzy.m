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

%% PID
Nr = 3; % liczba lokalnych regulatorow (ZMIENIC PRZY ZMIANIE LICZBY REGULATOROW)
% Funkcje przynaleznosci kolejnych regulatorow
regula = @(u, c, o) exp(-(u-c).^2/(o^2));
w = zeros(Nr, 1);
c = [-0.5, 0, 0.5];             %(ZMIENIC)
o = [1, 1, 1];                  %(ZMIENIC)
% Parametry kolejnych regulatorow
K = [1, 1, 1];                  %(ZMIENIC)
Ti = [10, 10, 10];              %(ZMIENIC)
Td = [0.1, 0.1, 0.1];           %(ZMIENIC)
r0 = zeros(Nr, 1);     
r1 = zeros(Nr, 1);
r2 = zeros(Nr, 1);
T=1;
for i = 1:Nr
    r0(i) = K(i) * (1 + (T/(2*Ti(i))) + (Td(i)/T));
    r1(i) = K(i) * ((T/(2*Ti(i))) - (2*Td(i)/T) - 1);
    r2(i) = K(i)*Td(i)/T;
end

sim_len = length(y_zad);
y = zeros(sim_len, 1);
u = zeros(sim_len, 1);
du = zeros(sim_len, 1);
e = zeros(sim_len ,1);
pid_error = 0;

% Ograniczenia
u_max = 1;
u_min = -1;


for k=7:sim_len
    y(k) = symulacja_obiektu6y(u(k-5), u(k-6), y(k-1), y(k-2)); 
    e(k) = y_zad(k) - y(k);
    pid_error = pid_error + e(k)^2;
    
    % Obliczenie wag regulatorow
    suma = 0;       %wazona suma sterowan
    for i = 1:Nr
        w(i) = regula(u(k-1), c(i), o(i));
        if w(i) == 0
            continue
        end
        duk = r2(i)*e(k-2) + r1(i)*e(k-1) + r0(i)*e(k);
        suma = suma + duk*w(i);   
    end
    du(k) = suma/sum(w);
    u(k) = u(k-1) + du(k);
    
    if u(k)>=u_max
        u(k) = u_max;
    elseif u(k)<=u_min
        u(k) = u_min;
    end
end

% Zastosowana funkcja przynaleznosci
u_range = -1:0.1:1;
reg = zeros(length(u_range), Nr);

for i = 1:Nr
    reg(:, i) = regula(u_range, c(i), o(i));
end
figure;
plot(u_range, reg);

t = (0:sim_len-1)';
figure;
title("PID");
subplot(2,1,1);
plot(t, y, 'b');
hold on;
plot(t, y_zad, '--r');
xlabel('k');
ylabel('y');
hold off;
subplot(2,1,2);
plot(t, u, 'g');
xlabel('k');
ylabel('u');

figure;
plot(t, e);
title("error");

figure;
plot(t, du);
title("du");




