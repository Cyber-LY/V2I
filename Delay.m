clc; close all; clear all;


%path='D:\mesa\' ;
path='C:\Users\Administrator.LAPTOP-NN75G73L\Desktop\Advanced Electronics Measuement\uwb\uwb\' ;


ZT=[];
tz=[];


for dist=1:1:11
    load(strcat(path,'mes',num2str(dist))) ;
    H = matrice() ;    
    Havg = sum(sum(H))/4;
    A_impulse = abs(real(ifft((Havg))));

    
    Nf = length(Havg);
    fstart = 2e9;
    fstop = 3e9;
    Fs=(fstop-fstart)/(Nf-1); 
    Ts=1/Fs;

    
    han=hanning(Nf);
        for k=1:Nf
        R(k)=Havg(:,:,k)*han(k); 
        end;


    t1 = 0;
    t2 = 1100;
    Nt=Nf; 
    m=Nt; 
    w=exp(-1i*2*pi*(t2-t1)/(m*Ts)); 
    a=exp(1i*2*pi*t1/Ts); 
    tz_han=(45/23)*conj((1/m)*czt(conj(R),m,w,a)); 
    tz=((0:length(tz_han)-1)'*(t2/length(tz_han))).*1e6; % us
    
    ZT = [ZT tz];
    tz=[];
end
