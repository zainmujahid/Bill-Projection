function [pv, pv_hourly] = pv_projection(X,choice)
   
     x=X(:,1:size(X,2)-2);
     y=X(:,size(X,2)-1);
     m = length(y);
     [x mu sigma] = featureNormalize(x);
     x = [ones(m, 1) x];
     alpha_pv = 0.01;    
     num_iters_pv = 800;
     
     theta_pv = zeros(3, 1); 
     [theta_pv, J_history] = gradientDescentMulti(x, y, theta_pv, alpha_pv, num_iters_pv);
     figure;
     plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
     xlabel('Number of iterations');
     ylabel('Cost J (PV)');
     
     % Display gradient descent's result
     fprintf('Theta computed from gradient descent for PV Projection: \n');
     fprintf(' %f \n', theta_pv);
     fprintf('\n');
     
     switch choice
         case 1
             Date=0101;
         case 2
             Date=0201;    
         case 3
             Date=0301;
         case 4
             Date=0401;   
         case 5
             Date=0501;
         case 6
             Date=0601;    
         case 7
             Date=0701;
         case 8
             Date=0801;               
         case 9
             Date=0901;
         case 10
             Date=1001;    
         case 11
             Date=1101;
         case 12
             Date=1201;               
     end
      
     pv=zeros(30,1);
     pv_hourly=zeros(30,24);
     
    for i = 1:30                    %Increment in Days
      Time=0000;  
      old_pv=0;
        for j=1:24                  %Increment in Hours
             d = [Date	Time];
             d = (d - mu) ./ sigma;
             d = [ones(1, 1) d];
             pv_hourly(i,j) = d * theta_pv;
             old_pv=pv_hourly(i,j)+old_pv;
             Time=Time+100;
        end
      pv(i)=old_pv;  
      Date=Date+1; 
    end
    
end