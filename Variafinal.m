close all 
clear all 
clc;
tic;
path='C:\Users\Administrator.LAPTOP-NN75G73L\Desktop\Advanced Electronics Measuement\uwb\uwb\';
%---- h11
tic;
% n=input('Coefficient du Path Loss: ');
% Po=input('Reference Path Loss(en dB): ');
% load(strcat('Puissance','.mat'));
% load(strcat('Shadow','.mat'));

nMiMo=input('Coefficient du Path Loss Mimo: ');
PoMiMo=input('Reference Path Loss Mimo(en dB): ');
load(strcat(path, 'PuissanceMimo','.mat'));
load(strcat(path, 'ShadowMiMo','.mat'));



% Dist=Shadow(1,:);    
% DistdB=Shadow(2,:); 
% PdB=Shadow(3,:);
% Pathloss=-n*DistdB+Po;
% Erreur=PdB-Pathloss;
% Erfinal=Erreur';

DistMiMo=ShadowMiMo(1,:);    
DistdBMiMo=ShadowMiMo(2,:); 
PdBMiMo=ShadowMiMo(3,:);
PathlossMiMo=-nMiMo*DistdBMiMo+PoMiMo;
ErreurMiMo=PdBMiMo-PathlossMiMo;
ErfinalMiMo=ErreurMiMo';


figure('name','Path Loss Comparison') ; hold on ; box on ; 
% set(gca,'ytick',0:3:10)
% plot(DistdB,PdB,'g-s','linewidth',1) ; 
% % plot(DistdB,PdB,'g','linewidth',1) ; 
% plot(DistdB,Pathloss,'k-*','linewidth',1) ;

plot(DistdBMiMo,PdBMiMo,'r-s','linewidth',1) ; 
% plot(DistdB,PdB,'g','linewidth',1) ; 
plot(DistdBMiMo,PathlossMiMo,'k-*','linewidth',1) ;

xlabel('Tx-Rx distance in dB','fontweight','bold','fontsize',12,'linewidth',3) ;
ylabel('Path Loss (dB)','interpreter','latex','fontweight','bold','fontsize',12,'linewidth',3)
legend('Measurement MIMO LOS','Simulation MIMO LOS','location','best')



% figure(2)
% cdfplot(PdB);
% title( 'Path Loss for some distance SISO')
% xlabel('Distance in dB')
% ylabel('Amplitude in(dB)')
% 
% figure(3)
% cdfplot(Erreur);
% title( 'CDF of Shadow fading SISO')
% xlabel('Shadow fading SISO LOS (dB)')
% ylabel('Prob')
% Err=fitdist(Erfinal, 'normal') 

figure(2)
cdfplot(PdBMiMo);
title( 'Path Loss for some distance MIMO')
xlabel('Distance in dB')
ylabel('Amplitude in(dB)')

figure(3)
cdfplot(ErreurMiMo);
title( 'CDF of Shadow fading')
xlabel('Shadow fading MIMO LOS (dB)')
ylabel('Prob')
Err=fitdist(ErfinalMiMo, 'normal') 
toc