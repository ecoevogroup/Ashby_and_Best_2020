function [t,x] = SIR(t_max,b,beta,gamma,plotflag)

% SIR
% Simple SIR model to generate dynamics for figures in "Ashby & Best (2020) Herd Immunity"

% Setup parameters and initial population
pars = [b,beta,gamma];
init_pop = [0.999,0.001,0];

% All checks completed, now solve the equations
[t,x] = ode45(@ode,[0,t_max],init_pop,odeset('abstol',1e-10,'nonnegative',1:length(init_pop)),pars);

% Only plot internally if plotflag>0
if(plotflag>0)
    figure(10)
    clf
    plot(t,x)
end

end

% ODEs
function dxdt = ode(t,x,pars)
b = pars(1);
beta = pars(2);
gamma = pars(3);

S = x(1);
I = x(2);
R = x(3);

dxdt = [b*(S+I+R)-beta*S*I - b*S;
    beta*S*I - gamma*I  - b*I
    gamma*I  - b*R];

end