function fig_3

% fig_3
% Generates Figure 3 from "Ashby & Best (2021) Herd Immunity"

% Calculate threshold
R0 = linspace(1e-10,20,1000);
h = max(0,1-1./R0);

% Create figure
figure(3)
clf
set(gcf,'color','w');
set(gcf,'PaperUnits','centimeters')
xSize = 5; ySize = 5;
xLeft = (21-xSize)/2; yTop = (30-ySize)/2;
set(gcf,'PaperPosition',[xLeft yTop xSize ySize])
set(gcf,'Position',[10 100 xSize*50 ySize*50])
font = 'helvetica';

% Shade specific regions
hold on
rectangle('position',[0,1-1/2,4,(1-1/4) - (1-1/2)],'facecolor',0.75*[1,1,1],'EdgeColor',0.75*[1,1,1]);
rectangle('position',[2,0,4-2,1-1/2],'facecolor',0.75*[1,1,1],'EdgeColor',0.75*[1,1,1]);
rectangle('position',[0,1-1/12,18,(1-1/18) - (1-1/12)],'facecolor',0.75*[1,1,1],'EdgeColor',0.75*[1,1,1]);
rectangle('position',[12,0,18-12,1-1/12],'facecolor',0.75*[1,1,1],'EdgeColor',0.75*[1,1,1]);
text(3,0.15,'COVID-19','interpreter','tex','fontname',font,'fontsize',14,'rotation',90)
text(15,0.15,'Measles','interpreter','tex','fontname',font,'fontsize',14,'rotation',90)

plot(R0,h,'k','linewidth',2)
set(gca,'fontsize',10,'fontname',font)
xlabel('Basic reproductive ratio, R_0','interpreter','tex','fontname',font,'fontsize',14)
ylabel('Herd immunity threshold','interpreter','tex','fontname',font,'fontsize',14)
set(gca,'ytick',0:0.2:1,'yticklabel',{'0%','20%','40%','60%','80%','100%'})
box on
plot(R0,0*R0,'k')
plot([0,0],[0,1],'k')

if(exist('save2pdf.m','file'))
    save2pdf('fig_3.pdf');
end
