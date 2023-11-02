%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Forfatter : Ulrik Dan Hansen, s195091 
% Dato: 20. januar 2022
% Sted: Dansk Tekniske Univeristet
% Kursus: 02633 Introduktion til programmering og databehandling
% Dokument navn: displayMenu.m
% Projekt 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Denne funktion udregner slutkarakteren for hver studerende i M opgaver
function gradesFinal = computeFinalGrades(grades)

gradesFinal = zeros(1,height(grades));

M = length(3:width(grades));

for n = 1:height(grades)
    for i = 3:width(grades)
        if M == 1
            gradesFinal(n) = grades{n,3};  % En opgave givet - Slutkarakter samme som karakter for opgave
        elseif M > 1
            if  max(grades{n,3:i} == -3) == 1
                gradesFinal(n) = -3;       % Hvis der optræder et enkelt -3, får den studerende -3 i slutkarakter uanset hvad
            else
                gradesFinal(n) = (sum(grades{n,3:i}) - min(grades{n,3:i})) / (M-1); % Finder gennemsnit, samt trækker
                                                                                    % den mindste karakter fra
            end
        end
    end
end

