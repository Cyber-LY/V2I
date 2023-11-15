%-------------------------------------------------------------------------%
%                         nHnorm=normaliser(nH,dimH)                      %
%-------------------------------------------------------------------------%
%                                                                         %
% Input :     - nH    : La concatenations Vde tous les H pour un pt donné %
%             - dimH  : dimension de H                                    %
%                                                                         %
% Output:     - nHnorm : nH normalisé                                     % 
%-------------------------------------------------------------------------%
%-------------------------------------------------------------------------%

function nHnorm  = normaliser(nH,dimH)

clear temp  ;
M=dimH(1) ;
N=dimH(2) ;
nHnorm=[] ;
nbre_pr=size(nH,1)/dimH(1) ;

for k=1:1:nbre_pr
    temp=nH(M*(k-1)+1:M*k,:) ;    
    H=temp ./sqrt(mean(mean(abs(temp).^2))) ;
    %------------------------------------------------- Second Normalisation
%     for rx=1:M
%         H(rx,:)=H(rx,:)/sqrt(sum(abs(H(rx,:)).^2)) ;
%     end
    %--------------------------------------------- End Second normalisation
    nHnorm=[nHnorm ; H] ;  
end
nHnorm ;
return
%-------------------------------------------------------------------------%