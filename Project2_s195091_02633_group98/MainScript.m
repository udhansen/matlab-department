%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Forfatter: Mikkel N. Schmidt, kode taget fra
% link: https://www.youtube.com/watch?v=zLb4ZHFfbO0
% Medforfatter : Ulrik Dan Hansen, s195091 
% Dato: 20. januar 2022
% Sted: Dansk Tekniske Univeristet
% Kursus: 02633 Introduktion til programmering og databehandling
% Dokument navn: MainScript.m
% Projekt 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Menu muligheder
menuItems = {'Indlæs ny data', 'Check for datafejl', 'Generér diagrammer', 'Vis statistik','Vis information om bestemt studerende', 'Luk program'};

% Sætter variabler til 'defualt'
filename = ''; 

while true
       
    userInput = displayMenu(menuItems);
  
    if userInput == 1 % 'Indlæs ny data'
      
       filename = input('Skriv filnavn: ', 's'); % Spørger bruger om filnavn
       % grades.csv - uden fejl - 5 opgaver
       % grades2.csv - med fejl
       % grades3.csv - uden fejl - 1 opgave
     
       % Tjekker om filnavn eksisterer i mappen. Kode fundet på nedstående
       % link:
       % https://se.mathworks.com/matlabcentral/answers/49414-check-if-a-file-exists
       if isfile(filename)
           grades = readtable(filename);
       else
           fprintf('Fil eksisterer ikke.\n');
       end
       
     elseif userInput == 2 % 'Check for datafejl'
        
        % tjekker om der er indtastet/indlæst en fil, hvis ikke: 
        % Giver bruger besked
        if strcmp(filename,'') == 1
            fprintf('Ingen data tilgænhgelig. Fil er ikke indlæst korrekt.\n');
        else
            
            % Spørger bruger om de vil tjekke for studienumre eller
            % karakterer
            n = inputNumber('Tryk 1 for tjek af indtastede studienummer\nTryk 2 for tjek af indtastede karakterer\nDit valg: '); 

            switch n
                case 1  
                        % Tæller hvor mange gange et studienummer optræder
                        tjekStudienummer = zeros(size(grades.StudentID));

                        for i = 1:height(grades.StudentID)

                            tjekStudienummer(i) = sum(strcmp(grades.StudentID,grades.StudentID{i}));

                            if tjekStudienummer(i) >= 2
                                fprintf('Dette studienummer forekommer flere gange: %s (linje: %d)\n', grades.StudentID{i}, i+1)
                            end 

                        end
                        
                        % Giver bruger besked hvis ingen studienumre
                        % optræder flere gange
                        if max(tjekStudienummer) == 1
                           fprintf('Ingen studienumre forekommer flere gange.\n');
                        end 

                case 2                                                                                                                                      
                        a = 0;
                        
                        % Tjekker om karakter i hver række og kolonne er
                        % angivet korrekt i forhold til 7-trinsskalaen
                        for n = 3:width(grades)
                            for i = 1:height(grades)
                                if (grades{i,n} == -3) || (grades{i,n} == 0) || (grades{i,n} == 2) || (grades{i,n} == 4) || (grades{i,n} == 7) || (grades{i,n} == 10) || (grades{i,n} == 12)
                                    a = a + 1;
                                    if sum(a) == (width(grades)-2)*(height(grades))
                                       fprintf('Alle karakterer er angivet korrekt.\n');
                                    end
                                else 
                                    fprintf('Denne studerendes karakterer er ikke gyldig (Linje: %d, kolonne: %d).\n', i+1, n);
                                end
                            end
                        end

                otherwise
                        fprintf('Ugyldig input. Prøv igen\n'); % Giver bruger besked, hvis der er tastet et ugyldigt input.
            end
        end
          
    elseif userInput == 3 % 'Generér diagrammer'
        
        % tjekker om der er indtastet/indlæst en fil, hvis ikke: 
        % Giver bruger besked
        if strcmp(filename,'') == 1
            fprintf('Ingen tilgængelige data. Fil er ikke indlæst korrekt.\n');
        else
            gradesPlot(grades); 
        end
                
    elseif userInput == 4 % 'Vis statistisk'
        
        %tjekker om der er indtastet/indlæst en fil, hvis ikke: 
        %Giver bruger besked
        if strcmp(filename,'') == 1
            fprintf('Ingen data tilgænhgelig. Fil er ikke indlæst korrekt.\n');
        else
             % Udregner slutkarakter for hver enkelt studerende med
             % funktionerne roundGrade og computeFinalGrade
             Slutkarakter = reshape(roundGrade(computeFinalGrades(grades)),height(grades),1);
             
             % Til visning af karakter for alle opgaver (max 5 kolonner, ellers vil table-funktion cise fx. 1x6 double)
             Opgaver = grades{:,3:width(grades)};
            
             % En tabel sammen med 'sortrows' der sorterer alle studerende
             % efter deres navn
             % Inspiration fra MatLab's egen hjemmeside: https://se.mathworks.com/help/matlab/ref/double.sortrows.html
             karakterListe = sortrows(table(Opgaver,Slutkarakter,'RowNames',grades.Name),'RowNames');
             
             % Vis karakterliste
             disp(karakterListe);
             
        end
        
    elseif userInput == 5 % 'Vis information om bestemt studerende'
            
            fprintf('Her ser du en liste over alle studienumre i systemet:\n');
            
            % Udskriver de mulige studienumre
            for i = 1:height(grades.StudentID)
               fprintf('%d. %s\n',i,grades.StudentID{i}); 
            end
        
            % Spørg bruger om studienummer
            findStudienummer = input('Indtast studienummeret på den studerende du ønsker at fremvise: ','s');
            
            % Udregner slutkarakter for den pågældende
            Slutkarakter = reshape(roundGrade(computeFinalGrades(grades)),height(grades),1);
            
            a = zeros(size(grades.StudentID));
            
            for i = 1:height(grades.StudentID) 
                
                % Sammenligner alle studienumre med det indtastede
                a(i) = strcmpi(grades.StudentID{i},findStudienummer);
                
                if a(i) == 1
                    fprintf('Studienr: %s\nNavn: %s\nSlutkarakter: %d\n', grades.StudentID{i}, grades.Name{i},Slutkarakter(i));
                    for n = 3:width(grades)
                        fprintf('Opgave %d: %d\n', n-2,grades{i,n});
                    end
                end
            end
            
            % Giver bruger besked hvis der ugyldigt input
            if max(a) == 0
                fprintf('Det indtastede studienummer findes ikke i systemet.\n');
            end
            
    elseif userInput == 6 % 'Luk program'
        break
        
    end
end
