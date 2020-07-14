% cass learner
%clasLearn2 = [scat_features, allLabels_scat];
largo = length(allLabels_scat);
labelWv = zeros(largo,1);
for k = 1:largo
    
      if(strcmp(allLabels_scat(k), 'T0'))
          labelWv(k) = 0;
      
      elseif(strcmp(allLabels_scat(k), 'T1'))
          labelWv(k) = 1;    
         
          
      elseif(strcmp(allLabels_scat(k), 'T2'))
           labelWv(k) = 2;    
            
      end
                  
    
end
clasLearn2 = [scat_features, labelWv];