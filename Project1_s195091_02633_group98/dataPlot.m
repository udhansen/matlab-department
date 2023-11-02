%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Forfatter: Ulrik Dan Hansen, s195091
% Dato: 14. januar 2022
% Sted: Dansk Tekniske Univeristet
% Kursus: 02633 Introduktion til programmering og databehandling
% Dokument navn: dataPlot.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dataPlot(data)

%% Graf 1 - Number of bacteria

subplot(1,2,1) % 1 række 2 kolonner, til venstre
histogram('Categories',{'Salmonella enterica'},'BinCounts',sum(data(:,3) == 1),'BarWidth',0.5,'FaceColor','r') % Sølje-diagram over bakerie-type. Behandler data fra kolonne 3 
                                                                                                               % ved at finde summen af optrædener af samme tal.
xlabel('Bacteria Type','FontSize',12);
ylabel('Total','FontSize',12);
title('Number of Bacteria','FontSize',16);
grid on

hold on
histogram('Categories',{'Bacillus cereus'},'BinCounts',sum(data(:,3) == 2),'BarWidth',0.5,'FaceColor','g')
histogram('Categories',{'Listeria'},'BinCounts',sum(data(:,3) == 3),'BarWidth',0.5,'FaceColor','b')
histogram('Categories',{'Brochothrix thermosphacta'},'BinCounts',sum(data(:,3) == 4),'BarWidth',0.5,'FaceColor','m')

%% Graf 2 - Growth rate by temperature

T1 = data(data(:,3) == 1); % Gemmer alle temperature med bakerie-type 1
T2 = data(data(:,3) == 2); % Gemmer alle temperature med bakerie-type 2
T3 = data(data(:,3) == 3); % Gemmer alle temperature med bakerie-type 3
T4 = data(data(:,3) == 4); % Gemmer alle temperature med bakerie-type 4

GR1 = data(data(:,2:3) == 1); % Gemmer alle growth rates med bakerie-type 1
GR2 = data(data(:,2:3) == 2); % Gemmer alle growth rates med bakerie-type 2
GR3 = data(data(:,2:3) == 3); % Gemmer alle growth rates med bakerie-type 3
GR4 = data(data(:,2:3) == 4); % Gemmer alle growth rates med bakerie-type 4


subplot(1,2,2)    % 1 række 2 kolonner, til højre
plot(T1,GR1,'r*'); % Bakterie-type 1 - rød kurve
xlim([10 60]);    % temperatur vises i intervallet 10 - 60
ylim([0 inf]);    % growth rate starter fra (10, 0)
xlabel('Temperature (°C)','FontSize',12);
ylabel('Growth rate (\mu)','FontSize',12);
title('Bacteria Analysis','FontSize',16)
grid on

hold on
plot(T2,GR2,'g*'); % Bakterie-type 2 - grøn kurve
plot(T3,GR3,'b*'); % Bakterie-type 3 - blå kurve
plot(T4,GR4,'m*'); % Bakterie-type 4 - magenta kurve
legend({'Salmonella enterica','Bacillus cereus', 'Listeria', 'Brochothrix thermosphacta'},'Location','southwest', 'FontSize',9); % Info-boks i plot, 
                                                                                                                                 % der viser hvilken graf der repræsenterer 
                                                                                                                                 % bakterie-type

