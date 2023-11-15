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
for dist=1:11;
    BC=[];
    dspread=[];
%     BCMHz=[];
    dspread=[];
    L=[];
    AvP=[];
    Pfinal=[];
    for xpos=1:1:4;
     load(strcat(path,'mes',num2str(dist),num2str(xpos),'.mat'));
%      H=matrice;
     Freq=matrice (:,1);    
     H=matrice (:,2); 
     L=[L,H];

    end
    
       PuiNorm= mean(LNorm,2) ;
  AvP=mean(L,2) ;
%   Lfinal=[Freq,L];%     Matrice fr閝uence et Toutes les Puissances ;
 Pfinal=[Freq,AvP];%     Matrice fr閝uence et Puissance Moyenne;
%   Freq=Pfinal (:,1);    
  H=Pfinal (:,2); 
  
  PR= bsxfun(@rdivide,H(:),PuiNorm(:)); 
  
meli=PR;
  
  Nf = length (Freq);
  fstart = Freq(1,1);
  fstop = Freq(Nf,1);
  Fs=(fstop-fstart)/(Nf-1); % Fs repr閟ente la s閜aration fr閝uentielle entre 2
% % % 閏hantillons
  tau=(0:1:Nf-1)/(Fs*Nf);
  Mes=ifft(meli) ;
  H2=meli.*hamming(Nf);
  HT=ifft(H2);
% HT=ifft(H2);
  figure(1)
  plot(tau,20*log10(abs(Mes)),'b')
  title( 'LOS d=6')
  xlabel('Delay (ns)')
  ylabel('Complexe Impulse Response(dB)')
  figure(2)
  plot(tau,20*log10(abs(HT)),'r')
  title( 'LOS d=6')
  xlabel('Delay (ns)')
  ylabel('Complexe Impulse Response with Hamming(dB)')
%  plot(tau,abs(mes),'b-*')
  fr=linspace(fstart,fstop,Nf) ;
  freq_point(1)=fstart;
  freq_point(2)=Fs;
  freq_point(3)=fstop;
% t=(0:(length(freq_point(1):freq_point(2):freq_point(3))-1))/(fr(freq_point(3)-freq_point(1))) ;
  t=(0:(Nf-1))/(fr(Nf)-fr(1)) ;
%   figure (3) ; 
  temp=meli.*hamming(Nf) ;
  impRsp=abs(ifft(temp)) ;
  RepI=impRsp;
% impRsp=abs(ifft(temp(freq_point(1):freq_point(2):freq_point(3)))) ;
%   plot(t,impRsp/abs(max(impRsp)),'g')
%   title( 'LOS d=6')
%   xlabel('Delay (ns)')
%   ylabel('Normalized Complexe Impulse Response') 
  tau=(0:1:Nf-1)'./(Fs*Nf); 
  impRsp=impRsp/max(impRsp) ;
  Seuil=-10;
  Level= 10^(Seuil/20);
  impRsp(impRsp<Level)=0 ;             %%%  <=> � 20 db d'attenuation         
  impRsp=impRsp(:); 
  mtau=sum((impRsp.^2).*tau)/sum(impRsp.^2) ;
  dspread = sqrt(sum((impRsp.^2).*(tau.^2))/sum(impRsp.^2) - mtau^2);
  dspread1(dist,1)=dspread*1e9;
  BC =1/(5*dspread); %%%  Bande Coh閞ence
%   BCMHz=BC/1e6
  BCMHz(dist,1)=BC/1e6;
  distan(dist,1)=dist;
 mtau1(dist,1)=mtau*1e9;
  BCdistan=[BCMHz,distan];
%   pause
  
end   


toc;