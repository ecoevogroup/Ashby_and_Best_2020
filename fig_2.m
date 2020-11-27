function fig_2

% fig_2
% Generates Figure 2 from "Ashby & Best (2020) Herd Immunity"

% Setup parameters
t_max = 100; % duration
b = 0; % population turnover
gamma = 1/7; % recovery rate
beta = 2.5*gamma; % transmission rate
R0 = beta/gamma; % basic reproduction number

% Generate dynamics
[t,x] = SIR(t_max,b,beta,gamma,0);

% Find when herd immunity is achieved
t_HI = find(x(:,2)==max(x(:,2)));
HI = 1-x(t_HI,1);

% Create figure
figure(2)
clf
set(gcf,'color','w');
set(gcf,'PaperUnits','centimeters')
xSize = 5; ySize = 5;
xLeft = (21-xSize)/2; yTop = (30-ySize)/2;
set(gcf,'PaperPosition',[xLeft yTop xSize ySize])
set(gcf,'Position',[10 100 xSize*50 ySize*50])

subplot(2,1,1)
hold on
plot(t,1-x(:,1),'linewidth',2)
plot(t,x(:,2),'linewidth',2)
plot(t(t_HI)*[1,1],[0,1],':','color',0.6*[1,1,1],'linewidth',2)
plot([0,t_max],HI*[1,1],'-','color',0.6*[1,1,1],'linewidth',1)
set(gca,'fontsize',10)
ylabel('Proportion','interpreter','latex','fontsize',14)
text(t_max*0.8,HI-0.13,{'herd immunity','threshold'},'interpreter','latex','fontsize',10,'horizontalalignment','center')
text(t_max*0.6,0.8,'not susceptible','interpreter','latex','fontsize',10)
text(t_max*0.45,0.2,'infected','interpreter','latex','fontsize',10)
set(gca,'xtick',[])
set(gca,'ytick',0:0.2:1)
text(t_max*0.18,1-x(end,1)+0.05,'$R>1$','interpreter','latex','fontsize',10)
text(t_max*0.37,1-x(end,1)+0.05,'$R<1$','interpreter','latex','fontsize',10)
text(0,0.95,'(a)','interpreter','latex','fontsize',10)
box on
drawnow
temp1 = get(gca,'position');
temp1(1) = temp1(1) + 0.03;
temp1(4) = temp1(4) + 0.05;
set(gca,'position',temp1)

subplot(2,1,2)
hold on
plot(t,R0*x(:,1),'k','linewidth',2)
plot(t(t_HI)*[1,1],[0,3],':','color',0.6*[1,1,1],'linewidth',2)
set(gca,'ycolor','k')
ylabel({'Reproduction','number, $R$'},'interpreter','latex','fontsize',14)
text(t_max*0.8,1.2,'$R=1$','interpreter','latex','fontsize',10)
text(t_max*0.8,R0+0.2,'$R=R_0$','interpreter','latex','fontsize',10)
plot([0,t_max],[1,1],'--','color',0.6*[1,1,1],'linewidth',1)
plot([0,t_max],[R0,R0],'--','color',0.6*[1,1,1],'linewidth',1)
box on
xlabel('Time (days)','interpreter','latex','fontsize',14)
text(0,0.95*3,'(b)','interpreter','latex','fontsize',10)

temp2 = get(gca,'position');
temp2(1) = temp1(1);
temp2(2) = temp2(2)+0.02;
temp2(3) = temp1(3);
temp2(4) = temp1(4);
set(gca,'position',temp2)

if(exist('save2pdf.m','file'))
    save2pdf('fig_2.pdf');
end