clear all;
% Inicjalizacja zmiennych i wektorow
sim_len = 100;
u_max = 1;
u_min = -1;
t = (0:sim_len-1);


% Wyznaczanie odpowiedzi skokowych (dla indeksu 11)

%% Skok 0-1 
u1 = ones(sim_len, 1);
u1(1:10) = 0;
y1 = zeros(sim_len, 1);

for k=7:sim_len
    y1(k) = symulacja_obiektu6y(u1(k-5), u1(k-6), y1(k-1), y1(k-2)); 
end

figure;
subplot(2,1,1);
plot(t, y1);
axis tight;
subplot(2,1,2);
plot(t,u1);
axis tight;

%% Odp skokowa dla globalnego DMC
s = y1(12:end);
save('s.mat', 's');

%% Skok 0-0.8
u2 = ones(sim_len, 1)*0.8;
u2(1:10) = 0;
y2 = zeros(sim_len, 1);

for k=7:sim_len
    y2(k) = symulacja_obiektu6y(u2(k-5), u2(k-6), y2(k-1), y2(k-2)); 
end

figure;
subplot(2,1,1);
plot(t, y2);
axis tight;
subplot(2,1,2);
plot(t,u2);
axis tight;

%% Skok 0-0.6
u3 = ones(sim_len, 1)*0.6;
u3(1:10) = 0;
y3 = zeros(sim_len, 1);

for k=7:sim_len
    y3(k) = symulacja_obiektu6y(u3(k-5), u3(k-6), y3(k-1), y3(k-2)); 
end

figure;
subplot(2,1,1);
plot(t, y3);
axis tight;
subplot(2,1,2);
plot(t,u3);
axis tight;

%% Skok 0-0.4
u4 = ones(sim_len, 1)*0.4;
u4(1:10) = 0;
y4 = zeros(sim_len, 1);

for k=7:sim_len
    y4(k) = symulacja_obiektu6y(u4(k-5), u4(k-6), y4(k-1), y4(k-2)); 
end

figure;
subplot(2,1,1);
plot(t, y4);
axis tight;
subplot(2,1,2);
plot(t,u4);
axis tight;

%% Skok 0-0.2
u5 = ones(sim_len, 1)*0.2;
u5(1:10) = 0;
y5 = zeros(sim_len, 1);

for k=7:sim_len
    y5(k) = symulacja_obiektu6y(u5(k-5), u5(k-6), y5(k-1), y5(k-2)); 
end

figure;
subplot(2,1,1);
plot(t, y5);
axis tight;
subplot(2,1,2);
plot(t,u5);
axis tight;

%% Skok 0-(-0.2)
u6 = ones(sim_len, 1)*-0.2;
u6(1:10) = 0;
y6 = zeros(sim_len, 1);

for k=7:sim_len
    y6(k) = symulacja_obiektu6y(u6(k-5), u6(k-6), y6(k-1), y6(k-2)); 
end

figure;
subplot(2,1,1);
plot(t, y6);
axis tight;
subplot(2,1,2);
plot(t,u6);
axis tight;

%% Skok 0-(-0.4)
u7 = ones(sim_len, 1)*-0.4;
u7(1:10) = 0;
y7 = zeros(sim_len, 1);

for k=7:sim_len
    y7(k) = symulacja_obiektu6y(u7(k-5), u7(k-6), y7(k-1), y7(k-2)); 
end

figure;
subplot(2,1,1);
plot(t, y7);
axis tight;
subplot(2,1,2);
plot(t,u7);
axis tight;

%% Skok 0-(-0.6)
u8 = ones(sim_len, 1)*-0.6;
u8(1:10) = 0;
y8 = zeros(sim_len, 1);

for k=7:sim_len
    y8(k) = symulacja_obiektu6y(u8(k-5), u8(k-6), y8(k-1), y8(k-2)); 
end

figure;
subplot(2,1,1);
plot(t, y8);
axis tight;
subplot(2,1,2);
plot(t,u8);
axis tight;

%% Skok 0-(-0.8)
u9 = ones(sim_len, 1)*-0.8;
u9(1:10) = 0;
y9 = zeros(sim_len, 1);

for k=7:sim_len
    y9(k) = symulacja_obiektu6y(u9(k-5), u9(k-6), y9(k-1), y9(k-2)); 
end

figure;
subplot(2,1,1);
plot(t, y9);
axis tight;
subplot(2,1,2);
plot(t,u9);
axis tight;

%% Skok 0-(-1)
u10 = ones(sim_len, 1)*-1;
u10(1:10) = 0;
y10 = zeros(sim_len, 1);

for k=7:sim_len
    y10(k) = symulacja_obiektu6y(u10(k-5), u10(k-6), y9(k-1), y10(k-2)); 
end

figure;
subplot(2,1,1);
plot(t, y10);
axis tight;
subplot(2,1,2);
plot(t,u10);
axis tight;

t0 = 0:sim_len-11;
figure;
subplot(2,1,1);
plot(t0,[y1(11:end),y2(11:end),y3(11:end),y4(11:end),y5(11:end)])
subplot(2,1,2);
plot(t0,[y6(11:end),y7(11:end),y8(11:end),y9(11:end),y10(11:end)])

T = table(t0',y1(11:end),y2(11:end),y3(11:end),y4(11:end),y5(11:end),...
y6(11:end),y7(11:end),y8(11:end),y9(11:end),y10(11:end));

writetable(T, 'wykresy/dane/zad2_odpskok', 'WriteVariableNames',false);

%% Charakterystyka statyczna

u = [-1:0.01:1];
y_stat_out = zeros(length(u), 1);
for i = 1:length(u)
    y_stat = zeros(sim_len, 1);
    for k=3:sim_len
        y_stat(k) = symulacja_obiektu6y(u(i), u(i), y_stat(k-1), y_stat(k-2)); 
    end
    y_stat_out(i) = y_stat(end);
end

figure;
plot(u, y_stat_out);
title("Charakterystyka statyczna");
ylabel("y");
xlabel("u");

T = table(u',y_stat_out);
writetable(T, 'wykresy/dane/zad2_char_stat', 'WriteVariableNames', false);





