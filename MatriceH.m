

function Caps = MatriceH 
Caps=[]

%path='D:\mesa\' ;
path='C:\Users\Administrator.LAPTOP-NN75G73L\Desktop\Advanced Electronics Measuement\uwb\uwb\' ; %test
%path='D:\UQAT\Mourad\For Isma3il\mesure\' ;  % original

snr= 10 ;
Cap=[] ;
freq=2562;

for dist=1:1:11
    load(strcat(path,'mes',num2str(dist),'.mat')) ;
    H=matrice(:,:,freq) ;
    [cap_n,cap_sn] = capacite(H,snr) ;
    Cap=[Cap,cap_n] ;
    Caps=[Caps,cap_sn] ;
    
end

figure(1)
plot(Cap)
figure(2)
plot(Caps)


