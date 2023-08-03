
%define starting values
H0_plus = 0.6;
H0_minus = 0.17;
H0_main = 0.25;
T = 24;
a = 0.1;
alpha = 0;
chi_sleep = 4.2; chi_awake = 18.2;

% thresholds
H_plus = @(t) H0_plus + (a * sin((2*pi/T) * (t - alpha)));
H_minus = @(t) H0_minus + (a * sin((2*pi/T) * (t - alpha)));

% iterations
N = 720;

% step size
dt = 0.1;

% define matricies
H_data = zeros(N);
timeSteps = zeros(N);
sleepDeprivation = zeros(N);

H = H0_main;
S_t = 1;
chi = chi_awake;

% loop for plotting the regular sleep pattern
for n = 1:N
    
    H = H + dt*((S_t - H) / chi);

    % check if we hit the upper threshold
    if H >= H_plus(n*dt)
        S_t = 0;
        chi = chi_sleep;
    end
    
    % check if we hit the lower threshold
    if H <= H_minus(n*dt)
        S_t = 1;
        chi = chi_awake;
    end
    
    % add current iteration to the data matricies
    H_data(n) = H;
    timeSteps(n) = n * dt;

end

H = H0_main;
S_t = 1;
chi = chi_awake;

% loop for plotting the sleep deprived case
for n = 1:N
    
    H = H + dt*((S_t - H) / chi);

    if n*dt == 7
        S_t = 0;
        chi = chi_sleep;
    end
    if n*dt == 7.2
        S_t = 1;
        chi = chi_awake;
    else
        % check if we hit the upper threshold
        if H >= H_plus(n*dt)
            S_t = 0;
            chi = chi_sleep;
        end
        
        % check if we hit the lower threshold
        if H <= H_minus(n*dt)
            S_t = 1;
            chi = chi_awake;
        end
    end
    % add current iteration to the data matricies
    sleepDeprivation(n) = H;

end

% plot the two axes

plot(timeSteps, H_data, "LineWidth", 3);
title('Sleep Deprivation');

hold on

y2 = H_minus;
fplot(y2, "-", "LineWidth",2)

y3 = H_plus;
fplot(y3, "-", "LineWidth", 2) 

plot(timeSteps, sleepDeprivation, "LineWidth", 3);

hold off