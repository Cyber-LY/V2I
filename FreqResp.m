close all 
clear all 
clc;
tic;
path='C:\Users\Administrator.LAPTOP-NN75G73L\Desktop\Advanced Electronics Measuement\uwb\uwb\';
%---- h11
tic;

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
for dist=1:11;

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
    
  MagL = abs(mean(L,2));
  Lfinal=[Freq,L];%     Matrice fréquence et Toutes les Puissances ;
  HH = Lfinal(1:6401,:);
  
% Pfinal = [Freq,AvP];%     Matrice fréquence et Puissance Moyenne;
%   Freq=Pfinal (:,1);    
  %H = Pfinal (:,2); 
  
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
  tau  = (0:1:Nf-1)/(Fs*Nf);
  %Freq =(0:200./(6401-1):1000);
  Freq = Lfinal(:,1);
  
  h11 = ifft(PR_h11) ;
  h12 = ifft(PR_h12) ;
  h21 = ifft(PR_h21) ;
  h22 = ifft(PR_h22) ;
  
  freq_Imp1 = fft(h11);
  freq_Imp2 = fft(h12);
  freq_Imp3 = fft(h21);
  freq_Imp4 = fft(h22);
  freq_Imp = [freq_Imp1,freq_Imp2,freq_Imp3,freq_Imp4];
  freq_impp = mean(freq_Imp,2);
%   freq_Imp1 = freq_Imp1(1921:3201);
%   freq_Imp2 = freq_Imp2(1921:3201);
%   freq_Imp3 = freq_Imp3(1921:3201);
%   freq_Imp4 = freq_Imp4(1921:3201);
  
  
  hh11 = PR_h11.*hamming(Nf);
  hh12 = PR_h12.*hamming(Nf);
  hh21 = PR_h21.*hamming(Nf);
  hh22 = PR_h22.*hamming(Nf);
  Imp_h11 = ifft(hh11) ;
  Imp_h12 = ifft(hh12) ;
  Imp_h21 = ifft(hh21) ;
  Imp_h22 = ifft(hh22) ;
% 
figure(1);
subplot(2,2,1);plot(tau,20*log10(abs(h11)),'b'); grid on; 
subplot(2,2,2);plot(tau,20*log10(abs(h12)),'g'); grid on
subplot(2,2,3);plot(tau,20*log10(abs(h21)),'r'); grid on;
subplot(2,2,4);plot(tau,20*log10(abs(h22)),'y'); grid on;
%   %title( 'LOS d=20')
% xlabel('Delay (ns)','fontsize',14);
% ylabel('Complexe Impulse Response(dB)','fontsize',14);
% xlim([0*1e-6 5*1e-6])

figure(2);
    plot(tau,20*log10(abs(h11)),'b'); grid on; hold on
    plot(tau,20*log10(abs(h12)),'r'); grid on; 
    plot(tau,20*log10(abs(h21)),'g'); grid on; 
    plot(tau,20*log10(abs(h22)),'y'); grid on
  %title( 'LOS d=20')
xlabel('Delay (ns)');
ylabel('Impulse Response(dB)');
xlim([0*1e-6 1*1e-6])
 
figure(3)
  plot(tau,20*log10(abs(Imp_h11)),'b'); grid on; hold on
  plot(tau,20*log10(abs(Imp_h12)),'r'); grid on
  plot(tau,20*log10(abs(Imp_h21)),'g'); grid on
  plot(tau,20*log10(abs(Imp_h22)),'y'); grid on
  %title( 'LOS d=20')
  xlabel('Delay (ns)')
  ylabel('Impulse Response with Hamming(dB)')
  xlim([0*1e-6 1*1e-6])
  
figure(4);
%     plot(20*log10(abs(freq_Imp1)),'b'); grid on; hold on
%     plot(20*log10(abs(freq_Imp2)),'r'); grid on; 
%     plot(20*log10(abs(freq_Imp3)),'g'); grid on; 
%     plot(20*log10(abs(freq_Imp4)),'y'); grid on
    plot(Freq./1e9,20*log10(abs(freq_impp)),'k'); grid on
    
  %title( 'LOS d=20')
xlabel('Frequency (GHz)','fontsize',16);
ylabel('Frequency Response(dB)','fontsize',16);
set(gca ,'fontsize',16)
%xlim([0*1e-6 1*1e-6])


end   


toc;