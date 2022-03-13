A=[3 2 6;
    -4 -6 -3;
    -4 -2 -7];
B=[1;1;0];
C=[0,1,1];
D=0;
% Odchylenie standardowe
sigma=1;
% Model obi ektu w p r z e s t r z e n i s tanu
ob=ss(A,B,C,D) ;
% Wektor czasu
t(:,1)=0:0.1:50;
% Sygna³ wej sciowy
u=10*sin(t);
num=length(t);
% Odpowiedz nie zak³ócona
yn=lsim(ob,u,t);
% Odpowiedz zak³ócona
yz=yn+sigma*randn(num,1);
% Pozadane bieguny obserwatora Luenbergera
LambdaL=[-5-5i -8 -5+5i];
%LambdaL=[-4-4i -6 -4+4i];
% Macierz wzmocnien obserwatora Luenbergera
HL=place(A',C',LambdaL);
HL=HL';
% Obserwator Luenbergera w p r z e s t r z e n i stanu
AL=A-HL*C;
BL=[B-HL*D,HL];
CL=C;
DL=D;
obL=ss(AL,BL,CL,DL);
% Estymowana odpowiedz obiektu - obserwator Luenbergera
yL=lsim(obL,[u yz],t) ;
% Macierze kowariancji zak³ócen
Q=1e-4*eye(3,3);
%Q=eye(3,3);
%Q=[1 0 0;
    %0 1 0
    %0 0 1];
R=1;
% Macierz wzmocnien obserwatora Kalmana ? we r s ja 1
HK=lqr(A',C',Q,R);
HK=HK'
% Macierz wzmocnien obserwatora Kalmana ? we r s ja 2
%HK=l q e (A, eye ( 3 , 3 ) ,C,Q,R) ;
%HK
% Obserwator Kalmana w p r z e s t r z e n i s tanu
AK=A-HK*C;
BK=[B-HK*D,HK];
CK=C;
DK=D;
obK=ss(AK,BK,CK,DK);
% Estymowana odpowiedz obi ektu ? obserwator Kalmana
yK=lsim(obK,[u yz],t);
% Porównanie odpowiedzi
plot(t,yn,'k-',t,yz,'b.-',t,yL,'g--',t,yK,'r:','LineWidth',1.2) ;
legend('y - niezak³ócony','y - zak³ócony','y - Luenberger','y - Kalman') ;
xlabel('Czas [s]');
ylabel('Amplituda')