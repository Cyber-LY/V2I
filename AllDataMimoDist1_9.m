clear all;
close all;
clc;

path='C:\\Users\\Administrator.LAPTOP-NN75G73L\\Desktop\\Advanced Electronics Measuement\\uwb\\uwb\\';
% 注意这里的双反斜杠

%---- h11
tic;
for dist=1:11
    
    
    % ---- h11
    path_h11=strcat(path,num2str(dist),'s13','.s2p') ;
    % disp(path_h11); % 显示完整的文件路径
    % which path_h11; % 显示 MATLAB 能否找到该文件
    
    

    Freq=importdata(path_h11,' ',6) ;
    FreqMag=importdata(path_h11,' ',6) ;
    FreqPhase=importdata(path_h11,' ',6) ;
    h11=importdata(path_h11,' ',6) ;
    Freq=((Freq.data(:,1)));
    FreqMag=((FreqMag.data(:,4)));
    FreqPhase=((FreqPhase.data(:,5)));
    h11=10.^(h11.data(:,4)/20) .*exp(1i*h11.data(:,5)*pi/180);
   
    mes=strcat('mes',num2str(dist),'1') ;
    matrice= [] ;
    
    matrice(:,1)=Freq;
    matrice(:,2)=h11;

    strcat(path,mes);
    save(strcat(path,mes),'matrice')
%{
    % ---- h12
    path_h12=strcat(path,num2str(dist),'s14','.s2p') ;
    Freq=importdata(path_h12,' ',6) ;
    FreqMag=importdata(path_h12,' ',6) ;
    FreqPhase=importdata(path_h12,' ',6) ;
    h12=importdata(path_h12,' ',6) ;
    Freq=((Freq.data(:,1)));
    FreqMag=((FreqMag.data(:,4)));
    FreqPhase=((FreqPhase.data(:,5)));
    h12=10.^(h12.data(:,4)/20) .*exp(1i*h12.data(:,5)*pi/180);
   
    mes=strcat('mes',num2str(dist),'2') ;
    matrice= [] ;
    
    matrice(:,1)=Freq;
    matrice(:,2)=h11;

    strcat(path,mes);
    save(strcat(path,mes),'matrice');
    
    % ---- h21
    path_h21=strcat(path,num2str(dist),'s23','.s2p') ;
    Freq=importdata(path_h21,' ',6) ;
    FreqMag=importdata(path_h21,' ',6) ;
    FreqPhase=importdata(path_h21,' ',6) ;
    h21=importdata(path_h21,' ',6) ;
    Freq=((Freq.data(:,1)));
    FreqMag=((FreqMag.data(:,4)));
    FreqPhase=((FreqPhase.data(:,5)));
    h21=10.^(h21.data(:,4)/20) .*exp(1i*h21.data(:,5)*pi/180);
   
    mes=strcat('mes',num2str(dist),'3') ;
    matrice= [] ;
    
    matrice(:,1)=Freq;
    matrice(:,2)=h21;

    strcat(path,mes);
    save(strcat(path,mes),'matrice');

    % ---- h22
    path_h22=strcat(path,num2str(dist),'s24','.s2p') ;
    Freq=importdata(path_h22,' ',6) ;
    FreqMag=importdata(path_h22,' ',6) ;
    FreqPhase=importdata(path_h22,' ',6) ;
    h22=importdata(path_h22,' ',6) ;
    Freq=((Freq.data(:,1)));
    FreqMag=((FreqMag.data(:,4)));
    FreqPhase=((FreqPhase.data(:,5)));
    h22=10.^(h22.data(:,4)/20) .*exp(1i*h22.data(:,5)*pi/180);
   
    mes=strcat('mes',num2str(dist),'4') ;
    matrice= [] ;
    
    matrice(:,1)=Freq;
    matrice(:,2)=h22;

    strcat(path,mes);
    save(strcat(path,mes),'matrice');
%}
end
    %---------------------- enregistrement de la matrice � dist 
    toc;
  disp('fini');  
 