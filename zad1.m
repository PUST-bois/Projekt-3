% Inicjalizacja zmiennych i wektorow
sim_len = 100;
y = zeros(sim_len, 1);
u = zeros(sim_len, 1);
u_max = 1;
u_min = -1;

for k=7:sim_len
    y(k) = symulacja_obiektu6y(u(k-5), u(k-6), y(k-1), y(k-2)); 
    if abs(y) > eps(0)  % Sprawdzenie punktu pracy
        disp('Wyjscie rozne od zera');  
    end
end
figure;
plot(y);

% Rozne poczatkowe wartosci y

y1 = ones(sim_len, 1);

for k=7:sim_len
    y1(k) = symulacja_obiektu6y(u(k-5), u(k-6), y1(k-1), y1(k-2)); 
end

figure;
plot(y1, 'r');
hold on;

y2 = ones(sim_len, 1) .* 0.5;

for k=7:sim_len
    y2(k) = symulacja_obiektu6y(u(k-5), u(k-6), y2(k-1), y2(k-2)); 
end
plot(y2, 'b');


y3 = ones(sim_len, 1) .* -0.5;

for k=7:sim_len
    y3(k) = symulacja_obiektu6y(u(k-5), u(k-6), y3(k-1), y3(k-2)); 
end

plot(y3, 'g');
t = (0:sim_len-1)';
T = table(t, y, y1, y2, y3);
writetable(T, 'wykresy/dane/zad1', 'WriteVariableNames',false);
   