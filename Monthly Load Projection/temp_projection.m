function [temp_hourly]=temp_projection(X,pv_hourly,choice)

     x=X(:,1:size(X,2)-1);
     y=X(:,size(X,2));
     m = length(y);
     [x mu sigma] = featureNormalize(x);
     x = [ones(m, 1) x];
     alpha_temp = 0.01;    
     num_iters_temp = 800;
     
     theta_temp = zeros(4, 1); 
     [theta_temp, J_history] = gradientDescentMulti(x, y, theta_temp, alpha_temp, num_iters_temp);
     figure;
     plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
     xlabel('Number of iterations');
     ylabel('Cost J (TEMP)');

     % Display gradient descent's result
     fprintf('\n');
     fprintf('Theta computed from gradient descent for Temp Projection: \n');
     fprintf(' %f \n', theta_temp);
     
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
      
     temp_hourly=zeros(30,24);
     
    for i = 1:30                    %Increment in Days
      Time=0000;   
        for j=1:24                  %Increment in Hours
             d = [Date	Time pv_hourly(i,j)];
             d = (d - mu) ./ sigma;
             d = [ones(1, 1) d];
             temp_hourly(i,j) = d * theta_temp;
             Time=Time+100;
        end 
      Date=Date+1; 
    end
    
end