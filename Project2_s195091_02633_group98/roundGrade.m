%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Forfatter : Ulrik Dan Hansen, s195091 
% Dato: 20. januar 2022
% Sted: Dansk Tekniske Univeristet
% Kursus: 02633 Introduktion til programmering og databehandling
% Dokument navn: roundGrade.m
% Projekt 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Denne funktion afrunder efter at slutkarakteren er bestemt med
% computeFinalGrade-funktionen
function gradesRounded = roundGrade(grades)

gradesRounded = zeros(1,length(grades));

for i = 1:length(grades)
    if (-3 <= grades(i)) && (ceil(grades(i)) <= -2) 
        gradesRounded(i) = -3;
    elseif (-1.5 <= ceil(grades(i))) && (ceil(grades(i)) <= 1.5)
        gradesRounded(i) = 0;
    elseif (2 <= ceil(grades(i))) && (ceil(grades(i)) <= 3)
        gradesRounded(i) = 2;
    elseif (4 <= ceil(grades(i))) && (ceil(grades(i)) <= 5.5)
        gradesRounded(i) = 4;
    elseif (6 <= ceil(grades(i))) && (ceil(grades(i)) <= 8.5)
        gradesRounded(i) = 7;
    elseif (9 <= ceil(grades(i))) && (ceil(grades(i)) <= 10.5)
        gradesRounded(i) = 10;
    elseif (11 <= ceil(grades(i))) && (grades(i) <= 12)
        gradesRounded(i) = 12;
    end
end





