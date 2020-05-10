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

theta = zeros(5, 1);         %Initializing Theta with zeror
%theta = rand(5, 1);         %Initializing 0 < Theta < 1  
%theta = randi(15, 5, 1);    %Initializing 0 < Theta < 15

[theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters);

fprintf('Program paused. Press enter to view the convergence plot.\n');
pause;

% Plot the convergence graph
figure;
plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost J');

% Display gradient descent's result
fprintf('Theta computed from gradient descent: \n');
fprintf(' %f \n', theta);
fprintf('\n');

fprintf('Program paused. Press enter to project hourly load.\n');
pause;

% Estimate the load at Date (Feb 18) Time (18:00) PV (0.248) Temp(27.885)
%  Recall that the first column of X is all-ones. Thus, it does
%  not need to be normalized.

 Date=0218;
 Time=1800;
 PV=0.248;
 Temp=27.885;
 
 d = [Date	Time PV	Temp];
 d = (d - mu) ./ sigma;
 d = [ones(1, 1) d];
 hLOAD = d * theta; 

 fprintf(['Predicted Load in KWh at given Date, Time, PV, ' ...
          'Temp (using gradient descent) is:\n %f\n'], hLOAD);
      
%============================================================
%                 Hourly Bill Calculation 
 billCalculator(hLOAD,PV);
%============================================================

      
 fprintf('Program paused. Press enter to predict via Normal Equations.\n');
 pause;

%% ================ Part 3: Normal Equations ================

fprintf('Solving with normal equations...\n');
fprintf('Loading Data...\n');

%% Load Data
data = load('data.txt');
X = data(:, 1:4);
y = data(:, 5);
m = length(y);

% Add intercept term to X
X = [ones(m, 1) X];

% Calculate the parameters from the normal equation
theta = normalEqn(X, y);

% Display normal equation's result
fprintf('Theta computed from the normal equations: \n');
fprintf(' %f \n', theta);
fprintf('\n');

fprintf('Program paused. Press enter to project hourly load.\n');
pause;

% Estimate the load at Date (Feb 18) Time (18:00) PV (0.248) Temp(27.885)
d = [1 Date	Time PV	Temp];
hload = d * theta;

fprintf(['Predicted Load in KWh at given Date, Time, PV, ' ...
          'Temp (using normal equations) is:\n %f\n'], hload);

% ============================================================
%                 Hourly Bill Calculation 
 billCalculator(hload,PV);
% ============================================================


fprintf(['The reason that vector Theta from gradient descent and ' ...
          'normal equations differs is because there is no unique solution\n']);
fprintf(['of y and gradient descent must have converged to a local minima ' ...
          'but predicted loads from both methods are somewhat equal.\n']);