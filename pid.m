function pid_error = pid(K, Td, Ti, y_zad, wykres)
T=1;
r0 = K * (1 + (T/(2*Ti)) + (Td/T));
r1 = K * ((T/(2*Ti)) - (2*Td/T) - 1);
r2 = K*Td/T;

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
    du(k) = r2*e(k-2) + r1*e(k-1) + r0*e(k);
    u(k) = u(k-1) + du(k);
    
    if u(k)>=u_max
        u(k) = u_max;
    elseif u(k)<=u_min
        u(k) = u_min;
    end
end

if wykres >0
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
end