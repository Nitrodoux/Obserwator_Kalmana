%% rysowanie 5 projekt
figure(20)
plot(odp_bez_komp)
hold on
title('Odpowiedü uk≥adu bez kompensacji')
xlabel('Czas [s]')
ylabel('Amplituda')
hold on
legend('Q1','Q2','Q3','Q4','Q5')
figure(21)
plot(odp_z_komp)
hold on
title('Odpowiedü uk≥adu z kompensacjπ')
xlabel('Czas [s]')
ylabel('Amplituda')
hold on
legend('Q1','Q2','Q3','Q4','Q5')
%%
figure(22)
plot(odp_z_reg_calk4)
hold on
title('Odpowiedü uk≥adu z regulatorem ca≥kujacym')
xlabel('Czas [s]')
ylabel('Amplituda')
hold on
legend('Q1','Q2','Q3','Q4','Q5')
%%
figure(23)
subplot(3,1,1)
plot(stanu_bez_komp)
hold on
title('Zmienne stanu uk≥adu bez kompensacji')
xlabel('Czas [s]')
ylabel('Amplituda')
hold on
legend('x1', 'x2', 'x3')

subplot(3,1,2)
plot(stanu_z_komp)
hold on
title('Zmienne stanu uk≥adu z kompensacjπ')
xlabel('Czas [s]')
ylabel('Amplituda')
hold on
legend('x1', 'x2', 'x3')

subplot(3,1,3)
plot(stanu_reg_Ki)
hold on
title('Zmienne stanu uk≥adu z regulatorem ca≥kujacym')
xlabel('Czas [s]')
ylabel('Amplituda')
hold on
legend('x1', 'x2', 'x3')

%%
figure(24)
subplot(2,1,1)
plot(zm_st_ob)
hold on
title('Zmienne stanu rzeczywiste')
xlabel('Czas [s]')
ylabel('Amplituda')
hold on
legend('x1', 'x2', 'x3')

subplot(2,1,2)
plot(zm_st_Kc)
hold on
title('Zmienne stanu Kalman')
xlabel('Czas [s]')
ylabel('Amplituda')
hold on
legend('x1', 'x2', 'x3')

subplot(2,1,3)
plot(zm_st_Lc)
hold on
title('Zmienne stanu Leunberger')
xlabel('Czas [s]')
ylabel('Amplituda')
hold on
legend('x1', 'x2', 'x3')