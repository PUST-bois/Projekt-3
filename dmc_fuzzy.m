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

%% DMC
load('s.mat', 's');
Nr = 3;     %liczba regulatorow
% Funkcja przynaleznosci
regula = @(u, c, o) exp(-(u-c).^2/(o^2));  
w = zeros(Nr, 1);
c = [-0.5, 0, 0.5];             %(ZMIENIC)
o = [1, 1, 1];                  %(ZMIENIC)

s = [s, s, s];                  %(ZMIENIC)
D = [89, 89, 89];               %(ZMIENIC)
N = [80, 80, 80];               %(ZMIENIC)
Nu = [80, 80, 80];              %(ZMIENIC)
lambda = [1, 1, 1];             %(ZMIENIC)

%% Obliczanie parametrow offline DMC
ke = [];
ku = [];
for n = 1:Nr
    if N(n)>Nu(n) > length(s(:,n))
        temp = s(:,n);
        s(:,n) = ones(N(n)+Nu(n), 1);
        s(1:length(temp),n) = temp;
        s(length(temp)+1:end,n) = s(length(temp),n);
    end
    
    M = zeros(N(n), Nu(n));
    for i = 1:size(M, 1)
        for j = 1:size(M, 2)
            if i>=j
                M(i,j) = s(i-j+1,n);
            end
        end
    end
    Mp = zeros(N(n), D(n)-1);
    for i = 1:size(Mp, 1)
        for j = 1:size(Mp, 2)
            if i+j<D(n)
                Mp(i,j) = s(i+j,n) - s(j,n);
            else
                Mp(i, j) = s(D(n),n) - s(D(n),n);
            end
        end
    end
    K = ((M'*M + lambda(n)*eye(Nu(n)))^-1)*M';
    ke = [ke, sum(K(1,:))];
    temp = zeros(D(n)-1, 1);
    for x = 1:D(n)-1
        temp(x) = K(1,:) * Mp(:,x);
    end
    ku = [ku, temp];
end

%% Symulacja
u_max = 1;
u_min = -1;

sim_len = length(y_zad);
y = zeros(sim_len, 1);
u = zeros(sim_len, 1);
e = zeros(sim_len, 1);
du = zeros(sim_len, 1);
dmc_error = 0;

% Petla symulacji
for k=7:sim_len
    y(k) = symulacja_obiektu6y(u(k-5), u(k-6), y(k-1), y(k-2)); 
    e(k) = y_zad(k) - y(k);
    dmc_error = dmc_error + e(k)^2;
    
    suma =0;    %wazona suma sterowan
    for i = 1:Nr
        w(i) = regula(u(k-1), c(i), o(i));
        if w(i) == 0
            continue
        end
        suma_ku = 0;
        for n = 1:D(i)-1
            if k-n > 1
                suma_ku = suma_ku + ku(n, i) * du(k-1);
            end
        end
        duk = ke(i)*e(k) - suma_ku;
        suma = suma + duk*w(i);
    end
    du(k) = suma/sum(w);
    u(k) = u(k-1) + du(k);
    if u(k) >= u_max
        u(k) = u_max;
    elseif u(k) <= u_min
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
