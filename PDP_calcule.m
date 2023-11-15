function [PDP_effective,multipath] = PDP_calcule( axe_temps,reponse_impulsionnelle )
threshold = 10^(-18);% was 10^(-9)
PDP=(reponse_impulsionnelle.^2);
PDP_effective=[];
multipath=[];
for i=1:1:(length(PDP))
    if((PDP<threshold) | (i >(length(PDP)/2)))
       PDP_effective(i)=0; 
    else
        PDP_effective(i)=PDP(i);
    end
    if (PDP_effective(i)==max(PDP_effective))
        P_LOS=PDP_effective(i);multipath(i)=0;
    else
        multipath(i)=PDP_effective(i);
    end 
end
PDP_effective=PDP_effective';
sii=size(PDP_effective)
multipath=multipath';
% Ptot = sum(PDP_effective);
% Tau = (sum(axe_temps.*PDP_effective))/Ptot;
% Tau_carre = (sum(PDP_effective.*(axe_temps.^2)))/Ptot;
% delay_spred = sqrt(Tau_carre-Tau^2);

end
