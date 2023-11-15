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
%   Lfinal=[Freq,L];%     Matrice fr閝uence et Toutes les Puissances ;
 Pfinal = [Freq,AvP];%     Matrice fr閝uence et Puissance Moyenne;
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
  Fs=(fstop-fstart)/(Nf-1); % Fs repr閟ente la s閜aration fr閝uentielle entre 2
% % % 閏hantillons
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
  Imp_h11=Imp_h11/max(Imp_h11) ;
  Imp_h12=Imp_h12/max(Imp_h12) ;
  Imp_h21=Imp_h21/max(Imp_h21) ;
  Imp_h22=Imp_h22/max(Imp_h22) ;
  
  Seuil=-20;
  Level= 10^(Seuil/20);
  Imp_h11(Imp_h11<Level)=0 ;             %%%  <=> � 20 db d'attenuation         
  Imp_h11=Imp_h11(:); 
  Imp_h12(Imp_h12<Level)=0 ;             %%%  <=> � 20 db d'attenuation         
  Imp_h12=Imp_h12(:);
  Imp_h21(Imp_h21<Level)=0 ;             %%%  <=> � 20 db d'attenuation         
  Imp_h21=Imp_h21(:); 
  Imp_h22(Imp_h22<Level)=0 ;             %%%  <=> � 20 db d'attenuation         
  Imp_h22=Imp_h22(:); 
  
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
subplot(2,2,1);plot(tau,20*log10(abs(h11)),'b'); grid on; 
subplot(2,2,2);plot(tau,20*log10(abs(h12)),'g'); grid on
subplot(2,2,3);plot(tau,20*log10(abs(h21)),'r'); grid on;
subplot(2,2,4);plot(tau,20*log10(abs(h22)),'y'); grid on;
  %title( 'LOS d=20')
xlabel('Delay (ns)','fontsize',14);
ylabel('Complexe Impulse Response(dB)','fontsize',14);
xlim([0*1e-6 5*1e-6])

figure(2);
    plot(tau,20*log10(abs(h11)),'b'); grid on; hold on
    plot(tau,20*log10(abs(h12)),'r'); grid on; 
    plot(tau,20*log10(abs(h21)),'g'); grid on; 
    plot(tau,20*log10(abs(h22)),'y'); grid on
  %title( 'LOS d=20')
xlabel('Delay (ns)');
ylabel('Complexe Impulse Response(dB)');
xlim([0*1e-6 1*1e-6])
 
figure(3)
  plot(tau,20*log10(abs(Imp_h11)),'b'); grid on; hold on
  plot(tau,20*log10(abs(Imp_h12)),'r'); grid on
  plot(tau,20*log10(abs(Imp_h21)),'g'); grid on
  plot(tau,20*log10(abs(Imp_h22)),'y'); grid on
  %title( 'LOS d=20')
  xlabel('Delay (ns)')
  ylabel('Complexe Impulse Response with Hamming(dB)')
  xlim([0*1e-6 1*1e-6])

%   fr=linspace(fstart,fstop,Nf) ;
%   freq_point(1)=fstart;
%   freq_point(2)=Fs;
%   freq_point(3)=fstop;
% % t=(0:(length(freq_point(1):freq_point(2):freq_point(3))-1))/(fr(freq_point(3)-freq_point(1))) ;
%   t=(0:(Nf-1))/(fr(Nf)-fr(1)) ;
% %   figure (3) ; 
%   temp=meli.*hamming(Nf) ;
%   impRsp=abs(ifft(temp)) ;
%   RepI=impRsp;
% % impRsp=abs(ifft(temp(freq_point(1):freq_point(2):freq_point(3)))) ;
% %   plot(t,impRsp/abs(max(impRsp)),'g')
% %   title( 'LOS d=6')
% %   xlabel('Delay (ns)')
% %   ylabel('Normalized Complexe Impulse Response') 
%   tau_s=(0:1:Nf-1)'./(Fs*Nf);
%   tau=tau_s.*1e6; % en usec
%   impRsp=impRsp/max(impRsp) ;
%   Seuil=-25;
%   Level= 10^(Seuil/20);
%   impRsp(impRsp<Level)=0 ;             %%%  <=> � 20 db d'attenuation         
%   impRsp=impRsp(:); 
%   mtau=sum((impRsp.^2).*tau)/sum(impRsp.^2) ;
%   dspread = sqrt(sum((impRsp.^2).*(tau.^2))/sum(impRsp.^2) - mtau^2);
%   dspread1(dist,1)=dspread*1e9;
%   BC =1/(5*dspread); %%%  Bande Coh閞ence
% %   BCMHz=BC/1e6
%   BCMHz(dist,1)=BC/1e6;
%   distan(dist,1)=dist;
%   BCdistan=[BCMHz,distan];
% %   pause
  
end   


toc;