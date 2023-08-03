I = @(t) -5+10*sin(0.01*t);
Vreset = -10; Vpeak = 60; tau = 13;
V0 = 1;
t0 = 0; tf = 1000;
N = 1e4;
dt = (tf-t0)/N;
t = t0; V = V0;

for n = 1:N

    V = V + dt*(I(t) + V^2)/tau;
    t = t + dt;

    if V >= Vpeak
        V = Vreset;
    end
end

