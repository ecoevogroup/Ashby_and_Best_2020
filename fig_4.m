function fig_4

% fig_4
% Generates Figure 4 from "Ashby & Best (2020) Herd Immunity"

% Setup parameters
t_max = 365*25; % duration
b = 0.0005; % popualtion turnover
gamma = 1/7; % recovery rate
beta = 2.5*(gamma+b); % transmission rate
R0 = beta/(gamma+b); % basic reproduction number
HI = 1-1/R0; % Herd immunity threshold

% Generate dynamics
[t,x] = SIR(t_max,b,beta,gamma,0);

% Create figure
figure(4)
clf
set(gcf,'color','w');
set(gcf,'PaperUnits','centimeters')
xSize = 7; ySize = 4;
xLeft = (21-xSize)/2; yTop = (30-ySize)/2;
set(gcf,'PaperPosition',[xLeft yTop xSize ySize])
set(gcf,'Position',[10 100 xSize*50 ySize*50])
pos1 = [0.13,0.16,0.3,0.8];
pos2 = [0.43,0.16,0.5,0.8];
pos3 = [0.61,0.28,0.3,0.2];

% First phase
axes('position',pos1)
hold on
plot(t,1-x(:,1),'linewidth',2)
h2=plot(t,x(:,2),'linewidth',2);
plot([0,t_max],HI*[1,1],'k--','linewidth',1)
xlim([0,100])
set(gca,'xtick',0:20:80)
ylim([0,1])
set(gca,'fontsize',10)
xlabel('Time (days)','interpreter','latex','fontsize',14)
ylabel('Proportion','interpreter','latex','fontsize',14)
text(70,HI-0.08,{'herd immunity','threshold'},'interpreter','latex','fontsize',10,'horizontalalignment','center')
text(35,0.92,'not susceptible','interpreter','latex','fontsize',10)
text(45,0.2,'infected','interpreter','latex','fontsize',10)
box on

% Second phase
axes('position',pos2)
hold on
plot(t,1-x(:,1),'linewidth',2)
plot(t,x(:,2),'linewidth',2)
plot([0,t_max],HI*[1,1],'k--','linewidth',1)
xlim([100,t_max])
ylim([0,1])
set(gca,'ytick',[])
set(gca,'fontsize',10)
set(gca,'xtick',0:(365*5):t_max,'xticklabel',(0:(365*5):t_max)/365)
xlabel('Time (years)','interpreter','latex','fontsize',14)
box on

% Inset
axes('position',pos3)
box on
plot(t,x(:,2),'linewidth',2,'color',get(h2,'color'))
xlim([100,t_max])
set(gca,'fontsize',8)
set(gca,'xtick',0:(365*5):t_max,'xticklabel',(0:(365*5):t_max)/365)
ylim([0,0.04])
ylabel('Proportion','interpreter','latex','fontsize',8)
xlabel('Time (years)','interpreter','latex','fontsize',8)

if(exist('save2pdf.m','file'))
    save2pdf('fig_4.pdf');
end