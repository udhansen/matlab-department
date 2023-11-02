%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Forfatter : Ulrik Dan Hansen, s195091 
% Dato: 20. januar 2022
% Sted: Dansk Tekniske Univeristet
% Kursus: 02633 Introduktion til programmering og databehandling
% Dokument navn: gradesPlot.m
% Projekt 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Denne funktion visualiserer karakterfordelingen for hvér opgave og
% gennemsnit, samt karakterfordelingen af slutkarakter
function gradesPlot(grades)
%% Final grades

% Slutkarakter fås fra funktionerne computeFinalGrade og roundGrade
gradesFinal = roundGrade(computeFinalGrades(grades));

subplot(1,2,1) % 1 række 2 kolonner, til venstre
% Bestået del angives med grøn. Finder sum af optrædener for hvér karakter
histogram('Categories',{'02' '4' '7' '10' '12'},'BinCounts',[sum(gradesFinal == 2) sum(gradesFinal == 4) sum(gradesFinal == 7) sum(gradesFinal == 10) sum(gradesFinal == 12)],'BarWidth',0.5,'FaceColor','g')

xlabel('Slutkarakter','FontSize',14);
ylabel('Antal','FontSize',14);
title('Karakterfordeling','FontSize',16);
grid on

hold on
% Ikke bestået del angives med rød
histogram('Categories',{'-3' '00'},'BinCounts',[sum(gradesFinal == -3) sum(gradesFinal == 0)],'BarWidth',0.5,'FaceColor','r') 

%% Grades pr. assignment

M = width(grades) - 2; % Antal opgaver trukket fra 2, da de to første kolonner er studentens oplysninger
gradeAVG = zeros(1, M);
x = reshape(1:M,M,1); % Laver søjle-vektor til gennemsnit

for i = 3:width(grades)
 gradeAVG(i-2) = mean(grades{:,i}); % Finder gennemsnit for hver opgave
end

y = reshape(gradeAVG,M,1); % Laver om til søjle-vektor

subplot(1,2,2) % 1 række 2 kolonner, til højre

% En linje tegnes hvis M > 1, ellers er det et punkt
if M == 1
    plot(x,y,'rd','MarkerSize',10);
    legend('GNS','Location','eastoutside', 'FontSize',10,'AutoUpdate','off');    
else
    plot(x,y,'r--', 'LineWidth',2);
    legend('GNS','Location','eastoutside', 'FontSize',10,'AutoUpdate','off');
end
xlabel('Opgave Nr.','FontSize',14);
ylabel('Karakter (7-trinsskalaen)','FontSize',14);
title('Karakterfordeling samt gennemsnit','FontSize',16);
ylim([-3-0.1 12+0.1]) 
xlim([1-0.1 M+0.1]);
xticks(1:1:M); % Springer for hver opgave på x-aksen
yticks([-3 0 2 4 7 10 12]); % Springer for hver karakter på y-aksen
grid on
 
% Kode taget fra nedstående hjemmeside:
% https://se.mathworks.com/help/matlab/math/floating-point-numbers-within-specific-range.html
% Randomgenerator der giver et tal mellem -0.1 og 0.1, for at sprede
% punkterne i et punkt. Ellers vil de ligge oveni hinanden.
a = -0.1;
b = 0.1;
r = (b-a).*rand(height(grades),1) + a;

hold on   
for i = 1:width(grades)-2
    plot(i+r,grades{:,i+2}+r,'bx','MarkerSize',8); % Indtegner alle punkter for hver karakter i hver opgave i plot
end



