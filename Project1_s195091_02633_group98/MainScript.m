%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Forfatter: Mikkel N. Schmidt, kode taget fra
% link: https://www.youtube.com/watch?v=zLb4ZHFfbO0
% Medforfatter : Ulrik Dan Hansen, s195091 
% Dato: 14. januar 2022
% Sted: Dansk Tekniske Univeristet
% Kursus: 02633 Introduktion til programmering og databehandling
% Dokument navn: MainScript.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

menuItems = {'Load data', 'Filter data', 'Display statistics', 'Generate plots', 'Quit'};

% Set variables to default
filename = '';                  % definer fil-navn
statistic = '';                 % definer statistik-type
filterSwitch = 'deactivated';   % 'flag', der bruges til at vise om filteret er aktivt
oldData = [];                   % Gemmer den oprindlige data-matrice uden filter

while true
       
    userInput = displayMenu(menuItems, filterSwitch);
  
    if userInput == 1
      
       filename = input('Enter the filename: ', 's'); % Spørger bruger om filnavn
     
       % Tjekker om filnavn eksisterer i mappen. Kode fundet på nedstående
       % link:
       % https://se.mathworks.com/matlabcentral/answers/49414-check-if-a-file-exists
       if isfile(filename)
           data = dataLoad(filename);
       else
           fprintf('File does not exist\n');
       end
        
       oldData = data; % Gemmer data-matrice retuneret fra funktionen dataLoad
       
    elseif userInput == 2
        
        % tjekker om der er indtastet/indlæst en fil, hvis ikke: 
        % Giver bruger besked
        if strcmp(filename,'') == 1
            fprintf('No data available. File is not loaded correctly.\n');
        else
            
            % Spørger bruger hvilket filter de ønsker at påsætte
            n = inputNumber('Press 1 for filtering for a specific bacteria\nPress 2 for filtering for a specific growth rate interval\nPress 3 to deactivate the current filter\nNumber: '); 

            switch n
                 case 1                                                             % Filter 1 - Sortér efter bakterie-type
                        data = oldData;                                             % Genindlæs data fra den generede fil, ellers vil den ikke generere rigtigt hvis dette gøres 2 gange i streg
                        BacteriaType = input('Enter a Bacteria Type: ', 's');       % Spørg om ønsket bakterie-type

                        if strcmpi(BacteriaType, 'Salmonella enterica')
                              filterSwitch = 'activated';                           % Sætter 'flag' = true
                              data(data(:,3) ~= 1, :) = [];                         % Fjerner alle rækker forskellig fra 1 i kolonne 3 i data-matrice
                        elseif strcmpi(BacteriaType, 'Bacillus cereus')
                              filterSwitch = 'activated';                           % Sætter 'flag' = true
                              data(data(:,3) ~= 2, :) = [];                         % Fjerner alle rækker forskellig fra 2 i kolonne 3 i data-matrice
                        elseif strcmpi(BacteriaType, 'Listeria')
                              filterSwitch = 'activated';                           % Sætter 'flag' = true
                              data(data(:,3) ~= 3, :) = [];                         % Fjerner alle rækker forskellig fra 3 i kolonne 3 i data-matrice
                        elseif strcmpi(BacteriaType, 'Brochothrix thermosphacta')
                              filterSwitch = 'activated';                           % Sætter 'flag' = true
                              data(data(:,3) ~= 4, :) = [];                         % Fjerner alle rækker forskellig fra 4 i kolonne 3 i data-matrice
                        else
                            fprintf('Invalid input. Try again\n');                  % Bruger skriver ugyldigt input.
                        end

                case 2                                                                                          % Filter 2 - Sortér efter growth rate interval    
                        data = oldData;                                                                         % Genindlæs data fra den generede fil
                        GRlower = input('Enter the lower limit for growth rate: ');                             % Angiv minimumsværdien for growth rate
                        GRupper = input('Enter the upper limit for growth rate: ');                             % Angiv maksimumsværdien for growth rate

                        while GRlower > GRupper                                                                 % Tjekker om maksimumsværdien er større end minumsværdien,
                            fprintf('The entered value is less than the lower limit. Please type again.\n');    % ellers vil programmet sortere forkert
                            GRupper = input('Enter the upper limit for growth rate: ');                         % Beder bruger at indtaste ny maksimumsværdi, hvis det er tilfældet
                        end

                        data(data(:,2) <= GRlower, :) = [];                 % Fjerner de rækker hvor værdierne i kolonne 2 er mindre end minimumsværdien for growth rate
                        data(data(:,2) >= GRupper, :) = [];                 % Fjerner de rækker hvor værdierne i kolonne 2 er større end maksimumsværdien for growth rate

                        filterSwitch = 'activated';                         % Sætter 'flag' = true 

                case 3                                                      % Deaktivering af filter
                        fprintf('Filter deactivated\n');
                        filterSwitch = 'deactivated';                       % Sætter 'flag' = false
                        data = oldData;                                     % Indlæser de gamle data fra funktionen dataLoad

                otherwise
                        fprintf('Invalid input. Try again\n');              % Giver bruger besked, hvis der er tastet et ugyldigt input
            end
        end
          
    elseif userInput == 3
        
        % tjekker om der er indtastet/indlæst en fil, hvis ikke: 
        % Giver bruger besked
        if strcmp(filename,'') == 1
            fprintf('No data available. File is not loaded correctly.\n');
        else
            
            % Spørger bruger om den ønskede statistik, samt en beskrivelse
            fprintf('type Mean temperature: to get the mean average of temperature\n');
            fprintf('type Mean growth rate: to get the mean average of growth rate\n');
            fprintf('type Std temperature: to get the standard deviation of temperature\n');
            fprintf('type Std growth rate: to get the standard deviation of growth rate\n');
            fprintf('type Rows: to get the total numbers of rows in the data\n');
            fprintf('type Mean Cold Growth rate: to get the mean growth rate when temperature is less than 20 degrees\n');
            fprintf('type Mean Hot Growth rate: to get the mean growth rate when temperature is greater than 50 degrees\n');
            
            statistic = input('Enter the desired statistic: ', 's');
            
            % Kalder funktionen dataStatistics til beregning
            result = dataStatistics(data, statistic);
            
            % Udskriver resultat
            if isnan(result)
                fprintf('Invalid input. Try again.\n');
            else
                fprintf('Here is your result of %s: %.2f\n', statistic, result);
            end
            
        end
                
    elseif userInput == 4
        
        % tjekker om der er indtastet/indlæst en fil, hvis ikke: 
        % Giver bruger besked
        if strcmp(filename,'') == 1
            fprintf('No data available. File is not loaded correctly.\n');
        else
             dataPlot(data); % skitsér data vha. funktionen dataPlot
        end
        
    elseif userInput == 5 % Luk program
        break
        
    end
end
