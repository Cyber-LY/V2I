 
clear all 
clc;
tic;
path='C:\Users\Administrator.LAPTOP-NN75G73L\Desktop\Advanced Electronics Measuement\uwb\uwb\';
%---- h11
tic;
Pfinal=[];
Pdist=[];
Distmeter=[];
for dist=1:11;
    BC=[];
    dspread=[];
%     BCMHz=[];
    dspread=[];
    L=[];
    AvP=[];
    
    for xpos=1:1:4;
    load(strcat(path,'mes',num2str(dist),num2str(xpos),'.mat'));
%      H=matrice;
     Freq=matrice (:,1);    
     H=matrice (:,2); 
     L=[L,H];
    end
    
  Ds=abs(L).^2;     
  AvP=mean(Ds,2) ;
  Power=mean(AvP);
  PLdb=10*log10(Power);
  Distance=10*log10(dist);
%   Lfinal=[Freq,L];%     Matrice fréquence et Toutes les Puissances ;
%   Pfinal=[Freq,Ds];%     Matrice fréquence et Puissance Moyenne;
  Power1(dist,:)=Power;
  Power2(:,dist)=Power;
  Pfinal=[Pfinal,PLdb];

   
  Pdist=[Pdist,Distance];
  Distmeter=[Distmeter,dist];
end

Pfinal=Pfinal-Pfinal(1);

for i=1:length(Pfinal)-1
    PFinal(i)=Pfinal(i+1);
end 
for i=1:length(Pdist)-1
    PDist(i)=Pdist(i);
end 
for i=1:length(PDist)
    PDistm(i)=10^(PDist(i)/10)
end

figure(1); hold on
plot(PDist,PFinal,'r')
title( 'Path Loss for some distance')
xlabel('Distance in dB')
ylabel('Amplitude in(dB)')
figure(2)
semilogx(PDistm,PFinal,'k'); hold on

xlabel('Distance Tx-Rx (m)')
ylabel('Averaged Path Loss (dB)')



% Power=strcat('Power',num2str(dist),num2str(xpos)) ;
PuissanceMiMo= [] ;
ShadowMiMo= [] ;
ShadowMiMo(1,:)=PDistm;
ShadowMiMo(2,:)=PDist;
ShadowMiMo(3,:)=PFinal;
strcat(path,'ShadowMiMo');
save(strcat(path,'ShadowMiMo'),'ShadowMiMo');



PuissanceMiMo(:,1)=Distmeter;
PuissanceMiMo(:,2)=Pdist;
PuissanceMiMo(:,3)=Pfinal;
strcat(path,'PuissanceMiMo');
save(strcat(path,'PuissanceMiMo'),'PuissanceMiMo');


toc;





























