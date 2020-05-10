%% ================ Part 1: Feature Normalization ================

%% Clear and Close Figures
clear ; close all; clc
fprintf('Program paused. Press enter to load data.\n');
pause;
%% Load Data
fprintf('Loading data ...\n\n');
data = load('data.txt');
X = data(:, 1:4);    
y = data(:, 5);
m = length(y);

fprintf('Program paused. Press enter to normalize features.\n');
pause;

% Scale features and set them to zero mean
fprintf('Normalizing Features ...\n\n');
 X_x=X;         %Saving X temporarily to pass it for pv and temp projection
                %as pv and temp calculate their normalization accordingly
[X mu sigma] = featureNormalize(X);

% Add intercept term to X
X = [ones(m, 1) X];

fprintf(['Program paused. Press enter to minimize squared error cost' ...
         'function via Gradient Descent.\n']);
pause;

%% ================ Part 2: Gradient Descent ================

fprintf(['Running gradient descent with 0.01 stepsize and 800 ' ... 
         'iterations ...\n\n']);

% Choose some alpha value
alpha = 0.01;    
num_iters = 800;

% Init Theta and Run Gradient Descent 

theta = zeros(5, 1);         

[theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters);

fprintf('Program paused. Press enter to view the convergence plot.\n');
pause;

% Plot the convergence graph
figure;
plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost J (Load)');

% Display gradient descent's result
fprintf('Theta computed from gradient descent: \n');
fprintf(' %f \n', theta);
fprintf('\n');

fprintf('Program paused. Press enter to project Monthly Load.\n');
pause;

prompt ='Input the Month from 1-12 for which you want prediction:  ';
choice=input(prompt);
     
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

[pv, pv_hourly] = pv_projection(X_x,choice);
[temp_hourly]=temp_projection(X_x,pv_hourly,choice);

     load=zeros(30,1);
     load_hourly=zeros(30,24);
     
    for i = 1:30                    %Increment in Days
      Time=0000;  
      old_load=0;
        for j=1:24                  %Increment in Hours
             d = [Date	Time pv_hourly(i,j)	temp_hourly(i,j)];
             d = (d - mu) ./ sigma;
             d = [ones(1, 1) d];
             load_hourly(i,j) = d * theta;
             old_load=load_hourly(i,j)+old_load;
             Time=Time+100;
        end
      load(i)=old_load;  
      Date=Date+1; 
    end
     
clear i; clear j;
 
%===========================================================%
%                 Monthly Bill Calculation                  %
Load=sum(load);                         
PV=sum(pv);
billCalculator(Load,PV);
%===========================================================%

fprintf(['The reason why we are getting very low bill is that we used the' ...
         ' dataset from the NET ZERO ENERGY HOMES\n']);