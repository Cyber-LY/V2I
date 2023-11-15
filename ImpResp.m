close all 
clear all 
clc;
tic;
path='C:\Users\Administrator.LAPTOP-NN75G73L\Desktop\Advanced Electronics Measuement\uwb\uwb\';
%---- h11

    %     Normalization of the power with all the power at 1 meter;
for kath=1:1;
   
    LNorm=[];
    
    for hugh=1:1:4;
     load(strcat(path,'mes',num2str(kath),num2str(hugh),'.mat'));
%      H=matrice;
     Freq3=matrice (:,1);    
     H3=matrice (:,2); 
     LNorm=[LNorm,H3]; 
    end
end    
    
 BCMHz=[];
%for dist=2:26; 
for dist=11;
    BC=[];
    dspread=[];
%     BCMHz=[];
    dspread=[];
    L=[];
    AvP=[];
    Pfinal=[];
    for xpos=1:1:4
     load(strcat(path,'mes',num2str(dist),num2str(xpos),'.mat'));
%      H=matrice;
     Freq=matrice (:,1);    
     H=matrice (:,2); 
     L=[L,H];

    end
    
       PuiNorm= mean(LNorm,2) ;
  AvP = mean(L,2) ;
%   Lfinal=[Freq,L];%     Matrice fréquence et Toutes les Puissances ;
 Pfinal = [Freq,AvP];%     Matrice fréquence et Puissance Moyenne;
%   Freq=Pfinal (:,1);    
  H = Pfinal (:,2); 
  
  PR_h11 = bsxfun(@rdivide,L(:,1),LNorm(:,1)); 
  PR_h12 = bsxfun(@rdivide,L(:,2),LNorm(:,2)); 
  PR_h21 = bsxfun(@rdivide,L(:,3),LNorm(:,3)); 
  PR_h22 = bsxfun(@rdivide,L(:,4),LNorm(:,4)); 
  
%meli = PR;

  Nf = length (Freq);
  fstart = Freq(1,1);
  fstop = Freq(Nf,1);
  Fs=(fstop-fstart)/(Nf-1); % Fs représente la séparation fréquentielle entre 2
% % % échantillons
  tau = (0:1:Nf-1)/(Fs*Nf);

  h11 = ifft(PR_h11) ;
  h12 = ifft(PR_h12) ;
  h21 = ifft(PR_h21) ;
  h22 = ifft(PR_h22) ;

  hh11 = PR_h11.*hamming(Nf);
  hh12 = PR_h12.*hamming(Nf);
  hh21 = PR_h21.*hamming(Nf);
  hh22 = PR_h22.*hamming(Nf);
  Imp_h11 = ifft(hh11) ;
  Imp_h12 = ifft(hh12) ;
  Imp_h21 = ifft(hh21) ;
  Imp_h22 = ifft(hh22) ;
  
  %%%%%%%%%%%  centralicer les colums !!
[M,N]=size(H) ;
Cor=[] ;
for n=1:1:N
    denominateur1=+mean(abs(H(:,n).^2)) ;
    for m=1:1:N
        numerateur=mean(H(:,n).*conj(H(:,m)));
        denominateur2= +mean(abs(H(:,m).^2));      
        Cor(n,m)=abs((numerateur/(sqrt(denominateur1*denominateur2))));
    end
end

temp=tril(Cor,-1) ;
Cor=temp(temp>0)  ;


figure(1);
    subplot(2,2,1);plot(tau.*1e9,20*log10(abs(h11)),'--k'); grid on; 
    xlabel('Delay (ns)','fontsize',16);ylabel('Impulse Response(dB)','fontsize',16);legend ('ImpRsp h11');
    xlim([0 2000]);set(gca ,'fontsize',16)
    subplot(2,2,2);plot(tau.*1e9,20*log10(abs(h12)),'--k'); grid on;
    xlabel('Delay (ns)','fontsize',16);ylabel('Impulse Response(dB)','fontsize',16);legend ('ImpRsp h12');
    xlim([0 2000]);set(gca ,'fontsize',16)
%     subplot(2,2,3);plot(tau.*1e9,20*log10(abs(h21)),'k'); grid on;
%     xlabel('Delay (ns)','fontsize',16);ylabel('Impulse Response(dB)','fontsize',16);legend ('ImpRsp h21');
%     xlim([0 2000]);set(gca ,'fontsize',16)
%     subplot(2,2,4);plot(tau.*1e9,20*log10(abs(h22)),'k'); grid on;
%     xlabel('Delay (ns)','fontsize',16);ylabel('Impulse Response(dB)','fontsize',16);legend ('ImpRsp h22');
%     xlim([0 2000]);set(gca ,'fontsize',16)
%break;
% figure(2);
%     plot(tau,20*log10(abs(h11)),'b'); grid on; hold on
%     plot(tau,20*log10(abs(h12)),'r'); grid on; 
%     plot(tau,20*log10(abs(h21)),'g'); grid on; 
%     plot(tau,20*log10(abs(h22)),'y'); grid on
%   %title( 'LOS d=20')
% xlabel('Delay (ns)');
% ylabel('Complexe Impulse Response(dB)');
% xlim([0*1e-6 1*1e-6])
%  
% figure(3)
%   plot(tau,20*log10(abs(Imp_h11)),'b'); grid on; hold on
%   plot(tau,20*log10(abs(Imp_h12)),'r'); grid on
%   plot(tau,20*log10(abs(Imp_h21)),'g'); grid on
%   plot(tau,20*log10(abs(Imp_h22)),'y'); grid on
%   %title( 'LOS d=20')
%   xlabel('Delay (ns)')
%   ylabel('Complexe Impulse Response with Hamming(dB)')
%   %xlim([0*1e-6 1*1e-6])
  
end   

for dist=11;

    L=[];
    AvP=[];
    Pfinal=[];
    for xpos=1:1:4
     load(strcat(path,'mes',num2str(dist),num2str(xpos),'.mat'));
%      H=matrice;
     Freq=matrice (:,1);    
     H=matrice (:,2); 
     L=[L,H];

    end
    
       PuiNorm= mean(LNorm,2) ;
  AvP = mean(L,2) ;
%   Lfinal=[Freq,L];%     Matrice fréquence et Toutes les Puissances ;
 Pfinal = [Freq,AvP];%     Matrice fréquence et Puissance Moyenne;
%   Freq=Pfinal (:,1);    
  H = Pfinal (:,2); 
  
  PR_h11 = bsxfun(@rdivide,L(:,1),LNorm(:,1)); 
  PR_h12 = bsxfun(@rdivide,L(:,2),LNorm(:,2)); 
  PR_h21 = bsxfun(@rdivide,L(:,3),LNorm(:,3)); 
  PR_h22 = bsxfun(@rdivide,L(:,4),LNorm(:,4)); 
  
%meli = PR;

  Nf = length (Freq);
  fstart = Freq(1,1);
  fstop = Freq(Nf,1);
  Fs=(fstop-fstart)/(Nf-1); % Fs représente la séparation fréquentielle entre 2
% % % échantillons
  tau = (0:1:Nf-1)/(Fs*Nf);

  h11 = ifft(PR_h11) ;
  h12 = ifft(PR_h12) ;
  h21 = ifft(PR_h21) ;
  h22 = ifft(PR_h22) ;

  hh11 = PR_h11.*hamming(Nf);
  hh12 = PR_h12.*hamming(Nf);
  hh21 = PR_h21.*hamming(Nf);
  hh22 = PR_h22.*hamming(Nf);
  Imp_h11 = ifft(hh11) ;
  Imp_h12 = ifft(hh12) ;
  Imp_h21 = ifft(hh21) ;
  Imp_h22 = ifft(hh22) ;

figure(1);

    subplot(2,2,3);plot(tau.*1e9,20*log10(abs(h21)),'--k'); grid on;
    xlabel('Delay (ns)','fontsize',16);ylabel('Impulse Response(dB)','fontsize',16);legend ('ImpRsp h21');
    xlim([0 2000]);set(gca ,'fontsize',16)
    subplot(2,2,4);plot(tau.*1e9,20*log10(abs(h22)),'--k'); grid on;
    xlabel('Delay (ns)','fontsize',16);ylabel('Impulse Response(dB)','fontsize',16);legend ('ImpRsp h22');
    xlim([0 2000]);set(gca ,'fontsize',16)
end

