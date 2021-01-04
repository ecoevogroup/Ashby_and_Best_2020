function fig_1

% fig_1
% Generates Figure 1 from "Ashby & Best (2021) Herd Immunity"

% Set random number seed
rng default
offset1 = 13;
offset2 = 33;

% Setup grid
N=7^2; % Grid size
x = linspace(0,1,sqrt(N));
y = linspace(0,1,sqrt(N));
[X,Y] = meshgrid(x,y);
X = X(:);
Y = Y(:);

% Distance matrix for connections
D=(X*ones(1,N) - ones(N,1)*X').^2 + (Y*ones(1,N) - ones(N,1)*Y').^2;
G = D<=(x(2)-x(1))^2 + 1e-5;
ind = ceil(N/2);
ind_contacts = find(G(ind,:));

% Create figure
figure(1)
clf
set(gcf,'color','w');
set(gcf,'PaperUnits','centimeters')
xSize = 16*0.8; ySize = 4.5*0.8;
% xSize = 16; ySize = 4.5;
xLeft = (21-xSize)/2; yTop = (30-ySize)/2;
set(gcf,'PaperPosition',[xLeft yTop xSize ySize])
set(gcf,'Position',[10 100 xSize*50 ySize*50])
labs = {'\bf{A}','\bf{B}','\bf{C}'};
Col=[77,175,74; 228,26,28; 55,126,184]/255;
font = 'helvetica';

for i=1:3
    subplot(1,3,i)
    hold on
    Status = ones(N,1);
    Status(ind) = 2;
    if(i==1)
        t1=title('No immunity','fontname',font,'fontsize',14,'fontweight','normal');
    elseif(i==2)
        rand(offset1,1);
        t1=title('Below threshold','fontname',font,'fontsize',14,'fontweight','normal');
        list = randperm(N);
        list = list(1:ceil(0.4*N));
        list(list==ind)=[];
        Status(list)=3;
    elseif(i==3)
        rand(offset2,1); 
        t1=title('Above threshold','fontname',font,'fontsize',14,'fontweight','normal');
        list = randperm(N);
        list = list(1:ceil(0.8*N));
        list(list==ind)=[];
        Status(list)=3;
    end
    text(-0.04,1.1,labs{i},'fontname',font,'fontsize',14);
    temp = get(t1,'position');
    temp(2) = 1.05;
    set(t1,'position',temp);
    
    % Highlight possible infectious contacts
    poss = ind_contacts(Status(ind_contacts)==1);
    if(isempty(poss))
        poss = ind_contacts(1);
        Status(poss) = 1;
    end
    
    % Add connections
    for k=1:N
        for j=1:N
            if(k>j && G(k,j)==1)
                if((Status(k)==1 && Status(j)==1))
                    plot([X(j) X(k)]',[Y(j) Y(k)]','-k','linewidth',1);
                elseif(Status(k)==3 || Status(j)==3)
                    plot([X(j) X(k)]',[Y(j) Y(k)]',':k','linewidth',1);
                end
            end
        end
    end
    
    plot([X(ind)+0*poss' X(poss)]',[Y(ind)+0*poss' Y(poss)]','-k','linewidth',3);
    
    % Add in nodes
    for k=1:N
        H(k)=plot(X(k),Y(k),'ok','MarkerFaceColor',Col(Status(k),:),'markersize',8);
    end
    set(H(ind),'MarkerFaceColor',Col(2,:));
    axis off
    
    % Adjust position
    temp = get(gca,'position');
    temp(2) = 0.05;
    set(gca,'position',temp)
end

if(exist('save2pdf.m','file'))
    save2pdf('fig_1.pdf');
end