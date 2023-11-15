
%%
tic
path='C:\Users\Administrator.LAPTOP-NN75G73L\Desktop\Advanced Electronics Measuement\uwb\uwb\';
%---- h11
for dist=1:10
    % ---- h11
    path_h11=strcat(path,num2str(dist),'s13.s2p') ;
    h11=importdata(path_h11,' ',6) ;
    h11=10.^(h11.data(:,4)/20) .*exp(1i*h11.data(:,5)*pi/180) ;
    % ---- h12
    path_h12=strcat(path,num2str(dist),'s14.s2p') ;
    h12=importdata(path_h12,' ',6) ;
    h12=10.^(h12.data(:,4)/20) .*exp(1i*h12.data(:,5)*pi/180) ;
   % ---- h12
    path_h21=strcat(path,num2str(dist),'s23.s2p') ;
    h21=importdata(path_h21,' ',6) ;
    h21=10.^(h21.data(:,4)/20) .*exp(1i*h21.data(:,5)*pi/180) ;
    % ---- h12
    path_h22=strcat(path,num2str(dist),'s24.s2p') ;
    h22=importdata(path_h22,' ',6) ;
    h22=10.^(h22.data(:,4)/20) .*exp(1i*h22.data(:,5)*pi/180) ;
    
    %---- en registrement correspondant au point de mesure dist
    mes=strcat('mes',num2str(dist)) ;
    matrice= [] ;
    
    matrice(1,1,:)=h11 ;
    matrice(1,2,:)=h12 ;
    matrice(2,1,:)=h21 ;
    matrice(2,2,:)=h22 ;
    strcat(path,mes);
    save(strcat(path,mes),'matrice');
end
    %---------------------- enregistrement de la matrice � dist 
toc    
 