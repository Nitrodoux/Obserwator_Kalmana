clc; close all;
%% d)
A=[3 2 6;
    -4 -6 -3;
    -4 -2 -7];
B=[1;1;0];
C=[0,1,1];
D=0;

G=ss(A,B,C,D);
%% sterowalnosc, obserwalnosc i pzmap

Qs=ctrb(G);
rzad_Qs=rank(Qs);

Qo=obsv(G);
rzad_Qo=rank(Qo);

figure
step(G)
xlabel('Czas [s]')
ylabel('')
title('')
grid on;
figure
impulse(G)
xlabel('Czas [s]')
ylabel('')
title('')
grid on;
figure
pzmap(G)
xlabel('Wartoœci rzeczywiste')
ylabel('Wartoœci urojone')
title('')

%% LQR regulator
Q=[100 0 0;
   0 9 0;
   0 0 3];
R=1;
[K,P,e]=lqr(A,B,Q,R);
Ac=(A-B*K);
Bc=B;
Cc=C;
Dc=D;
ob_cl=ss(Ac,Bc,Cc,Dc);

[V,d]=eig(Ac);
%% prekompensator
h1=[A B;C D];
h2=[0;0;0;1];
h1_1=inv(h1);
Npom=h1_1*h2;
Nx=Npom(1:3,:);
Nu=Npom(4,:);
N=K*Nx+Nu;
Bz=B*N;
G_cl=ss(Ac, Bz, C, D);

%%
Apom=A;
Apom(:,4)=0;
Cpom=-C;
Cpom(1,4)=0;
A1=[Apom;Cpom];
B1=[B;-D];
Qe=[1 0 0 0;
    0 1 0 0;
    0 0 1 0;
    0 0 0 1];
Re=1;
K1=lqr(A1,B1,Qe,Re);
Ki=K1(1,4);
KK=K1(1,1:3);

close all;
%% obserwator Kalmana
Qobs=10^-4*[1 0 0;
   0 1 0;
   0 0 2];
Robs=1;

HK=lqr(A',C',Qobs,Robs);
HK=HK';

AK=A-HK*C;
BK=[B-HK*D,HK];
CK=C;
DK=D;
[~,dK]=eig(AK);

obK=ss(AK,BK,CK,DK);
[~,dK1]=eig(AK);
%% Obserwator Luenbergera
LambdaL=[-1-1i -3 -1+1i];
%LambdaL=[?1 ?2 ?3];
% Macierz wzmocnien obserwatora Luenbergera
HL=place(A',C',LambdaL);
HL=HL';
% Obserwator Luenbergera w p r z e s t r z e n i stanu
AL=A-HL*C;
BL=[B-HL*D,HL];
CL=C;
DL=D;
obL=ss(AL,BL,CL,DL);
[~,dL]=eig(AL);